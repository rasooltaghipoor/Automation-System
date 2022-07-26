import 'dart:convert';
import 'dart:typed_data';

import 'package:automation_system/models/DynamicForm.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/providers/menu_provider.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:automation_system/utils/useful_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

class DynamicEditForm extends StatefulWidget {
  Map<String, dynamic>? itemsData;
  bool? isEdit;
  DynamicEditForm({this.isEdit, this.itemsData, Key? key}) : super(key: key);

  @override
  _View2State createState() => _View2State();
}

class _View2State extends State<DynamicEditForm> {
  final formKey = new GlobalKey<FormState>();
  Map<String, TextEditingController> _controllerMap = Map();
  Map<String, String> _dropDownMap = Map();
  String filePath = '';
  Uint8List? fileBytes;
  String dropPriority = '0';
  RequestStatus _requestStatus = RequestStatus.NotSend;
  DynamicFormModel? _formData;
  Future<DynamicFormModel>? formData;

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text("لطفا منتظر بمانید...")
    ],
  );

  @override
  void initState() {
    super.initState();
    formData = getFormDetails(SharedVars.formNameE);
  }

  Widget _futureBuilder() {
    return FutureBuilder(
      future: formData,
      builder:
          (BuildContext context, AsyncSnapshot<DynamicFormModel?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!;
        _formData = data;

        return Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                data.formName_F,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.items.length,
                padding: const EdgeInsets.all(5),
                itemBuilder: (BuildContext context, int index) {
                  if (data.items[index].control == 'textbox') {
                    final controller =
                        _getControllerOf(data.items[index].controlName);

                    final textField = TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: data.items[index].title,
                      ),
                      validator: data.items[index].fill == 'True'
                          ? (value) =>
                              value!.isEmpty ? "لطفا فیلد را پر کنید" : null
                          : null,
                      keyboardType: data.items[index].dataType == 'digit'
                          ? TextInputType.number
                          : null,
                      inputFormatters: data.items[index].dataType == 'digit'
                          ? <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ]
                          : null,
                      readOnly: (data.items[index].dataType == 'date' ||
                              data.items[index].dataType == 'time')
                          ? true
                          : false,
                      onTap: data.items[index].dataType == 'date'
                          ? () async {
                              Jalali? picked = await showPersianDatePicker(
                                context: context,
                                initialDate: Jalali.now(),
                                firstDate: Jalali(1385, 8),
                                lastDate: Jalali(1450, 9),
                              );
                              if (picked != null) {
                                controller.text = picked.formatCompactDate();
                              }
                            }
                          : data.items[index].dataType == 'time'
                              ? () async {
                                  var picked = await showPersianTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (picked != null) {
                                    String hour = picked.hour.toString();
                                    if (hour.length < 2) hour = '0' + hour;
                                    String min = picked.minute.toString();
                                    if (min.length < 2) min = '0' + min;
                                    controller.text = hour + ':' + min;
                                  }
                                }
                              : null,
                    );
                    return Container(
                      child: textField,
                      padding: const EdgeInsets.only(bottom: 10),
                    );
                  } else if (data.items[index].control == 'listbox') {
                    if (_dropDownMap[data.items[index].controlName] == null) {
                      if (widget.isEdit!) {
                        _dropDownMap[data.items[index].controlName] =
                            widget.itemsData![data.items[index].controlName];
                      } else {
                        _dropDownMap[data.items[index].controlName] =
                            data.items[index].dataType[0].title;
                      }
                    }
                    return Row(children: <Widget>[
                      Text(data.items[index].title),
                      Container(
                          padding: EdgeInsets.all(20),
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
                            items: data.items[index].dataType
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
          ),
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
    return _requestStatus == RequestStatus.Sending
        ? loading
        : Container(
            width: 200,
            height: 60,
            child: ElevatedButton(
              onPressed: () async {
                final form = formKey.currentState;

                if (form!.validate()) {
                  form.save();

                  Map<String, String> items = <String, String>{};
                  for (FormItem listItem in _formData!.items) {
                    if (listItem.control == 'textbox') {
                      items[listItem.controlName] =
                          _getControllerOf(listItem.controlName).text;
                    } else if (listItem.control == 'listbox') {
                      items[listItem.controlName] =
                          _dropDownMap[listItem.controlName]!;
                    }
                  }

                  setState(() {
                    _requestStatus = RequestStatus.Sending;
                  });
                  final Future<Map<String, dynamic>> successfulMessage =
                      sendFormData(context, jsonEncode(items), dropPriority,
                          filePath, fileBytes, _formData!.formName_E);

                  successfulMessage.then((response) {
                    if (response['status']) {
                      setState(() {
                        _requestStatus = RequestStatus.Done;
                        _showAlertDialog('عملیات با موفقیت انجام شد', true);

                        getErpSideMenuData(context);
                      });
                    } else {
                      setState(() {
                        _requestStatus = RequestStatus.Done;
                        _showAlertDialog('عملیات نا موفق بود', false);
                      });
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: SharedVars.buttonColor,
              ),
              child: widget.isEdit!
                  ? const Text(
                      'ویرایش',
                      style: TextStyle(fontSize: 20),
                    )
                  : const Text('ارسال', style: TextStyle(fontSize: 20)),
            ));
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

  Future _showAlertDialog(String msg, bool isOK) {
    final alert = Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text("نتیجه"),
          content: Text(
            msg,
            style: TextStyle(color: isOK ? Colors.blue : Colors.red),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();

                Map<String, dynamic> params = <String, dynamic>{"param": ''};
                Provider.of<ChangeProvider>(context, listen: false)
                    .setMidScreen(ScreenName.requestList, params);
                Provider.of<ErpMenuProvider>(context, listen: false)
                    .setActiveIndex(3, true);
              },
              child: const Text("بستن"),
            ),
          ],
        ));
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => alert,
    );
  }

  void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(
      withData: true,
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    // if no file is picked
    if (result == null) return;

    fileBytes = result.files.first.bytes;
    filePath = result.files.first.name;

    setState(() {});
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.all(50),
        child: ListView(
          children: [
            Container(child: _futureBuilder()),
            Row(children: <Widget>[
              Text('اولویت: '),
              Container(
                  padding: EdgeInsets.all(5),
                  child: DropdownButton<String>(
                    value: dropPriority,
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
                        dropPriority = newValue!;
                      });
                    },
                    items: <Priority>[
                      Priority("0", "عادی"),
                      Priority("1", "فوری"),
                    ].map<DropdownMenuItem<String>>((Priority value) {
                      return DropdownMenuItem<String>(
                        value: value.id,
                        child: Text(value.title!),
                      );
                    }).toList(),
                  ))
            ]),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  height: 30,
                  child: ElevatedButton(
                      onPressed: _pickFile, child: Text('آپلود فایل')),
                ),
                const SizedBox(
                  width: 50,
                ),
                filePath.isNotEmpty
                    ? Image.memory(
                        Uint8List.fromList(fileBytes!),
                        width: 200,
                        height: 200,
                      )
                    : Text('بدون فایل ضمیمه'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _okButton(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class Priority {
  String? id;
  String? title;
  Priority(this.id, this.title);
}
