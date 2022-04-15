import 'package:automation_system/constants.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/shared_vars.dart';
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
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RadioListTile<String>(
                  title: const Text('استاد'),
                  value: 'استاد',
                  contentPadding: EdgeInsets.only(left: 100, right: 100),
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
                  contentPadding: EdgeInsets.only(left: 100, right: 100),
                  groupValue: _character,
                  onChanged: (String? value) {
                    setState(() {
                      print('Manager is selected');
                      _character = value;
                    });
                  },
                ),
                Container(
                    height: SizeConfig.blockSizeHorizontal! * 80 * 0.25,
                    width: SizeConfig.safeBlockHorizontal! * 50,
                    padding: EdgeInsets.fromLTRB(
                        SizeConfig.safeBlockHorizontal! * 3,
                        SizeConfig.safeBlockHorizontal! * 5,
                        SizeConfig.safeBlockHorizontal! * 3,
                        SizeConfig.safeBlockHorizontal! * 3),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.safeBlockHorizontal! * 4),
                            ),
                            primary: SharedVars.buttonColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.safeBlockHorizontal!,
                                vertical: SizeConfig.safeBlockHorizontal!),
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: SharedVars.fontFamily,
                                fontSize: SharedVars.buttonFontSize,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/main_screen');
                        },
                        child: const Text('ادامه'))),
              ],
            ),
          ),
        ));
  }
}
