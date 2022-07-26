import 'package:flutter/material.dart';

class ErpIntroScreen extends StatelessWidget {
  const ErpIntroScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
