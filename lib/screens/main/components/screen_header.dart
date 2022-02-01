
import 'package:automation_system/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: kSecondaryColor,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Image.asset(
                      "assets/images/Logo Outlook.png"),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const[
                            Expanded(child: Text('رسول تقی پور')),
                            Expanded(child: Text('هیات علمی')),
                          ],
                        ),
                      ],
                    )
                ),
                Expanded(
                    flex: 5,
                    child: Row(
                    )
                ),
                Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          label: const Text('تنظیمات صفحه'),
                          onPressed: () {},
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.account_circle_rounded,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          label: const Text('تنظیمات کاربری'),
                          onPressed: () {},
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          label: const Text('درباره نرم افزار'),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.info,
                            color: Colors.blue,
                            size: 32.0,
                          ),
                          tooltip: 'درباره نرم افزار',
                          onPressed: () {

                          },
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ));
  }

}