import 'package:flutter/material.dart';
import '../models/UserRoles.dart';

class SharedVars {
  // Some colors
  static const Color buttonColor = const Color(0xff6b8dcd); //(0xff28af62);
  static const Color appBarColor = const Color(0xff4d73c0);
  static const Color bottomNavigationActiveColor = const Color(0xff4d73c0);
  static const Color beginAppBarColor = const Color(0xff6b8dcd);
  static const Color headerColor = const Color(0xff6e90b0);

  // used font in some parts of ui
  static const String fontFamily = 'Koodak';

  static double? buttonFontSize;
  static String currentDate = "";
  static String contactNo = "";
  static String password = "";
  static String username = "";
  static bool isNetConnected = true;
  static String error = 'خطا: ';
  static bool isWebApp = false;

  static var userID = "";
  static var roleID = "";
  static var roleTitle = "";
  static var requestID = "";
  static var historyID = "";
  static var formNameF = "";
  static var formNameE = "";

  static var refreshPage = false;

  static UserRoleModel? userRoles;
}
