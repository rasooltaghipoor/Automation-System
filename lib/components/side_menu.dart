import 'package:automation_system/responsive.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../constants.dart';
import '../extensions.dart';
import 'side_menu_item.dart';
import 'tags.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
        color: kBgLightColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/Logo Outlook.png",
                        width: 46,
                      ),
                      const Spacer(),
                      // We don't want to show this close button on Desktop mood
                      if (!Responsive.isDesktop(context)) const CloseButton(),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  FlatButton.icon(
                    minWidth: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: kPrimaryColor,
                    onPressed: () {},
                    icon: WebsafeSvg.asset("assets/Icons/Edit.svg", width: 16),
                    label: const Text(
                      "ثبت نامه صادره",
                      style: TextStyle(color: Colors.white),
                    ),
                  ).addNeumorphism(
                    topShadowColor: Colors.white,
                    bottomShadowColor: const Color(0xFF234395).withOpacity(0.2),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  FlatButton.icon(
                    minWidth: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: kBgDarkColor,
                    onPressed: () {},
                    icon: WebsafeSvg.asset(
                        "assets/Icons/Download.svg", width: 16),
                    label: const Text(
                      "ثبت نامه وارده",
                      style: TextStyle(color: kTextColor),
                    ),
                  ).addNeumorphism(),
                  const SizedBox(height: kDefaultPadding * 2),
                  // Menu Items
                  SideMenuItem(
                    press: () {},
                    title: "کارتابل",
                    iconSrc: "assets/Icons/Inbox.svg",
                    isActive: true,
                    itemCount: 3,
                  ),
                  SideMenuItem(
                    press: () {},
                    title: "ارسال شده",
                    iconSrc: "assets/Icons/Send.svg",
                    isActive: false,
                  ),
                  SideMenuItem(
                    press: () {},
                    title: "پیش نویس",
                    iconSrc: "assets/Icons/File.svg",
                    isActive: false,
                  ),
                  SideMenuItem(
                    press: () {},
                    title: "حذف شده",
                    iconSrc: "assets/Icons/Trash.svg",
                    isActive: false,
                    showBorder: false,
                  ),

                  const SizedBox(height: kDefaultPadding * 2),
                  // Tags
                  const Tags(),
                ],
              ),
            ),
          ),
        ));
  }
}
