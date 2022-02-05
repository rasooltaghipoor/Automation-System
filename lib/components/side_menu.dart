import 'package:automation_system/components/side_drawer_menu.dart';
import 'package:automation_system/responsive.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../constants.dart';
import '../extensions.dart';
import 'side_menu_item.dart';
import 'tags.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
        color: kBgLightColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingSmaller),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [

                  /*Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                          "assets/images/user_3.png"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const[
                          Text('محمد قلی زاده اصل'),
                          Text('هیات علمی'),
                        ],
                      ),
                    ],
                  ),*/
                  ListTile(
                    leading: CircleAvatar(
                      child: Image.asset(
                          "assets/images/user_3.png"),
                      //backgroundColor: Colors.purple,
                    ),
                    title: Text('مجمد محمد زاده'),
                    subtitle: Text('هیات علمی واحد'),
                    trailing: Icon(Icons.add_a_photo),
                  ),

                  const SizedBox(height: kDefaultPadding * 2),
                  // Menu Items
                  ExpansionTile(
                    backgroundColor: Colors.white,
                    initiallyExpanded: true,
                    title: const Text('کارتابل'),
                    children: <Widget>[
                      SideMenuItem(
                        press: () {
                          setState(() {
                            _activeIndex = 0;
                          });
                        },
                        title: "جهت اقدام",
                        iconSrc: "assets/Icons/File.svg",
                        isActive: _activeIndex == 0? true : false,
                        itemCount: 6,
                      ),
                      SideMenuItem(
                        press: () {
                          setState(() {
                            _activeIndex = 1;
                          });
                        },
                        title: "استحضار",
                        iconSrc: "assets/Icons/File.svg",
                        isActive: _activeIndex == 1? true : false,
                        itemCount: 2,
                      ),
                      SideMenuItem(
                        press: () {
                          setState(() {
                            _activeIndex = 2;
                          });
                        },
                        title: "اطلاع",
                        iconSrc: "assets/Icons/File.svg",
                        isActive: _activeIndex == 2? true : false,
                        itemCount: 3,
                      ),
                      SideMenuItem(
                        press: () {
                          setState(() {
                            _activeIndex = 3;
                          });
                        },
                        title: "امضا",
                        iconSrc: "assets/Icons/File.svg",
                        isActive: _activeIndex == 3? true : false,
                        itemCount: 13,
                      ),
                      SideMenuItem(
                        press: () {
                          setState(() {
                            _activeIndex = 4;
                          });
                        },
                        title: "فوری",
                        iconSrc: "assets/Icons/File.svg",
                        isActive: _activeIndex == 4? true : false,
                        itemCount: 1,
                      ),
                      SideMenuItem(
                        press: () {
                          setState(() {
                            _activeIndex = 5;
                          });
                        },
                        title: "خوانده شده",
                        iconSrc: "assets/Icons/File.svg",
                        isActive: _activeIndex == 5? true : false,
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  SideMenuItem(
                    press: () {
                      setState(() {
                        _activeIndex = 6;
                      });
                    },
                    title: "صورت جلسه",
                    iconSrc: "assets/Icons/File.svg",
                    isActive: _activeIndex == 6? true : false,
                  ),
                  SideMenuItem(
                    press: () {
                      setState(() {
                        _activeIndex = 7;
                      });
                    },
                    title: "بایگانی شخصی",
                    iconSrc: "assets/Icons/Trash.svg",
                    isActive: _activeIndex == 7? true : false,
                  ),
                  SideMenuItem(
                    press: () {
                      setState(() {
                        _activeIndex = 8;
                      });
                    },
                    title: "بایگانی اداری",
                    iconSrc: "assets/Icons/File.svg",
                    isActive: _activeIndex == 8? true : false,
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