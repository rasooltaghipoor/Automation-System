import 'package:automation_system/utils/communication/web_request.dart';
import 'package:flutter/cupertino.dart';

class User {
  String? userId;
  String? name;
  //String? user44name;
  String? roleID;
  String? defaultRole;
  String? profilePic;
  String? token;
  String? renewalToken;
  int? roleCount;

  User(
      {this.userId,
      this.name,
      //this.username,
      this.roleID,
      this.defaultRole,
      this.profilePic,
      this.token,
      this.renewalToken,
      this.roleCount});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['UserID'],
        name: responseData['username'],
        //username: responseData['UserID'],
        roleID: responseData['DefaultRoleid'],
        defaultRole: responseData['DefaultRole'],
        profilePic: responseData['profile'],
        token: responseData['token'],
        renewalToken: '',
        roleCount: 1); //responseData['renewal_token']);
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
