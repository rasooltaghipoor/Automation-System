import 'package:automation_system/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({
    Key? key,
  }) : super(key: key);
  @override
  _RoleScreenState createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  String? _character = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('انتخاب نقش'),
        ),
        body: Container(
            height: double.infinity,
            padding: const EdgeInsets.all(200),
            color: kBgLightColor,
            child: SafeArea(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RadioListTile<String>(
                      title: const Text('استاد'),
                      value: 'استاد',
                      groupValue: _character,
                      onChanged: (String? value) {
                        setState(() {
                          print('Teacher is selected');
                          _character = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('مدیر کل'),
                      value: 'مدیر کل',
                      groupValue: _character,
                      onChanged: (String? value) {
                        setState(() {
                          print('Manager is selected');
                          _character = value;
                        });
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/main_screen');
                        },
                        child: const Text('ادامه'))
                  ],
                ),
              ),
            )));
  }
}
