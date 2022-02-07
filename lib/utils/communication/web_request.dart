import 'dart:convert';
import 'package:automation_system/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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
    return null;
  } else {
    throw Exception('Unable to fetch info from the REST API');
  }
}
