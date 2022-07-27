import 'dart:convert';
import 'dart:typed_data';
import 'package:automation_system/constants.dart';
import 'package:automation_system/models/Cartable.dart';
import 'package:automation_system/models/DynamicForm.dart';
import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/models/RequestData.dart';
import 'package:automation_system/models/RequestList.dart';
import 'package:automation_system/models/RequestMenu.dart';
import 'package:automation_system/models/UserRoles.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/cartable_provider.dart';
import 'package:automation_system/providers/menu_provider.dart';
import 'package:automation_system/providers/request_list_provider.dart';
import 'package:automation_system/utils/communication/connection_manager.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

/// Checks Internet connection
/*Future<void> checkNetConnection() async {
  SharedVars.isNetConnected = true;
  var connectivityResult = await (Connectivity().checkConnectivity());
  print('Network connection checked. Connected?');
  if (connectivityResult == ConnectivityResult.none) {
    print(connectivityResult);
    SharedVars.isNetConnected = false;
  }
  print(SharedVars.isNetConnected);
}*/

/// Reads requested form data from the server
Future<DynamicFormModel> getFormDetails(String? formID) async {
  final responseData = await getServerDataByGET('api/info/Form/$formID/');

  if (responseData['formid'] != null) {
    DynamicFormModel data = DynamicFormModel.fromMap(responseData);
    return data;
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads request list from the server
Future<void> getRequestList(BuildContext context) async {
  try {
    Map<String, dynamic> queryParameters = {
      'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
      'roleid': Provider.of<AuthProvider>(context, listen: false)
          .authUser
          .roleID, // EncryptionUtil().encryptContent(oldPassword),
    };

    final responseData =
        await getServerDataByPOST(queryParameters, 'api/Request/list/all');
    if (responseData['Result'] != null) {
      if (responseData['items'] != '') {
        RequestListModel data = RequestListModel.fromMap(responseData);
        // print('form id: ' + data.items[0].formName_F);
        Provider.of<RequestListProvider>(context, listen: false)
            .setRequestList(data, 'درخواست های من');
      } else {
        List<Request> items = [];
        RequestListModel data = RequestListModel(items);
        // print('form id: ' + data.items[0].formName_F);
        Provider.of<RequestListProvider>(context, listen: false)
            .setRequestList(data, 'درخواست های من');
      }
      //return data;
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } catch (e) {}
}

/// Reads requested data data from the server
Future<RequestData> getRequestDetails(BuildContext context) async {
  Map<String, dynamic> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
    'roleid': Provider.of<AuthProvider>(context, listen: false).authUser.roleID,
  };

  final responseData = await getServerDataByPOST(
      queryParameters, 'api/Request/ViewDetail2/${SharedVars.requestID}');
  RequestData data = RequestData.fromMap(responseData);
  // ignore: unnecessary_null_comparison
  if (data != null) {
    return data;
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads side menu items information from the server
Future<void> getErpSideMenuData(BuildContext context) async {
  try {
    Map<String, dynamic> queryParameters = {
      'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
      'roleid': Provider.of<AuthProvider>(context, listen: false)
          .authUser
          .roleID, // EncryptionUtil().encryptContent(oldPassword),
    };

    final responseData =
        await getServerDataByPOST(queryParameters, 'api/info/menu/main');

    if (responseData['menu'] != null) {
      // We deserialize read data but only use Date field for now
      ErpSideMenuModel data = ErpSideMenuModel.fromMap(responseData);
      Provider.of<ErpMenuProvider>(context, listen: false).setMenu(data);
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } catch (e) {}
}

/// Reads all messages from other user (Requests the player must reply to)
Future<void> getErpCartableData(
    BuildContext context, ErpMenuItemsData itemData) async {
  try {
    Map<String, dynamic> queryParameters = {
      'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
      'roleid': Provider.of<AuthProvider>(context, listen: false)
          .authUser
          .roleID, // EncryptionUtil().encryptContent(oldPassword),
    };

    final responseData = await getServerDataByPOST(
        queryParameters, 'api/Request/Messagelist/${itemData.id}');

    //FIXME: This kind of 'if' doesn't work if 'menu' not present
    if (responseData['Result'] != null) {
      if (responseData['items'] != '') {
        // We deserialize read data but only use Date field for now
        ErpCartableModel data = ErpCartableModel.fromMap(responseData);
        // print('name: ' + data.catableData[0].formName_F!);
        Provider.of<ErpCartableProvider>(context, listen: false)
            .setCartable(data, itemData.title!);
      } else {
        List<ErpCartableData> catableData = [];
        ErpCartableModel data = ErpCartableModel(catableData);
        Provider.of<ErpCartableProvider>(context, listen: false)
            .setCartable(data, itemData.title!);
      }
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } catch (e) {}
}

/// Reads all user roles
Future<UserRoleModel> getUserRoles(BuildContext context) async {
  Map<String, dynamic> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false)
        .authUser
        .userId, // EncryptionUtil().encryptContent(oldPassword),
  };

  final responseData =
      await getServerDataByPOST(queryParameters, 'api/Account/role/list');
  if (responseData != null) {
    UserRoleModel data = UserRoleModel.fromMap(responseData);
    SharedVars.userRoles = data;
    Provider.of<AuthProvider>(context, listen: false)
        .setRolesCount(data.rolesData.length);
    return data;
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads all kinds of request for the current user role
///
/// Returns a Future of [RequestMenuModel] object
Future<RequestMenuModel> getErpRequestMenu(BuildContext context) async {
  final responseData = await getServerDataByGET(
          'api/info/RequestFormType/${Provider.of<AuthProvider>(context, listen: false).authUser.roleID!}')
      as Map<String, dynamic>;
  if (responseData['RequestType'] != null) {
    // We deserialize read data but only use Date field for now
    RequestMenuModel data = RequestMenuModel.fromMap(responseData);
    return data;
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Sends all data filled by the user in a request form to the server
///
/// Paramerters: [jsonData] - the data to send, [priority]  - the priority, [filePath] - the image path if exists,
/// [fileBytes] - the image bytes if exists, [formNameE] - the requst form name
///
/// Returns: a [Map] containing a message from the server
Future<Map<String, dynamic>> sendFormData(
    BuildContext context,
    String jsonData,
    String priority,
    String filePath,
    Uint8List? fileBytes,
    String formName_E) async {
  var result;

  Map<String, String> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false).authUser.token!,
    // 'userid': Provider.of<AuthProvider>(context, listen: false).authUser.userId,
    'roleid':
        Provider.of<AuthProvider>(context, listen: false).authUser.roleID!,
    'items': jsonData,
    'Priority': priority,
  };

  var request = http.MultipartRequest(
      'POST', Uri.parse(mainUrl + 'api/Request/add/$formName_E'));
  request.fields.addAll(queryParameters);
  request.headers.addAll(<String, String>{
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  });
  // if (filePath != '') {
  //   request.files.add(http.MultipartFile('picture',
  //       File(filePath).readAsBytes().asStream(), File(filePath).lengthSync(),
  //       filename: filePath.split("/").last));
  // }
  if (filePath != '') {
    request.files.add(http.MultipartFile.fromBytes('picture', fileBytes!,
        filename: filePath.split("/").last));
  }

  final firstResponse = await request.send();
  var response = await http.Response.fromStream(firstResponse);

  final responseBody = utf8.decode(response.bodyBytes);
  final Map<String, dynamic> responseData = json.decode(responseBody);

  if (response.statusCode == 200) {
    if (responseData['Requestid'] != '-1') {
      result = {'status': true, 'message': responseData['Message']};
    } else {
      result = {
        'status': false,
        'message': SharedVars.error + responseData['Message']
      };
    }
  } else {
    result = {'status': false, 'message': responseData['Message']};
  }
  return result;
}

/// Send a request to the server to edit some information
///
/// Paramerters: [jsonData] - the data to send, [filePath] - the image path if exists,
Future<Map<String, dynamic>> editFormData(
    BuildContext context, String jsonData, String filePath) async {
  var result;

  Map<String, String> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false).authUser.token!,
    'roleid':
        Provider.of<AuthProvider>(context, listen: false).authUser.roleID!,
    'items': jsonData,
  };

  final response = await http.post(
    Uri.parse(mainUrl + 'api/Request/Edit/${SharedVars.requestID}'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: queryParameters,
  );

  final responseBody = utf8.decode(response.bodyBytes);
  final Map<String, dynamic> responseData = json.decode(responseBody);

  if (response.statusCode == 200) {
    if (responseData['Requestid'] != '-1') {
      result = {'status': true, 'message': responseData['Message']};
    } else {
      result = {
        'status': false,
        'message': SharedVars.error + responseData['Message']
      };
    }
  } else {
    result = {'status': false, 'message': responseData['Message']};
  }
  return result;
}

/// Send a user's response to a request
///
/// Paramerters: [itemsData] - detials of th  request, [otherData] - other Data :))
Future<Map<String, dynamic>> sendReplyData(BuildContext context,
    String itemsData, Map<String, dynamic> otherData) async {
  var result;

  Map<String, String> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false).authUser.token!,
    'Description': otherData['description'],
    'Roleid':
        Provider.of<AuthProvider>(context, listen: false).authUser.roleID!,
    'items': itemsData,
    'Command': otherData['command'],
    'Commandid': otherData['commandID'],
    'Editform': otherData['editForm'],
  };

  var request = http.MultipartRequest('POST',
      Uri.parse(mainUrl + 'api/Request/history/${SharedVars.historyID}'));
  request.fields.addAll(queryParameters);
  request.headers.addAll(<String, String>{
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  });
  if (otherData['filePath'] != '') {
    // request.files.add(http.MultipartFile(
    //     'picture',
    //     File(otherData['filePath']).readAsBytes().asStream(),
    //     File(otherData['filePath']).lengthSync(),
    //     filename: otherData['filePath'].split("/").last));

    request.files.add(http.MultipartFile.fromBytes(
        'picture', otherData['fileBytes'] as Uint8List,
        filename: otherData['filePath'].split("/").last));
  }

  final firstResponse = await request.send();
  var response = await http.Response.fromStream(firstResponse);

  final responseBody = utf8.decode(response.bodyBytes);
  final Map<String, dynamic> responseData = json.decode(responseBody);

  if (response.statusCode == 200) {
    if (responseData['Requestid'] != '-1') {
      result = {'status': true, 'message': responseData['Message']};
    } else {
      result = {
        'status': false,
        'message': SharedVars.error + responseData['Message']
      };
    }
  } else {
    result = {'status': false, 'message': responseData['Message']};
  }
  return result;
}
