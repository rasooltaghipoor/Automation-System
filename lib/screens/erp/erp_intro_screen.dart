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
            children: [
          Image.asset(
            "assets/icon/FaraYar.png",
            width: 40,
            height: 40,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'فرایار',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 15),
          Text(
            'سیستم اتوماسیون فرآیندی',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ]));
  }
}
