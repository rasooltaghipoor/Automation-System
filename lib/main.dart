import 'package:automation_system/models/User.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/menu_provider.dart';
import 'package:automation_system/providers/user_provider.dart';
import 'package:automation_system/screens/login_screen.dart';
import 'package:automation_system/screens/main/main_screen.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_preference.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    Future<User> getUserData() => UserPreferences().getUser();

    //checkNetConnection();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => MenuProvider()),
        ],
        child: MaterialApp(
            title: '',
            theme: ThemeData(
              fontFamily: 'Koodak',
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Login('309'),
            routes: {
              '/main_screen': (context) => MainScreen(),
              //'/login': (context) => Login(),
            }));
  }
}
