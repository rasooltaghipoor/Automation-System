import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:flutter/material.dart';
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
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
          color: kGrayColor,
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child:
                Row(
                  children: [
                    /*Expanded(child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF0D47A1),
                                  Color(0xFF1976D2),
                                  Color(0xFF42A5F5),
                                ],
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {},
                          child: const Text('نامه جدید'),
                        ),
                      ],
                    ),
                  ),),*/
                    Expanded(child: Container(
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
                      height: SizeConfig.blockSizeHorizontal! * 10 *
                          0.25,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('نامه جدید'),),
                    )
                    ),
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          height: SizeConfig.blockSizeHorizontal! * 10 *
                              0.25,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.pink,
                              size: 24.0,
                            ),
                            label: const Text('ارجاع سریع'),),
                        )
                    ),
                    Expanded(child: Container(
                      padding: const EdgeInsets.all(1),
                      height: SizeConfig.blockSizeHorizontal! * 10 *
                          0.25,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.assignment,
                          //color: Colors.pink,
                          size: 24.0,
                        ),
                        label: const Text('امضای سریع'),),
                    )
                    ),
                    Expanded(child: Container(
                      padding: const EdgeInsets.all(1),
                      height: SizeConfig.blockSizeHorizontal! * 10 *
                          0.25,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 24.0,
                        ),
                        label: const Text('بایگانی'),),
                    )
                    ),
                  ],
                ),),
              const Expanded(
                flex: 1,
                child: SizedBox(),),
              Expanded(
                flex: 3,
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: "جستجو",
                    fillColor: kBgLightColor,
                    filled: true,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(
                          kDefaultPadding * 0.75), //15
                      child: WebsafeSvg.asset(
                        "assets/Icons/Search.svg",
                        width: 24,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),),
        )
    );
  }
}
