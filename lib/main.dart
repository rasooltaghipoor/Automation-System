import 'package:automation_system/models/User.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/cartable_provider.dart';
import 'package:automation_system/providers/menu_provider.dart';
import 'package:automation_system/providers/user_provider.dart';
import 'package:automation_system/screens/daily_reuest_screen.dart';
import 'package:automation_system/screens/login_screen.dart';
import 'package:automation_system/screens/main/main_screen.dart';
import 'package:automation_system/screens/role_screen.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_preference.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // This is the web app!
      SharedVars.isWebApp = true;
      /*SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);*/
    } else {
      SharedVars.isWebApp = false;
      // SystemChrome.setPreferredOrientations([
      //   DeviceOrientation.portraitUp,
      // ]);
    }

    Future<User> getUserData() => UserPreferences().getUser();

    //checkNetConnection();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => MenuProvider()),
          ChangeNotifierProvider(create: (_) => CartableProvider()),
        ],
        child: MaterialApp(
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
              fontFamily: 'Koodak',
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Login('309'),
            debugShowCheckedModeBanner: false,
            routes: {
              '/main_screen': (context) => MainScreen(),
              '/role_screen': (context) => DailyRequestScreen(),
              //'/login': (context) => Login(),
            }));
  }
}
