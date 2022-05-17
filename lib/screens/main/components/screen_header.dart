import 'package:automation_system/constants.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: SharedVars.appBarColor,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ListTile(
                leading: Image.asset("assets/icon/FaraYar.png"),
                //backgroundColor: Colors.purple,
                title: const Text(
                  'فرایار',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'مدیریت منابع سازمانی',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            // Expanded(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('تاریخ:'),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Text('صفحه اصلی'),
            //     ],
            //   ),
            // ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white70,
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
                        color: Colors.white70,
                        size: 32.0,
                      ),
                      tooltip: 'درباره نرم افزار',
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.exit_to_app_rounded,
                        color: Colors.white70,
                        size: 32.0,
                      ),
                      tooltip: 'خروج',
                      onPressed: () {},
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
