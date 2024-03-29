import 'dart:async';

import 'package:automation_system/constants.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/screens/main/components/middle_screem_selector.dart';
import 'package:automation_system/screens/main/components/navigation_bar.dart';
import 'package:automation_system/screens/main/components/main_header.dart';
import 'package:automation_system/screens/main/components/screen_header.dart';
import 'package:automation_system/screens/menu/erp_side_menu.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MainScreen extends StatelessWidget {
  bool _isFirstLoad = true;
  MainScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Shows an alert dialog containing a picture related to some event or person.
  Future _showFirstMessageDialog(BuildContext context, String path) async {
    await Future.delayed(const Duration(seconds: 1), () {
      double width = MediaQuery.of(context).size.width * 0.5;
      if (!Responsive.isDesktop(context))
        width = MediaQuery.of(context).size.width * 0.9;
      double height = width * 0.45;
      final alert = AlertDialog(
        title: const Text(
          "پیام روز",
          textAlign: TextAlign.center,
        ),
        content: Container(
            width: width,
            height: height,
            child: Image.network(
              path,
            )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("بستن"),
          ),
        ],
      );
      return showDialog(
        context: context,
        builder: (BuildContext context) => alert,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Perform some initial actions needed in the first App appearing (everyday)
    if (_isFirstLoad) {
      _isFirstLoad = false;
      _showFirstMessageDialog(context, mainUrl + 'erp/images/message.jpg');
      getErpSideMenuData(context);
      getUserRoles(context);
      Timer.periodic(const Duration(seconds: 60), (timer) {
        // print(timer.tick);
        getErpSideMenuData(context);
      });
    }

    SizeConfig().init(context);
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      // endDrawer: a side menu to be displayed in mobile platforms
      endDrawer: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: const ErpSideMenu(),
      ),
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: ScreenHeader(),
          ),
          ResponsiveVisibility(
            hiddenWhen: [Condition.largerThan(name: TABLET)],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      // Once the user clicks on the menu icon the menu will be appeared like a drawer
                      // Also we want to hide this menu icon on desktop
                      if (!Responsive.isDesktop(context))
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                        ),
                      if (!Responsive.isDesktop(context))
                        const SizedBox(width: 20),
                      Text(
                        'تاریخ:',
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                // Once our width is less then 1300 then it start showing errors
                // Now there is no error if our width is less then 1340
                Expanded(
                  flex: _size.width > 1340 ? 15 : 16,
                  child: Column(
                    children: [
                      ResponsiveVisibility(
                        hiddenWhen: [Condition.smallerThan(name: DESKTOP)],
                        child: Expanded(
                          flex: 1,
                          child: MainHeader(),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: MiddleScreenSelector(),
                      )
                    ],
                  ),
                ),
                ResponsiveVisibility(
                  hiddenWhen: const [Condition.smallerThan(name: DESKTOP)],
                  child: Expanded(
                    flex: _size.width > 1340 ? 3 : 4,
                    child: const ErpSideMenu(),
                  ),
                ),
              ],
            ),
          ),
          ResponsiveVisibility(
            hiddenWhen: const [Condition.largerThan(name: TABLET)],
            child: Expanded(
              flex: 1,
              child: MyNavigationBar(),
            ),
          ),
        ],
      ),
    );
  }
}
