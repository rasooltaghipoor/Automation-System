import 'package:automation_system/components/side_drawer_menu.dart';
import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/models/User.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/change_provider.dart';
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

class ErpSideMenu extends StatefulWidget {
  const ErpSideMenu({
    Key? key,
  }) : super(key: key);
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<ErpSideMenu> {
  int _activeIndex = -1;
  final ScrollController _mycontroller2 = ScrollController();

  void openMessageList(ErpMenuItemsData data) async {
    await Future.delayed(const Duration(seconds: 2), () {
      Map<String, dynamic> params = <String, dynamic>{"itemData": data};
      Provider.of<ChangeProvider>(context, listen: false)
          .setMidScreen(ScreenName.messageList, params);
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthProvider>(context, listen: false).authUser;
    print('erp sidemenu...  ' + mainUrl + user.profilePic!);
    return Container(
        height: double.infinity,
        padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
        color: kBgLightColor,
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _mycontroller2,
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPaddingSmaller),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  const SizedBox(height: kDefaultPadding),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: user.profilePic != null
                          ? NetworkImage(mainUrl + user.profilePic!)
                          // ? Image.asset("assets/images/user_3.png")
                          : NetworkImage("assets/images/user_3.png"),
                      //backgroundColor: Colors.purple,
                    ),
                    title: user.name != null
                        ? Text(user.name!)
                        : const Text('نام کاربر'),
                    subtitle: user.defaultRole != null
                        ? Text(user.defaultRole!)
                        : const Text('نقش کاربر'),
                    trailing: Icon(Icons.add_a_photo),
                  ),

                  const SizedBox(height: kDefaultPadding),
                  // Menu Items
                  Consumer<ErpMenuProvider>(
                    builder: (context, menuModel, child) {
                      if (menuModel.sideMenu != null && _activeIndex < 0) {
                        // If cartabe data is available
                        if (int.parse(menuModel.sideMenu!.menuData[0].count!) >
                            0) {
                          _activeIndex = 0;
                          openMessageList(menuModel.sideMenu!.menuData[0]);
                        }
                      }
                      // else if my request data is available
                      //   } else if (int.parse(
                      //           menuModel.sideMenu!.menuData[3].count!) >
                      //       0) {
                      //     _activeIndex = 3;
                      //   }
                      // }
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
                                  // getErpCartableData(
                                  //     context, menuModel.sideMenu!.menuData[0]);
                                  Map<String, dynamic> params =
                                      <String, dynamic>{
                                    "itemData": menuModel.sideMenu!.menuData[0]
                                  };
                                  Provider.of<ChangeProvider>(context,
                                          listen: false)
                                      .setMidScreen(
                                          ScreenName.messageList, params);
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
                                  // getErpCartableData(
                                  //     context, menuModel.sideMenu!.menuData[1]);
                                  Map<String, dynamic> params =
                                      <String, dynamic>{
                                    "param": menuModel.sideMenu!.menuData[1]
                                  };
                                  Provider.of<ChangeProvider>(context,
                                          listen: false)
                                      .setMidScreen(
                                          ScreenName.messageList, params);
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
                                  // getErpCartableData(
                                  //     context, menuModel.sideMenu!.menuData[2]);
                                  Map<String, dynamic> params =
                                      <String, dynamic>{
                                    "param": menuModel.sideMenu!.menuData[2]
                                  };
                                  Provider.of<ChangeProvider>(context,
                                          listen: false)
                                      .setMidScreen(
                                          ScreenName.messageList, params);
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
                            ],
                          ),
                          const SizedBox(height: kDefaultPadding * 2),
                          SideMenuItem(
                            press: () {
                              setState(() {
                                _activeIndex = 3;
                              });
                              // getErpCartableData(
                              //     context, menuModel.sideMenu!.menuData[3]);
                              Map<String, dynamic> params = <String, dynamic>{
                                "param": ''
                              };
                              Provider.of<ChangeProvider>(context,
                                      listen: false)
                                  .setMidScreen(ScreenName.requestList, params);
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
                              // getErpCartableData(
                              //     context, menuModel.sideMenu!.menuData[1]);
                              Map<String, dynamic> params = <String, dynamic>{
                                'formName': 'Buy',
                                'title': 'درخواست خرید'
                              };
                              Provider.of<ChangeProvider>(context,
                                      listen: false)
                                  .setMidScreen(
                                      ScreenName.requestMenuScreen, params);
                            },
                            title: 'درخواست خرید',
                            iconSrc: "assets/Icons/File.svg",
                            isActive: _activeIndex == 4 ? true : false,
                            itemCount: -1,
                          ),
                          SideMenuItem(
                            press: () {
                              setState(() {
                                _activeIndex = 5;
                              });
                              // getErpCartableData(
                              //     context, menuModel.sideMenu!.menuData[1]);
                              Map<String, dynamic> params = <String, dynamic>{
                                'formName': 'ChangeRole',
                              };
                              Provider.of<ChangeProvider>(context,
                                      listen: false)
                                  .setMidScreen(
                                      ScreenName.requestMenuScreen, params);
                            },
                            title: 'تغییر نقش',
                            iconSrc: "assets/Icons/File.svg",
                            isActive: _activeIndex == 5 ? true : false,
                            itemCount: -1,
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

                          // const SizedBox(height: kDefaultPadding * 2),
                          // // Tags
                          // const Tags(),
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
