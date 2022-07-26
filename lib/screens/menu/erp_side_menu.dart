import 'package:automation_system/constants.dart';
import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/models/User.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/providers/menu_provider.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'side_menu_item.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ErpSideMenu extends StatefulWidget {
  const ErpSideMenu({
    Key? key,
  }) : super(key: key);
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<ErpSideMenu> {
  int activeIndex = -1;
  final ScrollController _mycontroller2 = ScrollController();

  /// Waits for a while (some seconds) and then tries to load and show recieved messages
  void openMessageList(ErpMenuItemsData data) async {
    await Future.delayed(const Duration(seconds: 1), () {
      Map<String, dynamic> params = <String, dynamic>{"itemData": data};
      Provider.of<ChangeProvider>(context, listen: false)
          .setMidScreen(ScreenName.messageList, params);
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthProvider>(context, listen: false).authUser;
    return Container(
        height: double.infinity,
        padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
        color: kMenuColor,
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
                  // This [ListTile] shows the user's profile (username, role and photo)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: user.profilePic != null
                          ? NetworkImage(mainUrl + user.profilePic!)
                          : NetworkImage("assets/images/user_3.png"),
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
                  // Menu Items, We define a consumer (listener) for [ErpMenuProvider].
                  // This provides us the ability to update the menu every time new messages recieved
                  Consumer<ErpMenuProvider>(
                    builder: (context, menuModel, child) {
                      if (menuModel.sideMenu != null &&
                          menuModel.activeIndex < 0) {
                        // If cartabe data is available
                        if (int.parse(menuModel.sideMenu!.menuData[0].count!) >
                            0) {
                          menuModel.setActiveIndex(0, false);
                          openMessageList(menuModel.sideMenu!.menuData[0]);
                        }
                      }
                      return Column(
                        children: [
                          ExpansionTile(
                            backgroundColor: Colors.white,
                            initiallyExpanded: true,
                            title: const Text('کارتابل'),
                            children: <Widget>[
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    menuModel.setActiveIndex(0, false);
                                  });
                                  Map<String, dynamic> params =
                                      <String, dynamic>{
                                    "itemData": menuModel.sideMenu!.menuData[0]
                                  };
                                  SharedVars.refreshPage = true;
                                  Provider.of<ChangeProvider>(context,
                                          listen: false)
                                      .setMidScreen(
                                          ScreenName.messageList, params);
                                },
                                title: menuModel.sideMenu != null
                                    ? menuModel.sideMenu!.menuData[0].title
                                    : "...",
                                // TODO: All these default icons must be replaced with some related ones.
                                iconSrc: "assets/Icons/File.svg",
                                isActive:
                                    menuModel.activeIndex == 0 ? true : false,
                                itemCount: menuModel.sideMenu != null
                                    ? int.parse(
                                        menuModel.sideMenu!.menuData[0].count!)
                                    : 0,
                              ),
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    menuModel.setActiveIndex(1, false);
                                  });
                                  Map<String, dynamic> params =
                                      <String, dynamic>{
                                    "itemData": menuModel.sideMenu!.menuData[1]
                                  };
                                  SharedVars.refreshPage = true;
                                  Provider.of<ChangeProvider>(context,
                                          listen: false)
                                      .setMidScreen(
                                          ScreenName.messageList, params);
                                },
                                title: menuModel.sideMenu != null
                                    ? menuModel.sideMenu!.menuData[1].title
                                    : "...",
                                iconSrc: "assets/Icons/File.svg",
                                isActive:
                                    menuModel.activeIndex == 1 ? true : false,
                                itemCount: menuModel.sideMenu != null
                                    ? int.parse(
                                        menuModel.sideMenu!.menuData[1].count!)
                                    : 0,
                              ),
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    menuModel.setActiveIndex(2, false);
                                  });
                                  Map<String, dynamic> params =
                                      <String, dynamic>{
                                    "itemData": menuModel.sideMenu!.menuData[2]
                                  };
                                  SharedVars.refreshPage = true;
                                  Provider.of<ChangeProvider>(context,
                                          listen: false)
                                      .setMidScreen(
                                          ScreenName.messageList, params);
                                },
                                title: menuModel.sideMenu != null
                                    ? menuModel.sideMenu!.menuData[2].title
                                    : "...",
                                iconSrc: "assets/Icons/File.svg",
                                isActive:
                                    menuModel.activeIndex == 2 ? true : false,
                                itemCount: -1,
                              ),
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    menuModel.setActiveIndex(3, false);
                                  });
                                  Map<String, dynamic> params =
                                      <String, dynamic>{"param": ''};
                                  Provider.of<ChangeProvider>(context,
                                          listen: false)
                                      .setMidScreen(
                                          ScreenName.requestList, params);
                                },
                                title: menuModel.sideMenu != null
                                    ? menuModel.sideMenu!.menuData[3].title
                                    : "...",
                                iconSrc: "assets/Icons/File.svg",
                                isActive:
                                    menuModel.activeIndex == 3 ? true : false,
                                itemCount: menuModel.sideMenu != null
                                    ? int.parse(
                                        menuModel.sideMenu!.menuData[3].count!)
                                    : 0,
                              ),
                              SideMenuItem(
                                press: () {
                                  setState(() {
                                    menuModel.setActiveIndex(4, false);
                                  });
                                  Map<String, dynamic> params =
                                      <String, dynamic>{
                                    'formName': 'Buy',
                                    'title': 'درخواست جدید'
                                  };
                                  Provider.of<ChangeProvider>(context,
                                          listen: false)
                                      .setMidScreen(
                                          ScreenName.requestMenuScreen, params);
                                },
                                title: 'درخواست جدید',
                                iconSrc: "assets/Icons/File.svg",
                                isActive:
                                    menuModel.activeIndex == 4 ? true : false,
                                itemCount: -1,
                              ),
                              SideMenuItem(
                                press: () {},
                                title: "در دست اقدام",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: false,
                                itemCount: -1,
                              ),
                              SideMenuItem(
                                press: () {},
                                title: "پیگیری",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: false,
                                itemCount: -1,
                              ),
                              SideMenuItem(
                                press: () {},
                                title: "نامه ارسالی",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: false,
                                itemCount: -1,
                              ),
                              SideMenuItem(
                                press: () {},
                                title: "پیشنویس",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: false,
                                itemCount: -1,
                              ),
                            ],
                          ),
                          Consumer<AuthProvider>(
                              builder: (context, authModel, child) {
                            return authModel.authUser.roleCount! > 1
                                ? SideMenuItem(
                                    press: () {
                                      setState(() {
                                        menuModel.setActiveIndex(5, false);
                                      });
                                      Map<String, dynamic> params =
                                          <String, dynamic>{
                                        'formName': 'ChangeRole',
                                      };
                                      Provider.of<ChangeProvider>(context,
                                              listen: false)
                                          .setMidScreen(
                                              ScreenName.roleScreen, params);
                                    },
                                    title: 'تغییر نقش',
                                    iconSrc: "assets/Icons/File.svg",
                                    isActive: menuModel.activeIndex == 5
                                        ? true
                                        : false,
                                    itemCount: -1,
                                  )
                                : Text('');
                          }),
                          const SizedBox(height: kDefaultPadding),
                          SideMenuItem(
                            press: () {},
                            title: "جستجوی پیشرفته",
                            iconSrc: "assets/Icons/File.svg",
                            isActive: false,
                            itemCount: -1,
                          ),
                          SideMenuItem(
                            press: () {},
                            title: "تالار گفتگو",
                            iconSrc: "assets/Icons/File.svg",
                            isActive: false,
                            itemCount: -1,
                          ),
                          SideMenuItem(
                            press: () {},
                            title: "یادآوری",
                            iconSrc: "assets/Icons/File.svg",
                            isActive: false,
                            itemCount: -1,
                          ),
                          SideMenuItem(
                            press: () {},
                            title: "ایجاد نامه",
                            iconSrc: "assets/Icons/File.svg",
                            isActive: false,
                            itemCount: -1,
                          ),
                          SideMenuItem(
                            press: () {},
                            title: "صورت جلسات",
                            iconSrc: "assets/Icons/File.svg",
                            isActive: false,
                            itemCount: -1,
                          ),
                          SideMenuItem(
                            press: () {},
                            title: "بایگانی شخصی",
                            iconSrc: "assets/Icons/File.svg",
                            isActive: false,
                            itemCount: -1,
                          ),
                          SideMenuItem(
                            press: () {},
                            title: "الگوهای پیوست",
                            iconSrc: "assets/Icons/File.svg",
                            isActive: false,
                            itemCount: -1,
                          ),

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
