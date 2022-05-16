import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

/*void main() => runApp(MaterialApp(
    builder: (context, child) {
      return Directionality(textDirection: TextDirection.ltr, child: child!);
    },
    title: 'GNav',
    theme: ThemeData(
      primaryColor: Colors.grey[800],
    ),
    home: NavigationBar()));*/

class MyNavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        /*appBar: AppBar(
        elevation: 20,
        title: const Text('GoogleNavBar'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),*/
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: [
                    GButton(
                      backgroundColor: Colors.amber,
                      iconActiveColor: Colors.blue,
                      icon: LineIcons.book,
                      text: 'کارتابل',
                      onPressed: () {
                        Map<String, dynamic> params = <String, dynamic>{
                          "itemData": ErpMenuItemsData('all', 'کارتابل', '')
                        };
                        Provider.of<ChangeProvider>(context, listen: false)
                            .setMidScreen(ScreenName.messageList, params);
                      },
                    ),
                    GButton(
                      backgroundColor: Colors.amber,
                      iconActiveColor: Colors.blue,
                      icon: LineIcons.staylinked,
                      text: 'درخواست های من',
                      onPressed: () {
                        Map<String, dynamic> params = <String, dynamic>{
                          "param": ''
                        };
                        Provider.of<ChangeProvider>(context, listen: false)
                            .setMidScreen(ScreenName.requestList, params);
                      },
                    ),
                    GButton(
                      backgroundColor: Colors.amber,
                      iconActiveColor: Colors.blue,
                      icon: LineIcons.signature,
                      text: 'درخواست خرید',
                      onPressed: () {
                        Map<String, dynamic> params = <String, dynamic>{
                          'formName': 'Buy',
                          'title': 'درخواست خرید'
                        };
                        Provider.of<ChangeProvider>(context, listen: false)
                            .setMidScreen(ScreenName.requestMenuScreen, params);
                      },
                    ),
                    // GButton(
                    //   backgroundColor: Colors.amber,
                    //   iconActiveColor: Colors.blue,
                    //   icon: LineIcons.addressBook,
                    //   text: 'بایگانی',
                    // ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
