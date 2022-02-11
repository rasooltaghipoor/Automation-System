import 'dart:convert';
import 'package:automation_system/constants.dart';
import 'package:automation_system/models/Cartable.dart';
import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/models/User.dart';
import 'package:automation_system/providers/cartable_provider.dart';
import 'package:automation_system/providers/menu_provider.dart';
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
