import 'dart:async';

import 'package:automation_system/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.userId!);
    prefs.setString("name", user.name!);
    prefs.setString("roleID", user.roleID!);
    prefs.setString("defaultRole", user.defaultRole!);
    prefs.setString("profilePic", user.profilePic!);
    prefs.setString("token", "token");
    prefs.setString("renewalToken", user.renewalToken!);

    print("object prefere");
    print(user.renewalToken);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString("userId");
    String? name = prefs.getString("name");
    String? roleID = prefs.getString("roleID");
    String? defaultRole = prefs.getString("defaultRole");
    String? profilePic = prefs.getString("profilePic");
    String? token = prefs.getString("token");
    String? renewalToken = prefs.getString("renewalToken");

    return User(
        userId: userId,
        name: name,
        roleID: roleID,
        defaultRole: defaultRole,
        profilePic: profilePic,
        token: token,
        renewalToken: renewalToken);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token!;
  }
}
