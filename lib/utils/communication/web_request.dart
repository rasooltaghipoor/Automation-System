import 'dart:convert';
import 'dart:io';
import 'package:automation_system/constants.dart';
import 'package:automation_system/models/BuyModel.dart';
import 'package:automation_system/models/Cartable.dart';
import 'package:automation_system/models/DynamicForm.dart';
import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/models/ReplyButtons.dart';
import 'package:automation_system/models/RequestData.dart';
import 'package:automation_system/models/RequestList.dart';
import 'package:automation_system/models/RequestMenu.dart';
import 'package:automation_system/models/User.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/cartable_provider.dart';
import 'package:automation_system/providers/menu_provider.dart';
import 'package:automation_system/providers/request_list_provider.dart';
import 'package:automation_system/providers/user_provider.dart';
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

/// Reads time table from the server specified by the url
///
/// [cid] (Department id), [mDate] (Specified date) and [sTime] (Hour in day) are used to complete the url
Future<dynamic> fetchTimeProgram(String cid, String mDate, String sTime) async {
  final response = await http.get(Uri.parse(
      mainUrl + '/TimesheetJSON.aspx?Cid=$cid&MDate=$mDate&Stime=$sTime'));
  debugPrint(
      mainUrl + '/TimesheetJSON.aspx?Cid=$cid&MDate=$mDate&Stime=$sTime');
  if (response.statusCode == 200) {
    //print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final parsed = json.decode(responseBody);
    return null; //**************************TimeProgram.fromMap(parsed);
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads requested form data from the server
Future<DynamicFormModel> getFormDetails(String? formID) async {
  final response =
      await http.get(Uri.parse(mainUrl + 'api/info/Form/$formID/'));
  print(mainUrl + 'api/info/Form/$formID/');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    if (responseData['formid'] != null) {
      DynamicFormModel data = DynamicFormModel.fromMap(responseData);

      // SharedVars.listBoxItemsMap.clear();
      // // Check for listboxes
      // for (FormItem formItem in data.items) {
      //   if (formItem.control == 'listbox') {
      //     final response2 = await http.get(
      //         Uri.parse(mainUrl + 'api/info/listbox/${formItem.dataType}/'));
      //     if (response2.statusCode == 200) {
      //       print(utf8.decode(response2.bodyBytes));
      //       final responseBody2 = utf8.decode(response2.bodyBytes);
      //       final responseData2 = json.decode(responseBody2);
      //       ListBoxItems listBoxItems = ListBoxItems.fromMap(responseData2);
      //       SharedVars.listBoxItemsMap[formItem.dataType] = listBoxItems;
      //     }
      //   }
      // }
      return data;
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads requested form data from the server
Future<FullDynamicForm> getFullFormDetails(String? formID) async {
  final response =
      await http.get(Uri.parse(mainUrl + 'api/info/FormFull/$formID/'));
  print(mainUrl + 'api/info/Form/$formID/');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    if (responseData['form'] != null) {
      FullDynamicForm data = FullDynamicForm.fromMap(responseData);
      print('form id: ' + data.forms[0].formID);

      return data;
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads requested form data from the server
Future<void> getRequestList(BuildContext context) async {
  Map<String, dynamic> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
    'roleid': Provider.of<AuthProvider>(context, listen: false)
        .authUser
        .roleID, // EncryptionUtil().encryptContent(oldPassword),
  };

  final response = await http.post(
    Uri.parse(mainUrl + 'api/Request/list/all'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: queryParameters,
  );

  print(mainUrl + 'api/Request/list/all');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    if (responseData['Result'] != null) {
      RequestListModel data = RequestListModel.fromMap(responseData);
      // print('form id: ' + data.items[0].formName_F);
      Provider.of<RequestListProvider>(context, listen: false)
          .setRequestList(data, 'درخواست های من');
      //return data;
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads requested form data from the server
Future<RequestData> getRequestDetails(BuildContext context) async {
  Map<String, dynamic> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
    'roleid': '9'
    //Provider.of<AuthProvider>(context, listen: false).authUser.roleID,
  };

  final response = await http.post(
    Uri.parse(mainUrl + 'api/Request/ViewDetail2/16'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: queryParameters,
  );

  print(mainUrl + 'api/Request/ViewDetail2/5');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    RequestData data = RequestData.fromMap(responseData);
    print('name: ' + data.history.items[0].roleTitle);
    print('chart: ' + data.historyChart.items[0].roleTitle);
    // if (responseData['items'] != null) {
    // RequestListModel data = RequestListModel.fromMap(responseData);
    // print('form id: ' + data.items[0].formName_F);

    // ignore: unnecessary_null_comparison
    if (data != null) {
      return data;
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads some data about current date from the server
Future<void> getUserDetails(String? userID) async {
  final response =
      await http.get(Uri.parse(mainUrl + 'api/Account/info/$userID/'));
  print(mainUrl + 'api/Account/info/$userID/');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    if (responseData['Result'] == 'OK') {
      // We deserialize read data but only use Date field for now
      UserModel data = UserModel.fromMap(responseData);
      print('name: ' + data.userData[0].name!);
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads some data about current date from the server
Future<void> getUserDetails2(BuildContext context, String? userID) async {
  final response =
      await http.get(Uri.parse(mainUrl + 'api/Account/info/$userID/'));
  print(mainUrl + 'api/Account/info/$userID/');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    if (responseData['Result'] == 'OK') {
      // We deserialize read data but only use Date field for now
      UserModel data = UserModel.fromMap(responseData);
      print('name: ' + data.userData[0].name!);
      Provider.of<UserProvider>(context, listen: false).setUser(data);
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads some data about current date from the server
Future<void> getErpSideMenuData(BuildContext context) async {
  Map<String, dynamic> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
    'roleid': Provider.of<AuthProvider>(context, listen: false)
        .authUser
        .roleID, // EncryptionUtil().encryptContent(oldPassword),
  };

  final response = await http.post(
    Uri.parse(mainUrl + 'api/info/menu/main'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: queryParameters,
  );

  print(mainUrl + 'api/info/menu/main');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    //FIXME: This kind of 'if' doesn't work if 'menu' not present
    if (responseData['menu'] != null) {
      // We deserialize read data but only use Date field for now
      ErpSideMenuModel data = ErpSideMenuModel.fromMap(responseData);
      print('name: ' + data.menuData[0].title!);
      Provider.of<ErpMenuProvider>(context, listen: false).setMenu(data);
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads some data about current date from the server
Future<void> getSideMenuData(BuildContext context, String userID) async {
  final response =
      await http.get(Uri.parse(mainUrl + 'api/Cartable/Count/$userID/'));
  print(mainUrl + 'api/Cartable/Count/$userID/');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    if (responseData['result'] == 'OK') {
      // We deserialize read data but only use Date field for now
      SideMenuModel data = SideMenuModel.fromMap(responseData);
      print('name: ' + data.menuData[0].title!);
      Provider.of<MenuProvider>(context, listen: false).setMenu(data);
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads some data about current date from the server
Future<List<MenuItemsData>> getSideMenuData2(String userID) async {
  final response =
      await http.get(Uri.parse(mainUrl + 'api/Cartable/Count/$userID/'));
  print(mainUrl + 'api/Cartable/Count/$userID/');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    if (responseData['result'] == 'OK') {
      // We deserialize read data but only use Date field for now
      SideMenuModel data = SideMenuModel.fromMap(responseData);
      print('name: ' + data.menuData[0].title!);
      return data.menuData;
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads some data about current date from the server
Future<void> getErpCartableData(
    BuildContext context, ErpMenuItemsData itemData) async {
  Map<String, dynamic> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
    'roleid': Provider.of<AuthProvider>(context, listen: false)
        .authUser
        .roleID, // EncryptionUtil().encryptContent(oldPassword),
  };

  final response = await http.post(
    Uri.parse(mainUrl + 'api/Request/Messagelist/${itemData.id}'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: queryParameters,
  );

  print(mainUrl + 'api/Request/Messagelist/${itemData.id}');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    //FIXME: This kind of 'if' doesn't work if 'menu' not present
    if (responseData['Result'] != null) {
      // We deserialize read data but only use Date field for now
      ErpCartableModel data = ErpCartableModel.fromMap(responseData);
      print('name: ' + data.catableData[0].formName_F!);
      Provider.of<ErpCartableProvider>(context, listen: false)
          .setCartable(data, itemData.title!);
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads some data about current date from the server
Future<void> getErpCartableData22(BuildContext context) async {
  Map<String, dynamic> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
    'roleid': Provider.of<AuthProvider>(context, listen: false)
        .authUser
        .roleID, // EncryptionUtil().encryptContent(oldPassword),
  };

  final response = await http.post(
    Uri.parse(mainUrl + 'api/Request/Messagelist/all'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: queryParameters,
  );

  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    //FIXME: This kind of 'if' doesn't work if 'menu' not present
    if (responseData['Result'] != null) {
      // We deserialize read data but only use Date field for now
      ErpCartableModel data = ErpCartableModel.fromMap(responseData);
      print('name: ' + data.catableData[0].formName_F!);
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads some data about current date from the server
Future<void> getErpReplyButtons(BuildContext context) async {
  Map<String, dynamic> queryParameters = {
    // 'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
    'roleid': Provider.of<AuthProvider>(context, listen: false)
        .authUser
        .roleID, // EncryptionUtil().encryptContent(oldPassword),
  };

  final response = await http.post(
    Uri.parse(mainUrl + 'api/info/ReplyButton/ConsumBuy'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: queryParameters,
  );

  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    //FIXME: This kind of 'if' doesn't work if 'menu' not present
    if (responseData['Result'] != null) {
      // We deserialize read data but only use Date field for now
      SharedVars.replyButtons = ErpReplyButtonsModel.fromMap(responseData);
      print(SharedVars.replyButtons!.itemsData[0].cammandTitle);
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

/// Reads some data about current date from the server
Future<RequestMenuModel> getErpRequestMenu(BuildContext context) async {
  // Map<String, dynamic> queryParameters = {
  //   'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
  //   'roleid': Provider.of<AuthProvider>(context, listen: false)
  //       .authUser
  //       .roleID, // EncryptionUtil().encryptContent(oldPassword),
  // };

  final response = await http.get(
    Uri.parse(mainUrl + 'api/info/RequestForm/Type'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    // body: queryParameters,
  );

  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    //FIXME: This kind of 'if' doesn't work if 'menu' not present
    if (responseData['RequestType'] != null) {
      // We deserialize read data but only use Date field for now
      RequestMenuModel data = RequestMenuModel.fromMap(responseData);
      return data;
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

Future<void> getCartableData(
    BuildContext context, MenuItemsData itemData) async {
  final response = await http.get(Uri.parse(mainUrl +
      'api/Cartable/List/${SharedVars.username}?action=${itemData.action}'));
  print(mainUrl +
      'api/Cartable/List/${SharedVars.username}?action=${itemData.action}');
  if (response.statusCode == 200) {
    print(utf8.decode(response.bodyBytes));
    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);
    if (responseData['result'] == 'OK') {
      // We deserialize read data but only use Date field for now
      CartableModel data = CartableModel.fromMap(responseData);
      print('name: ' + data.catableData[0].fromTitle!);
      Provider.of<CartableProvider>(context, listen: false)
          .setCartable(data, itemData.title!);
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}

Future<void> testToken() async {
  var result;

  print('login...');
  final response = await http.get(
    Uri.parse(mainUrl + 'api/Test/test/Bearer'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'Authorization': 'Bearer 1213213mytoken'
      //'ApiKey': '1213213mytoken'
    },
  );
  /*final response = await get(
        Uri.parse(mainUrl + 'api/Account/login/$username?pass=$password'));*/
  // final response = await get(SharedVars.mainURL + '/LoginJSON.aspx?user=$email&pass=$password');
  print(response.body);
  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> responseData = json.decode(responseBody);
  }
}

Future<Map<String, dynamic>> sendFormData(
    BuildContext context, String jsonData) async {
  var result;

  Map<String, dynamic> queryParameters = {
    'token': Provider.of<AuthProvider>(context, listen: false).authUser.token,
    'userid': Provider.of<AuthProvider>(context, listen: false).authUser.userId,
    'roleid': Provider.of<AuthProvider>(context, listen: false).authUser.roleID,
    'items': jsonData,
    'Priority': '1',
  };

  final response = await http.post(
    Uri.parse(mainUrl + 'api/Request/add/ConsumBuy'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: queryParameters,
  );

  final responseBody = utf8.decode(response.bodyBytes);
  final Map<String, dynamic> responseData = json.decode(responseBody);

  print(responseData);

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
      Uri.parse(mainUrl + 'api/Request/history/${otherData['requestID']}'));
  request.fields.addAll(queryParameters);
  request.headers.addAll(<String, String>{
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  });
  if (otherData['filePath'] != '') {
    request.files.add(http.MultipartFile(
        'picture',
        File(otherData['filePath']).readAsBytes().asStream(),
        File(otherData['filePath']).lengthSync(),
        filename: otherData['filePath'].split("/").last));
  }

  final firstResponse = await request.send();
  var response = await http.Response.fromStream(firstResponse);

  // final response = await http.post(
  //   Uri.parse(mainUrl + 'api/Request/history/${otherData['requestID']}'),
  //   headers: <String, String>{
  //     'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  //   },
  //   body: queryParameters,
  // );

  final responseBody = utf8.decode(response.bodyBytes);
  final Map<String, dynamic> responseData = json.decode(responseBody);

  print(responseData);

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

// Future<void> getReplyButton(BuildContext context) async {
//   var result;

//   Map<String, dynamic> queryParameters = {
//     'roleid': Provider.of<AuthProvider>(context, listen: false).authUser.roleID,
//   };

//   final response = await http.post(
//     Uri.parse(mainUrl + 'api/info/ReplyButton/ConsumBuy'),
//     headers: <String, String>{
//       'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
//     },
//     body: queryParameters,
//   );

//   final responseBody = utf8.decode(response.bodyBytes);
//   final Map<String, dynamic> responseData = json.decode(responseBody);

//   print(responseData);

//   if (response.statusCode == 200) {
//     if (responseData['Result'] != null && responseData['Result'] != '-1') {
//       // We deserialize read data but only use Date field for now
//       CartableModel data = CartableModel.fromMap(responseData);
//       print('name: ' + data.catableData[0].fromTitle!);
//       Provider.of<CartableProvider>(context, listen: false)
//           .setCartable(data, itemData.title!);
//     } else {
//       throw Exception('Unable to fetch info from the REST API');
//     }
//   } else {
//     throw Exception('Unable to fetch info from the REST API');
//   }
// }

void send1(String filename) async {
  print('sending...');
  String filename2 = 'assets/images/Img_2.png';
  var request = http.MultipartRequest(
      'POST', Uri.parse(mainUrl + 'api/info/UploadTest/0'));
  request.files.add(http.MultipartFile('picture',
      File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
      filename: filename.split("/").last));
  request.files.add(http.MultipartFile('pictu2',
      File(filename2).readAsBytes().asStream(), File(filename2).lengthSync(),
      filename: filename2.split("/").last));
  var res = await request.send();
  print(res);
}

void send2(String filename) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse(mainUrl + 'api/info/UploadTest/0'));
  request.files.add(http.MultipartFile.fromBytes(
      'picture', File(filename).readAsBytesSync(),
      filename: filename.split("/").last));
  var res = await request.send();
}

void send3(String filename) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse(mainUrl + 'api/info/UploadTest/0'));
  request.files.add(await http.MultipartFile.fromPath('picture', filename));
  var res = await request.send();
}
