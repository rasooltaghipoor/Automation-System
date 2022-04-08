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
            color: kBgDarkColor,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    leading: Image.asset("assets/images/Logo Outlook.png"),
                    //backgroundColor: Colors.purple,
                    title: const Text('اتوماسیون یار'),
                    subtitle: const Text('برنامه اتوماسیون اداری هوشمند'),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('1400/02/24'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('صفحه اصلی'),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.blue,
                            size: 32.0,
                          ),
                          tooltip: 'تنظیمات کاربری',
                          onPressed: () {},
                        ),
                        /*ElevatedButton.icon(
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          label: const Text('درباره نرم افزار'),
                          onPressed: () {},
                        ),*/
                        IconButton(
                          icon: const Icon(
                            Icons.info,
                            color: Colors.blue,
                            size: 32.0,
                          ),
                          tooltip: 'درباره نرم افزار',
                          onPressed: () {},
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
