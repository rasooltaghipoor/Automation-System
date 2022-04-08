import 'package:automation_system/utils/communication/web_request.dart';
import 'package:flutter/cupertino.dart';

class User {
  int? userId;
  String? name;
  String? username;
  String? phone;
  String? type;
  String? token;
  String? renewalToken;

  User(
      {this.userId,
      this.name,
      this.username,
      this.phone,
      this.type,
      this.token,
      this.renewalToken});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        name: responseData['name'],
        username: responseData['email'],
        phone: responseData['phone'],
        type: responseData['type'],
        token: responseData['access_token'],
        renewalToken: responseData['renewal_token']);
  }
}

/// This class is responsible for deserilizing user data
class UserModel {
  List<UserData> userData;

  UserModel(this.userData);

  factory UserModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    //print(list.runtimeType);
    List<UserData> msgList = list.map((i) => UserData.fromMap(i)).toList();
    return UserModel(msgList);
  }
}

class UserData {
  String? name;
  String? roleID;
  String? role;
  String? img;

  UserData(this.name, this.roleID, this.role, this.img);

  factory UserData.fromMap(Map<String, dynamic> parsedJson) {
    return UserData(
      parsedJson['Name'],
      parsedJson['RoleID'],
      parsedJson['Role'],
      parsedJson['img'],
    );
  }
}
