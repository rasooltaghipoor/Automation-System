import 'dart:async';
import 'package:automation_system/models/User.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/cartable_provider.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/providers/menu_provider.dart';
import 'package:automation_system/providers/request_list_provider.dart';
import 'package:automation_system/providers/user_provider.dart';
import 'package:automation_system/screens/login_screen.dart';
import 'package:automation_system/screens/main/main_screen.dart';
import 'package:automation_system/screens/erp/role_screen.dart';
import 'package:automation_system/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // *** We don't need this part for now. But, I keep it temporarily ***
    // if (kIsWeb) {
    //   // This is the web app!
    //   SharedVars.isWebApp = true;
    // } else {
    //   SharedVars.isWebApp = false;
    // }

    Future<User> getUserData() => UserPreferences().getUser();

    // *** This function is needed to check Internet connectivity in mobile platforms. Currently, it's not necessary but I keep it. ***
    //checkNetConnection();

    // Declare all required providers. These providers have some listeners in many parts of the application
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ErpMenuProvider()),
          ChangeNotifierProvider(create: (_) => ErpCartableProvider()),
          ChangeNotifierProvider(create: (_) => RequestListProvider()),
          ChangeNotifierProvider(create: (_) => ChangeProvider()),
        ],
        child: MaterialApp(
            // Initialize the responsive framework.
            builder: (context, widget) => ResponsiveWrapper.builder(
                  ClampingScrollWrapper.builder(context, widget!),
                  breakpoints: const [
                    ResponsiveBreakpoint.resize(350, name: MOBILE),
                    ResponsiveBreakpoint.autoScale(600, name: TABLET),
                    ResponsiveBreakpoint.resize(800, name: DESKTOP),
                    ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
                  ],
                ),
            title: '',
            theme: ThemeData(
              fontFamily: 'IranSans',
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Login(),
            debugShowCheckedModeBanner: false,
            routes: {
              '/main_screen': (context) => MainScreen(),
              '/role_screen': (context) => RoleScreen(),
              //'/login': (context) => Login(),
            }));
  }
}
