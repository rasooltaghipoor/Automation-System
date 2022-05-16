import 'package:automation_system/constants.dart';
import 'package:automation_system/models/UserRoles.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class RoleScreenWidget extends StatelessWidget {
//   final Future<UserRoleModel>? userRoleModel;

//   RoleScreenWidget({Key? key, this.userRoleModel}) : super(key: key);

//   // final items = Product.getProducts();
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Directionality(
//       textDirection: TextDirection.rtl,
//       child: FutureBuilder<UserRoleModel>(
//         future: userRoleModel,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) print(snapshot.error);
//           // if (snapshot.hasData) {
//           //   if (snapshot.data!.rolesData.length <= 1) {
//           //     Navigator.pushReplacementNamed(context, '/main_screen');
//           //   }
//           // }
//           return snapshot.hasData
//               ? RoleScreen()
//               :
//               // return the ListView widget :
//               const Center(child: CircularProgressIndicator());
//         },
//       ),
//     ));
//   }
// }

class RoleScreen extends StatefulWidget {
  RoleScreen({
    Key? key,
  }) : super(key: key);
  @override
  _RoleScreenState createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  String? _roleID = SharedVars.roleID;
  String? _roleTitle = SharedVars.roleTitle;

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
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  // The ListView
                  child: ListView(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: Responsive.isDesktop(context)
                            ? EdgeInsets.fromLTRB(
                                SizeConfig.safeBlockHorizontal! * 20,
                                1,
                                SizeConfig.safeBlockHorizontal! * 20,
                                1)
                            : EdgeInsets.all(10),
                        itemCount: SharedVars.userRoles!.rolesData.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<String>(
                            title: Text(SharedVars
                                .userRoles!.rolesData[index].roleTitle!),
                            // selected:
                            //     SharedVars.userRoles!.rolesData[index].roleID! ==
                            //         SharedVars.roleID,
                            value:
                                SharedVars.userRoles!.rolesData[index].roleID!,
                            contentPadding:
                                EdgeInsets.only(left: 100, right: 100),
                            groupValue: _roleID,
                            onChanged: (String? value) {
                              setState(() {
                                _roleID = value;
                                _roleTitle = SharedVars
                                    .userRoles!.rolesData[index].roleTitle!;
                                print('$_roleTitle is selected');
                              });
                            },
                          );
                        },
                      ),
                      Container(
                          height: Responsive.isDesktop(context)
                              ? SizeConfig.safeBlockHorizontal! * 12
                              : SizeConfig.safeBlockVertical! * 15,
                          width: SizeConfig.safeBlockHorizontal! * 50,
                          padding: Responsive.isDesktop(context)
                              ? EdgeInsets.fromLTRB(
                                  SizeConfig.safeBlockHorizontal! * 30,
                                  SizeConfig.safeBlockHorizontal! * 5,
                                  SizeConfig.safeBlockHorizontal! * 30,
                                  SizeConfig.safeBlockHorizontal! * 3)
                              : EdgeInsets.all(20),
                          // SizeConfig.safeBlockHorizontal! * 20,
                          // SizeConfig.safeBlockHorizontal! * 5,
                          // SizeConfig.safeBlockHorizontal! * 20,
                          // SizeConfig.safeBlockHorizontal! * 3),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary: SharedVars.buttonColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.safeBlockHorizontal!,
                                      vertical:
                                          SizeConfig.safeBlockHorizontal!),
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: SharedVars.fontFamily,
                                    fontSize: 30,
                                  )),
                              onPressed: () {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setRoleID(_roleID!, _roleTitle!);

                                Navigator.pushReplacementNamed(
                                    context, '/main_screen');
                              },
                              child: const Text('ادامه'))),
                    ],
                  ),
                ),
                // RadioListTile<String>(
                //   title: const Text('استاد'),
                //   value: 'استاد',
                //   contentPadding: EdgeInsets.only(left: 100, right: 100),
                //   groupValue: _roleID,
                //   onChanged: (String? value) {
                //     setState(() {
                //       print('Teacher is selected');
                //       _roleID = value;
                //     });
                //   },
                // ),
                // RadioListTile<String>(
                //   title: const Text('مدیر کل'),
                //   value: 'مدیر کل',
                //   contentPadding: EdgeInsets.only(left: 100, right: 100),
                //   groupValue: _roleID,
                //   onChanged: (String? value) {
                //     setState(() {
                //       print('Manager is selected');
                //       _roleID = value;
                //     });
                //   },
                // ),
              ],
            ),
          ),
        ));
  }
}
