import 'package:automation_system/screens/email/email_screen.dart';
import 'package:automation_system/screens/main/main_screen.dart';
import 'package:automation_system/screens/register/components/text_editor.dart';
import 'package:automation_system/screens/register/incoming_letter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Koodak',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}
