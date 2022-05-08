import 'package:automation_system/components/erp_side_menu.dart';
import 'package:automation_system/components/side_menu.dart';
import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/screens/main/components/middle_screem_selector.dart';
import 'package:automation_system/screens/main/components/navigation_bar.dart';
import 'package:automation_system/screens/main/components/main_header.dart';
import 'package:automation_system/screens/main/components/screen_header.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'components/list_of_emails.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Provider.of<AuthProvider>(context).login('309', '309');
    //getUserDetails2(context, '309');
    //getSideMenuData(context, '309');

    getErpSideMenuData(context);
    //getCartableData(context, MenuItemsData('همه نامه ها', '0', 'All'));
    SizeConfig().init(context);
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(),
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: ScreenHeader(),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                // Once our width is less then 1300 then it start showing errors
                // Now there is no error if our width is less then 1340
                /*Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: const EmailScreen(),
            ),*/
                Expanded(
                  flex: _size.width > 1340 ? 15 : 16,
                  child: Column(
                    children: const [
                      //ResponsiveVisibility(
                      //hiddenWhen: [Condition.smallerThan(name: DESKTOP)],
                      Expanded(
                        flex: 1,
                        child: MainHeader(),
                      ),
                      // ),
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
