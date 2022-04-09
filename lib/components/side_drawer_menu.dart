import 'package:automation_system/constants.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideDrawerMenu extends StatelessWidget {
  const SideDrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.amber,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            DrawerHeader(
              child: ListTile(
                leading: CircleAvatar(
                  child: Image.asset("assets/images/user_3.png"),
                  //backgroundColor: Colors.purple,
                ),
                title: Text('مجمد محمد زاده'),
                subtitle: Text('هیات علمی واحد'),
                trailing: Icon(Icons.add_a_photo),
              ),
            ),
            ExpansionTile(
              backgroundColor: kBgDarkColor,
              initiallyExpanded: true,
              title: Text('کارتابل'),
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: Text('sdfdfsd'),
                ),

                //Expanded(
                //child:
                Container(
                  padding: const EdgeInsets.all(1),
                  height: SizeConfig.blockSizeHorizontal! * 10 * 0.25,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 24.0,
                    ),
                    label: const Text('ارجاع سریع'),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(1),
                  height: SizeConfig.blockSizeHorizontal! * 10 * 0.25,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 24.0,
                    ),
                    label: const Text('ارجاع سریع'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(1),
                  height: SizeConfig.blockSizeHorizontal! * 10 * 0.25,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 24.0,
                    ),
                    label: const Text('ارجاع سریع'),
                  ),
                ),
                //),
                ListTile(
                  hoverColor: Colors.deepOrange,
                  focusColor: Colors.blue,
                  selectedColor: Colors.deepOrange,
                  selected: true,
                  enabled: true,
                  onTap: null,
                  horizontalTitleGap: 0.0,
                  leading: SvgPicture.asset(
                    "assets/Icons/Inbox.svg",
                    color: Colors.white54,
                    height: 16,
                  ),
                  title: Text(
                    'بابا جان',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ],
            ),
            Text('کارتابل'),
            DrawerListTile(
              title: "جهت اقدام",
              svgSrc: "assets/Icons/Inbox.svg",
              press: () {},
            ),
            Container(
              color: Colors.blue,
              child: DrawerListTile(
                title: "استحضار",
                svgSrc: "assets/Icons/Inbox.svg",
                press: () {},
              ),
            ),
            DrawerListTile(
              title: "اطلاع",
              svgSrc: "assets/Icons/Inbox.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "امضا",
              svgSrc: "assets/Icons/Inbox.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "فوری",
              svgSrc: "assets/Icons/Inbox.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "خوانده شده",
              svgSrc: "assets/Icons/Inbox.svg",
              press: () {},
            ),
            //  ],
            //  ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Transaction",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Task",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Documents",
              svgSrc: "assets/icons/menu_doc.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Store",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Notification",
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Profile",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Settings",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerButtonItem {
  const DrawerButtonItem({
    Key? key,
    // For selecting those three line once press "Command+D"

    required this.title,
    required this.svgSrc,
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"

    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: Colors.amber,
      selected: true,
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
