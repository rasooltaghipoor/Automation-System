import 'package:automation_system/models/Email.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';
import '../../../extensions.dart';

class ErpIntroScreen extends StatelessWidget {
  const ErpIntroScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  Here the shadow is not showing properly
    return Center(
        child: Column(
            //color: Colors.blue[100],
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
          Text(
            'فرایار',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(height: 20),
          Text(
            'سیستم مدیریت منابع دانشگاه آزاد اسلامی',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ]));
  }
}
