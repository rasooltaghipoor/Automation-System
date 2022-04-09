import 'package:automation_system/screens/register/components/text_editor.dart';
import 'package:flutter/material.dart';

/*void main() {
  runApp(const IncomingLetterScreen());
}*/

class IncomingLetterScreen extends StatelessWidget {
  const IncomingLetterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              HtmlEditorExample(title: ''),
            ],
          ),
        ),
      ),
    );
  }
}
