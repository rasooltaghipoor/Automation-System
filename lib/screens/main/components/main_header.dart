import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  /*const MainHeader({
    Key? key,
    this.isActive = true,
    this.email,
    this.press,
  }) : super(key: key);

  final bool? isActive;
  final Email? email;
  final VoidCallback? press;*/

  @override
  Widget build(BuildContext context) {
    //  Here the shadow is not showing properly
    return
        // Padding(
        //     padding: const EdgeInsets.symmetric(
        //         horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        // child:
        Directionality(
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
                        },
                        // icon: const Icon(
                        //   Icons.message,
                        //   color: Colors.white,
                        //   size: 20.0,
                        // ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          /*textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize:
                                SharedVars.buttonFontSize * 0.8,
                                fontWeight: FontWeight.bold)*/
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
                        },
                        icon: const Icon(
                          Icons.format_align_center,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          /*textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize:
                                SharedVars.buttonFontSize * 0.8,
                                fontWeight: FontWeight.bold)*/
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
                            'title': 'درخواست خرید'
                          };
                          Provider.of<ChangeProvider>(context, listen: false)
                              .setMidScreen(
                                  ScreenName.requestMenuScreen, params);
                        },
                        icon: const Icon(
                          Icons.sell,
                          //color: Colors.pink,
                          size: 20.0,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          /*textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize:
                                SharedVars.buttonFontSize * 0.8,
                                fontWeight: FontWeight.bold)*/
                        ),
                        label: const Text('درخواست خرید'),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('تاریخ: ')
                    // Container(
                    //   padding: const EdgeInsets.all(1),
                    //   height: 45,
                    //   width: 140,
                    //   child: ElevatedButton.icon(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Icons.save_outlined,
                    //       color: Colors.white,
                    //       size: 24.0,
                    //     ),
                    //     label: const Text('بایگانی'),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            /*const Expanded(
                  flex: 1,
                  child: SizedBox(),),*/
            // Expanded(
            //   flex: 3,
            //   child: TextField(
            //     onChanged: (value) {},
            //     decoration: InputDecoration(
            //       hintText: "جستجو",
            //       fillColor: kBgLightColor,
            //       filled: true,
            //       suffixIcon: Padding(
            //         padding: const EdgeInsets.all(kDefaultPadding * 0.75), //15
            //         child: WebsafeSvg.asset(
            //           "assets/Icons/Search.svg",
            //           width: 24,
            //         ),
            //       ),
            //       border: const OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //         borderSide: BorderSide.none,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
