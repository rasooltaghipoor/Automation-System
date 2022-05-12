import 'dart:convert';

import 'package:automation_system/models/BuyModel.dart';
import 'package:automation_system/models/DynamicForm.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DynamicEditWidget extends StatefulWidget {
  Map<String, dynamic>? itemsData;
  bool? isEdit;
  Map<String, TextEditingController> controllerMap = Map();
  Map<String, String> dropDownMap = Map();
  List<FormItem> formItems = <FormItem>[];

  DynamicEditWidget({this.isEdit, this.itemsData, Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<DynamicEditWidget> {
  // Map<String, int> _listboxIndices = Map();
  DynamicFormModel? _formData;
  bool isEnabled = false;

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
        widget.formItems = data.items;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.items.length,
          padding: const EdgeInsets.all(5),
          itemBuilder: (BuildContext context, int index) {
            if (data.items[index].control == 'textbox') {
              final controller =
                  _getControllerOf(data.items[index].controlName);

              final textField = TextField(
                enabled: isEnabled,
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
              if (widget.dropDownMap[data.items[index].controlName] == null) {
                if (widget.isEdit!) {
                  widget.dropDownMap[data.items[index].controlName] =
                      widget.itemsData![data.items[index].controlName];
                } else {
                  widget.dropDownMap[data.items[index].controlName] =
                      data.items[index].dataType[0].title;
                }
              }
              return Row(children: <Widget>[
                Text(data.items[index].title,
                    style: TextStyle(
                      color: isEnabled ? Colors.black : Colors.grey,
                    )),
                Container(
                    padding:
                        EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 2),
                    child: DropdownButton<String>(
                      value: widget.dropDownMap[data.items[index].controlName],
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: isEnabled
                          ? (String? newValue) {
                              setState(() {
                                widget.dropDownMap[
                                    data.items[index].controlName] = newValue!;
                              });
                            }
                          : null,
                      items:
                          // SharedVars
                          //     .listBoxItemsMap[
                          //         data.forms[0].items[index].dataType]!
                          data.items[index].dataType
                              .map<DropdownMenuItem<String>>((ListItem value) {
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
        );
      },
    );
  }

  TextEditingController _getControllerOf(String name) {
    var controller = widget.controllerMap[name];
    if (controller == null) {
      controller = TextEditingController();
      if (widget.isEdit!) {
        print("_getControllerOf. is editting");
        controller.text = widget.itemsData![name];
      }
      widget.controllerMap[name] = controller;
    }
    return controller;
  }

  Widget _okButton() {
    return ElevatedButton(
      onPressed: () async {
        Map<String, String> items = <String, String>{};
        for (FormItem listItem in _formData!.items) {
          if (listItem.control == 'textbox') {
            items[listItem.controlName] =
                _getControllerOf(listItem.controlName).text;
          } else if (listItem.control == 'listbox') {
            items[listItem.controlName] =
                widget.dropDownMap[listItem.controlName]!;
          }
        }

        // String jsonTutorial = jsonEncode(items);
        print(jsonEncode(items));
        sendFormData(context, jsonEncode(items));
      },
      child: widget.isEdit! ? const Text('ویرایش') : const Text('ارسال'),
    );
  }

  @override
  void dispose() {
    widget.controllerMap.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: This line should be removed in the future
    SizeConfig().init(context);

    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                isEnabled = !isEnabled;
              });
            },
            child: Text('ویرایش')),
        _futureBuilder(),
      ],
    );
  }
}
