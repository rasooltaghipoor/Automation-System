import 'dart:convert';

import 'package:automation_system/constants.dart';
import 'package:http/http.dart' as http;

/// Sends a POST request to the server and returns the response as a json object
Future<dynamic> getServerDataByPOST(
    Map<String, dynamic>? queryParameters, String url) async {
  try {
    final response = await http.post(
      Uri.parse(mainUrl + url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
      body: queryParameters,
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      // TODO: remove this print statement
      // print(responseBody);
      final responseData = json.decode(responseBody);
      return responseData;
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } catch (e) {}
}

/// Sends a GET request to the server and returns the response as a json object
Future<dynamic> getServerDataByGET(String url) async {
  try {
    final response = await http.get(
      Uri.parse(mainUrl + url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final responseData = json.decode(responseBody);
      return responseData;
    } else {
      throw Exception('Unable to fetch info from the REST API');
    }
  } catch (e) {}
}
