import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../constants.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: kMenuColor,
        child: Row(
          children: [
            ResponsiveVisibility(
              hiddenWhen: const [Condition.smallerThan(name: DESKTOP)],
              child: Expanded(
                flex: 6,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      /*decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),*/
                      height: 45,
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> params = <String, dynamic>{
                            "itemData": ErpMenuItemsData('all', 'کارتابل', '-1')
                          };
                          Provider.of<ChangeProvider>(context, listen: false)
                              .setMidScreen(ScreenName.messageList, params);
                          Provider.of<ErpMenuProvider>(context, listen: false)
                              .setActiveIndex(0, true);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                        ),
                        child: const Text('کارتابل'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      height: 45,
                      width: 140,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Map<String, dynamic> params = <String, dynamic>{
                            "param": ''
                          };
                          Provider.of<ChangeProvider>(context, listen: false)
                              .setMidScreen(ScreenName.requestList, params);
                          Provider.of<ErpMenuProvider>(context, listen: false)
                              .setActiveIndex(3, true);
                        },
                        icon: const Icon(
                          Icons.format_align_center,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                        ),
                        label: const Text('درخواست های من'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      height: 45,
                      width: 140,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Map<String, dynamic> params = <String, dynamic>{
                            'formName': 'Buy',
                            'title': 'درخواست جدید'
                          };
                          Provider.of<ChangeProvider>(context, listen: false)
                              .setMidScreen(
                                  ScreenName.requestMenuScreen, params);
                          Provider.of<ErpMenuProvider>(context, listen: false)
                              .setActiveIndex(4, true);
                        },
                        icon: const Icon(
                          Icons.sell,
                          size: 20.0,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                        ),
                        label: const Text('درخواست جدید'),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('تاریخ: ')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
