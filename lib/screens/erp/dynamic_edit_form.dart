import 'dart:convert';

import 'package:automation_system/models/BuyModel.dart';
import 'package:automation_system/models/DynamicForm.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DynamicEditForm extends StatefulWidget {
  Map<String, dynamic>? itemsData;
  bool? isEdit;
  DynamicEditForm({this.isEdit, this.itemsData, Key? key}) : super(key: key);

  @override
  _View2State createState() => _View2State();
}

class _View2State extends State<DynamicEditForm> {
  Map<String, TextEditingController> _controllerMap = Map();
  Map<String, String> _dropDownMap = Map();
  // Map<String, int> _listboxIndices = Map();
  DynamicFormModel? _formData;

  // List<String> _data = [
  //   "one",
  //   "two",
  //   "three",
  //   "four",
  // ];
  // Future<List<String>> _retrieveData() {
  //   return Future.value(_data);
  // }

  // Fetch content from the json file
  Future<FullDynamicForm> readJson() async {
    final String response = await rootBundle.loadString('assets/test.json');
    // final responseBody = utf8.decode(response.bodyBytes);
    final parsed = json.decode(response);
    return FullDynamicForm.fromMap(parsed);
  }

  Widget _futureBuilder() {
    // SharedVars.formNameE = 'ConsumBuy';
    return FutureBuilder(
      //TODO: This fucntion must be called only when no data is available!!
      future: getFormDetails(SharedVars.formNameE),
      builder:
          (BuildContext context, AsyncSnapshot<DynamicFormModel?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!;
        _formData = data;

        // Save listbox data indices to use in future (This eliminates the future searchs for such indices)
        // int i = 0;
        // _listboxIndices.clear();
        // for (ListBoxItems item in data.listBoxItems) {
        //   _listboxIndices[item.listboxType] = i++;
        // }

        return Column(
          children: [
            Text(data.formName_F),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.items.length,
              padding: const EdgeInsets.all(5),
              itemBuilder: (BuildContext context, int index) {
                if (data.items[index].control == 'textbox') {
                  final controller =
                      _getControllerOf(data.items[index].controlName);

                  final textField = TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: data.items[index].title,
                    ),
                  );
                  return Container(
                    child: textField,
                    padding: const EdgeInsets.only(bottom: 10),
                  );
                } else if (data.items[index].control == 'listbox') {
                  // var dropDownValue = _getDropDownValue(
                  //     data.items[index].controlName,
                  //     SharedVars.listBoxItemsMap[data.items[index].dataType]!
                  //         .items[0].title);
                  if (_dropDownMap[data.items[index].controlName] == null) {
                    if (widget.isEdit!) {
                      _dropDownMap[data.items[index].controlName] =
                          widget.itemsData![data.items[index].controlName];
                    } else {
                      _dropDownMap[data.items[index].controlName] =
                          data.items[index].dataType[0].title;
                    }

                    // SharedVars
                    //     .listBoxItemsMap[
                    //         data.forms[0].items[index].dataType]!
                    //     .items[0]
                    //     .title;
                  }
                  return Row(children: <Widget>[
                    Text(data.items[index].title),
                    Container(
                        padding:
                            EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 3),
                        child: DropdownButton<String>(
                          value: _dropDownMap[data.items[index].controlName],
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _dropDownMap[data.items[index].controlName] =
                                  newValue!;
                            });
                          },
                          items:
                              // SharedVars
                              //     .listBoxItemsMap[
                              //         data.forms[0].items[index].dataType]!
                              data.items[index].dataType
                                  .map<DropdownMenuItem<String>>(
                                      (ListItem value) {
                            return DropdownMenuItem<String>(
                              value: value.title,
                              child: Text(value.title),
                            );
                          }).toList(),
                        )),
                  ]);
                } else {
                  return Container(
                    height: 20,
                    color: Colors.red,
                  );
                }
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
      controller = TextEditingController();
      if (widget.isEdit!) {
        print("_getControllerOf. is editting");
        controller.text = widget.itemsData![name];
      }
      _controllerMap[name] = controller;
    }
    return controller;
  }

  // String _getDropDownValue(String name, String initialValue) {
  //   var dropValue = _dropDownMap[name];
  //   if (dropValue == null) {
  //     dropValue = initialValue;
  //     _dropDownMap[name] = dropValue;
  //   }
  //   return dropValue;
  // }

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
        // String text = _controllerMap.values
        //     .where((element) => element.text != "")
        //     .fold("", (acc, element) => acc += "${element.text}\n");
        // await _showUpdatedDialog(text);

        // setState(() {
        //   _controllerMap.forEach((key, controller) {
        //     // get the index of original text
        //     int index = _controllerMap.keys.toList().indexOf(key);
        //     key = controller.text;
        //     _data[index] = controller.text;
        //   });
        // });
        Map<String, String> items = <String, String>{};
        for (FormItem listItem in _formData!.items) {
          if (listItem.control == 'textbox') {
            items[listItem.controlName] =
                _getControllerOf(listItem.controlName).text;
          } else if (listItem.control == 'listbox') {
            items[listItem.controlName] = _dropDownMap[listItem.controlName]!;
          }
        }

        // String jsonTutorial = jsonEncode(items);
        print(jsonEncode(items));
        sendFormData(context, jsonEncode(items));
      },
      child: widget.isEdit! ? const Text('ویرایش') : const Text('ارسال'),
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
    //TODO: This line should be removed in the future
    SizeConfig().init(context);

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
                  // _cancelOkButton(),
                  _okButton(),
                ],
              ))),
    );
  }
}
