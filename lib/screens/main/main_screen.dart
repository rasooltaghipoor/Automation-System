import 'package:automation_system/components/side_menu.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/screens/email/email_screen.dart';
import 'package:automation_system/screens/main/components/email_gridview.dart';
import 'package:flutter/material.dart';
import 'components/list_of_emails.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        // Let's work on our mobile part
        mobile: const ListOfEmails(),
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
              child: const EmailGridView(),
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
