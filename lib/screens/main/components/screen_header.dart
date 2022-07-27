import 'package:automation_system/screens/login_screen.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';

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
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      "assets/icon/FaraYar.png",
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'فرایار',
                          style: TextStyle(color: Colors.white),
                        ),
                        const Text(
                          'سیستم اتوماسیون فرآیندی',
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                )),
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
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Login()),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
