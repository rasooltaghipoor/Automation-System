import 'package:automation_system/components/side_menu.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/screens/email/email_screen.dart';
import 'package:automation_system/screens/main/components/email_gridview.dart';
import 'package:automation_system/screens/main/components/navigation_bar.dart';
import 'package:automation_system/screens/main/components/main_header.dart';
import 'package:automation_system/screens/main/components/screen_header.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:flutter/material.dart';
import 'components/list_of_emails.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // It provide us the width and height
    Size _size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      //appBar: AppBar(),
      body: Responsive(
        // Let's work on our mobile part
        mobile: Column(
          children: [
            const Expanded(
              flex: 12,
              child: ListOfEmails(),
            ),
            Expanded(
              flex: 1,
              child: MyNavigationBar(),
            ),
          ],
        ),
        tablet: Row(
          children: const [
            Expanded(
              flex: 6,
              child: ListOfEmails(),
            ),
            Expanded(
              flex: 3,
              child: SideMenu(),
            ),
          ],
        ),
        desktop: Row(
          children: [
            // Once our width is less then 1300 then it start showing errors
            // Now there is no error if our width is less then 1340
            /*Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: const EmailScreen(),
            ),*/
            Expanded(
              flex: _size.width > 1340 ? 10 : 16,
              child: Column(children: const [
                Expanded(
                  flex: 1,
                  child: ScreenHeader(),),
                Expanded(
                  flex: 1,
                  child: MainHeader(),),
                Expanded(
                  flex: 10,
                  child: ListOfEmails(),)
              ],),

            ),
            Expanded(
              flex: _size.width > 1340 ? 2 : 4,
              child: const SideMenu(),
            ),
          ],
        ),
      ),
    );
  }
}
