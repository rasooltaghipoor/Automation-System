import 'package:automation_system/components/side_drawer_menu.dart';
import 'package:automation_system/providers/menu_provider.dart';
import 'package:automation_system/providers/user_provider.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPaddingSmaller),
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
                  Consumer<UserProvider>(
                    builder: (context, userModel, child) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: userModel.user != null
                              ? Image.network(
                                  mainUrl + userModel.user!.userData[0].img!)
                              : Image.asset("assets/images/user_3.png"),
                          //backgroundColor: Colors.purple,
                        ),
                        title: userModel.user != null
                            ? Text(userModel.user!.userData[0].name!)
                            : const Text('نام کاربر'),
                        subtitle: userModel.user != null
                            ? Text(userModel.user!.userData[0].role!)
                            : const Text('نقش کاربر'),
                        trailing: Icon(Icons.add_a_photo),
                      );
                    },
                  ),

                  const SizedBox(height: kDefaultPadding * 2),
                  // Menu Items
                  Consumer<MenuProvider>(
                    builder: (context, menuModel, child) {
                      return Column(
                        children: [
                          ExpansionTile(
                            backgroundColor: Colors.white,
                            initiallyExpanded: true,
                            title: const Text('کارتابل'),
                            /*leading: ListTile(
                      onTap: () {},
                      title: Text('sdfdfd'),
                    ),*/
                            children: <Widget>[
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    _activeIndex = 0;
                                  });
                                  getCartableData(context,
                                      menuModel.sideMenu!.menuData[0].action!);
                                },
                                title: menuModel.sideMenu != null
                                    ? menuModel.sideMenu!.menuData[0].title
                                    : "...",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: _activeIndex == 0 ? true : false,
                                itemCount: menuModel.sideMenu != null
                                    ? int.parse(
                                        menuModel.sideMenu!.menuData[0].count!)
                                    : 0,
                              ),
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    _activeIndex = 1;
                                  });
                                  getCartableData(context,
                                      menuModel.sideMenu!.menuData[1].action!);
                                },
                                title: menuModel.sideMenu != null
                                    ? menuModel.sideMenu!.menuData[1].title
                                    : "...",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: _activeIndex == 1 ? true : false,
                                itemCount: menuModel.sideMenu != null
                                    ? int.parse(
                                        menuModel.sideMenu!.menuData[1].count!)
                                    : 0,
                              ),
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    _activeIndex = 2;
                                  });
                                  getCartableData(context,
                                      menuModel.sideMenu!.menuData[2].action!);
                                },
                                title: menuModel.sideMenu != null
                                    ? menuModel.sideMenu!.menuData[2].title
                                    : "...",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: _activeIndex == 2 ? true : false,
                                itemCount: menuModel.sideMenu != null
                                    ? int.parse(
                                        menuModel.sideMenu!.menuData[2].count!)
                                    : 0,
                              ),
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    _activeIndex = 3;
                                  });
                                  getCartableData(context,
                                      menuModel.sideMenu!.menuData[3].action!);
                                },
                                title: menuModel.sideMenu != null
                                    ? menuModel.sideMenu!.menuData[3].title
                                    : "...",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: _activeIndex == 3 ? true : false,
                                itemCount: menuModel.sideMenu != null
                                    ? int.parse(
                                        menuModel.sideMenu!.menuData[3].count!)
                                    : 0,
                              ),
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    _activeIndex = 4;
                                  });
                                  getCartableData(context,
                                      menuModel.sideMenu!.menuData[4].action!);
                                },
                                title: menuModel.sideMenu != null
                                    ? menuModel.sideMenu!.menuData[4].title
                                    : "...",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: _activeIndex == 4 ? true : false,
                                itemCount: menuModel.sideMenu != null
                                    ? int.parse(
                                        menuModel.sideMenu!.menuData[4].count!)
                                    : 0,
                              ),
                              SideMenuItem(
                                  press: () {
                                    setState(() {
                                      _activeIndex = 5;
                                    });
                                    getCartableData(
                                        context,
                                        menuModel
                                            .sideMenu!.menuData[5].action!);
                                  },
                                  title: menuModel.sideMenu != null
                                      ? menuModel.sideMenu!.menuData[5].title
                                      : "...",
                                  iconSrc: "assets/Icons/File.svg",
                                  isActive: _activeIndex == 5 ? true : false,
                                  itemCount: menuModel.sideMenu != null
                                      ? int.parse(menuModel
                                          .sideMenu!.menuData[5].count!)
                                      : 0),
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    _activeIndex = 6;
                                  });
                                  getCartableData(context,
                                      menuModel.sideMenu!.menuData[6].action!);
                                },
                                title: menuModel.sideMenu != null
                                    ? menuModel.sideMenu!.menuData[6].title
                                    : "...",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: _activeIndex == 6 ? true : false,
                                itemCount: menuModel.sideMenu != null
                                    ? int.parse(
                                        menuModel.sideMenu!.menuData[6].count!)
                                    : 0,
                              ),
                            ],
                          ),
                          const SizedBox(height: kDefaultPadding * 2),
                          SideMenuItem(
                            press: () {
                              setState(() {
                                _activeIndex = 7;
                              });
                              getCartableData(context,
                                  menuModel.sideMenu!.menuData[7].action!);
                            },
                            title: menuModel.sideMenu != null
                                ? menuModel.sideMenu!.menuData[7].title
                                : "...",
                            iconSrc: "assets/Icons/File.svg",
                            isActive: _activeIndex == 7 ? true : false,
                            itemCount: menuModel.sideMenu != null
                                ? int.parse(
                                    menuModel.sideMenu!.menuData[7].count!)
                                : 0,
                          ),
                          SideMenuItem(
                            press: () {
                              setState(() {
                                _activeIndex = 8;
                              });
                              getCartableData(context,
                                  menuModel.sideMenu!.menuData[8].action!);
                            },
                            title: menuModel.sideMenu != null
                                ? menuModel.sideMenu!.menuData[8].title
                                : "...",
                            iconSrc: "assets/Icons/File.svg",
                            isActive: _activeIndex == 8 ? true : false,
                          ),
                          /*SideMenuItem(
                            press: () {
                              setState(() {
                                _activeIndex = 9;
                              });
                            },
                            title: "بایگانی اداری",
                            iconSrc: "assets/Icons/File.svg",
                            isActive: _activeIndex == 9 ? true : false,
                          ),*/

                          const SizedBox(height: kDefaultPadding * 2),
                          // Tags
                          const Tags(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
