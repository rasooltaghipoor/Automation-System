import 'package:automation_system/constants.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/request_list_provider.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
        body: SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  Icon(Icons.email),
                  const SizedBox(width: 5),
                  Consumer<RequestListProvider>(
                    builder: (context, requestListModel, child) {
                      return Text(
                        'تغییر نقش',
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockVertical! * 2,
                            color: const Color.fromARGB(255, 2, 19, 94),
                            fontWeight: FontWeight.w500),
                      );
                    },
                  ),
                  const Spacer(),
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {},
                    child: SvgPicture.asset(
                      "assets/Icons/Sort.svg",
                      width: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding),
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
                        title: Text(
                            SharedVars.userRoles!.rolesData[index].roleTitle!),
                        value: SharedVars.userRoles!.rolesData[index].roleID!,
                        contentPadding: EdgeInsets.only(left: 100, right: 100),
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
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: SharedVars.buttonColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.safeBlockHorizontal!,
                                  vertical: SizeConfig.safeBlockHorizontal!),
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: SharedVars.fontFamily,
                                fontSize: 30,
                              )),
                          onPressed: () {
                            Provider.of<AuthProvider>(context, listen: false)
                                .setRoleID(_roleID!, _roleTitle!);

                            Navigator.pushReplacementNamed(
                                context, '/main_screen');
                          },
                          child: const Text('ادامه'))),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
