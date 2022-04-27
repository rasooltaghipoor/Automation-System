import 'dart:convert';

import 'package:automation_system/models/DynamicForm.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class View2 extends StatefulWidget {
  const View2({Key? key}) : super(key: key);

  @override
  _View2State createState() => _View2State();
}

class _View2State extends State<View2> {
  Map<String, TextEditingController> _controllerMap = Map();

  List<String> _data = [
    "one",
    "two",
    "three",
    "four",
  ];
  Future<List<String>> _retrieveData() {
    return Future.value(_data);
  }

  // Fetch content from the json file
  Future<DynamicFormModel> readJson() async {
    final String response = await rootBundle.loadString('assets/test.json');
    // final responseBody = utf8.decode(response.bodyBytes);
    final parsed = json.decode(response);
    return DynamicFormModel.fromMap(parsed);
  }

  Widget _futureBuilder() {
    return FutureBuilder(
      future: getFormDetails('ConsumBuy'),
      builder:
          (BuildContext context, AsyncSnapshot<DynamicFormModel?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!;
        return Column(
          children: [
            Text(data.formName_F),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.items.length,
              padding: const EdgeInsets.all(5),
              itemBuilder: (BuildContext context, int index) {
                //***** final controller = _getControllerOf(data.items[index]);

                final textField = TextField(
                  //*****  controller: controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: data.items[index].title,
                  ),
                );
                return Container(
                  child: textField,
                  padding: const EdgeInsets.only(bottom: 10),
                );
              },
            ),
          ],
        );
      },
    );
  }

  TextEditingController _getControllerOf(String name) {
    var controller = _controllerMap[name];
    if (controller == null) {
      controller = TextEditingController(text: name);
      _controllerMap[name] = controller;
    }
    return controller;
  }

  Widget _cancelOkButton() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _cancelButton(),
        _okButton(),
      ],
    );
  }

  Widget _cancelButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _controllerMap.forEach((key, controller) {
            controller.text = key;
          });
        });
      },
      child: const Text("Cancel"),
    );
  }

  Widget _okButton() {
    return ElevatedButton(
      onPressed: () async {
        String text = _controllerMap.values
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");
        await _showUpdatedDialog(text);

        setState(() {
          _controllerMap.forEach((key, controller) {
            // get the index of original text
            int index = _controllerMap.keys.toList().indexOf(key);
            key = controller.text;
            _data[index] = controller.text;
          });
        });
      },
      child: const Text("OK"),
    );
  }

  Future _showUpdatedDialog(String text) {
    final alert = AlertDialog(
      title: const Text("Updated"),
      content: Text(text.trim()),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
    return showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  @override
  void dispose() {
    _controllerMap.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Dynamic Text Field with async",
            ),
          ),
          body: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Expanded(child: _futureBuilder()),
                  _cancelOkButton(),
                ],
              ))),
    );
  }
}
