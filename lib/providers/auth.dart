import 'dart:async';
import 'dart:convert';
import 'package:automation_system/constants.dart';
import 'package:automation_system/models/User.dart';
import 'package:automation_system/utils/shared_preference.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

enum PassStatus { Unchanged, Changing, Changed }

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  PassStatus _passStatus = PassStatus.Unchanged;
  User? _authUser;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;
  PassStatus get passStatus => _passStatus;
  User get authUser => _authUser!;

  void setRoleID(String roleID, String roleTitle) {
    _authUser!.roleID = roleID;
    _authUser!.defaultRole = roleTitle;
    SharedVars.roleID = roleID;
    SharedVars.roleTitle = roleTitle;
    UserPreferences().saveUser(_authUser!);
  }

  void setRolesCount(int count) {
    _authUser!.roleCount = count;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    var result;

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Map<String, String> queryParameters = {
      //'user': username,
      'pass': password //EncryptionUtil().encryptContent(password)
    };

    final response = await post(
      Uri.parse(mainUrl + 'api/Account/login/$username'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
      body: queryParameters,
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(responseBody);

      if (responseData['UserID'] != null) {
        _authUser = User.fromJson(responseData);
        _loggedInStatus = Status.LoggedIn;
        notifyListeners();
        result = {
          'status': true,
          'message': 'Successful',
          'user': _authUser,
        };

        SharedVars.username = username;
        SharedVars.password = password;
        SharedVars.userID = _authUser!.userId!;
        SharedVars.roleID = _authUser!.roleID!;
        SharedVars.roleTitle = _authUser!.defaultRole!;

        UserPreferences().saveUser(_authUser!);
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        result = {
          'status': false,
          'message': json.decode(response.body)['error']
        };
      }
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> changePassword(
      String oldPassword, String newPassword, String token) async {
    var result;

    _passStatus = PassStatus.Changing;
    notifyListeners();

    Map<String, String> queryParameters = {
      'Token': token,
      'Pass': oldPassword, // EncryptionUtil().encryptContent(oldPassword),
      'newPass': newPassword // EncryptionUtil().encryptContent(newPassword)
    };

    final response = await post(
      Uri.parse(mainUrl + '/ChangePassJSON.aspx'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
      body: queryParameters,
    );

    final responseBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> responseData = json.decode(responseBody);
    if (response.statusCode == 200) {
      if (responseData['Code'] == '1') {
        _passStatus = PassStatus.Changed;
        notifyListeners();
        result = {
          'status': true,
          'code': responseData['Code'],
          'message': responseData['Message']
        };
        SharedVars.password = newPassword;
      } else {
        _passStatus = PassStatus.Unchanged;
        notifyListeners();
        result = {
          'status': false,
          'code': responseData['Code'],
          'message': SharedVars.error + responseData['Message']
        };
      }
    } else {
      _passStatus = PassStatus.Unchanged;
      notifyListeners();
      result = {
        'status': false,
        'code': responseData['Code'],
        'message': responseData['Message']
      };
    }
    return result;
  }

  /*Future<Map<String, dynamic>> register(String email, String password, String passwordConfirmation) async {

    final Map<String, dynamic> registrationData = {
      'user': {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      }
    };
    return await post(Uri.parse(SharedVars.register),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }*/

  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
