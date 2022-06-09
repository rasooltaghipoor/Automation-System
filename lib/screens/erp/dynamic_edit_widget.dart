import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:automation_system/constants.dart';
import 'package:automation_system/models/BuyModel.dart';
import 'package:automation_system/models/DynamicForm.dart';
import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/models/ReplyButtons.dart';
import 'package:automation_system/models/RequestData.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/screens/erp/erp_timeline.dart';
import 'package:automation_system/screens/erp/timeline_widget.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:automation_system/utils/useful_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

class DynamicEditWidget extends StatefulWidget {
  RequestData? itemData;
  bool? isEdit;
  bool? canEdit;
  Map<String, TextEditingController> controllerMap = Map();
  Map<String, String> dropDownMap = Map();
  List<FormItem> formItems = <FormItem>[];

  DynamicEditWidget({this.isEdit, this.canEdit, this.itemData, Key? key})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<DynamicEditWidget> {
  // Map<String, int> _listboxIndices = Map();
  DynamicFormModel? _formData;
  bool isEditEnabled = false;
  bool value = false;
  String filePath = "";
  TextEditingController descriptionController = TextEditingController();
  RequestStatus _requestStatus = RequestStatus.NotSend;
  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text("لطفا منتظر بمانید...")
    ],
  );
  final _processes = [
    'مدیر بخش',
    'مدیر کل',
    'معاون',
    'رییس',
    'آقای سهرابی',
    'علی',
    'نقی'
  ];

  Widget _requestOverviewBuilder() {
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
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.items.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  color: index % 2 == 0 ? Colors.blue[100] : Colors.blue[50],
                  width: 150,
                  child: Text(data.items[index].title + ":"),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                    padding: EdgeInsets.all(8),
                    color: index % 2 == 0 ? Colors.blue[100] : Colors.blue[50],
                    width: 150,
                    child: Text(widget.itemData!.requestDetails
                        .items[data.items[index].controlName])),
              ],
            );
          },
        );
      },
    );
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
        widget.formItems = data.items;

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.items.length,
          padding: const EdgeInsets.all(5),
          itemBuilder: (BuildContext context, int index) {
            if (data.items[index].control == 'textbox') {
              final controller =
                  _getControllerOf(data.items[index].controlName);

              final textField = TextField(
                enabled: isEditEnabled,
                controller: controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: data.items[index].title,
                ),
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
                    : null,
              );
              return Container(
                child: textField,
                padding: const EdgeInsets.only(bottom: 10),
              );
            } else if (data.items[index].control == 'listbox') {
              if (widget.dropDownMap[data.items[index].controlName] == null) {
                if (widget.isEdit!) {
                  widget.dropDownMap[data.items[index].controlName] = widget
                      .itemData!
                      .requestDetails
                      .items[data.items[index].controlName];
                } else {
                  widget.dropDownMap[data.items[index].controlName] =
                      data.items[index].dataType[0].title;
                }
              }
              return Row(children: <Widget>[
                Text(data.items[index].title,
                    style: TextStyle(
                      color: isEditEnabled ? Colors.black : Colors.grey,
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
                      onChanged: isEditEnabled
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
        controller.text = widget.itemData!.requestDetails.items[name];
      }
      widget.controllerMap[name] = controller;
    }
    return controller;
  }

  // Widget _okButton() {
  //   return ElevatedButton(
  //     onPressed: () async {
  //       Map<String, String> items = <String, String>{};
  //       for (FormItem listItem in _formData!.items) {
  //         if (listItem.control == 'textbox') {
  //           items[listItem.controlName] =
  //               _getControllerOf(listItem.controlName).text;
  //         } else if (listItem.control == 'listbox') {
  //           items[listItem.controlName] =
  //               widget.dropDownMap[listItem.controlName]!;
  //         }
  //       }

  //       // String jsonTutorial = jsonEncode(items);
  //       print(jsonEncode(items));
  //       sendFormData(context, jsonEncode(items));
  //     },
  //     child: widget.isEdit! ? const Text('ویرایش') : const Text('ارسال'),
  //   );
  // }

  void _pickFile() async {
    filePath = '';
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );

    // if no file is picked
    if (result == null) return;

    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
    filePath = result.files.first.path!;

    setState(() {});
  }

  List<Widget> getButtons(BuildContext context) {
    {
      final List<Widget> rowList = [];

      for (ReplyButtonData buttonData in widget.itemData!.buttonsData) {
        rowList.add(
          SizedBox(
              width: 140,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    bool isEdited = false;

                    Map<String, String> items = <String, String>{};
                    for (FormItem listItem in _formData!.items) {
                      if (isEditEnabled) {
                        if (listItem.control == 'textbox') {
                          items[listItem.controlName] =
                              widget.controllerMap[listItem.controlName]!.text;
                        } else if (listItem.control == 'listbox') {
                          items[listItem.controlName] =
                              widget.dropDownMap[listItem.controlName]!;
                        }
                      } else {
                        items[listItem.controlName] = widget.itemData!
                            .requestDetails.items[listItem.controlName];
                      }
                    }

                    for (String key in items.keys) {
                      if (items[key] !=
                          widget.itemData!.requestDetails.items[key]) {
                        isEdited = true;
                        break;
                      }
                    }

                    print(isEdited.toString() + '   ++++++++++++');

                    Map<String, dynamic> otherItems = {
                      'description': descriptionController.text,
                      'command': buttonData.cammandTitle,
                      'commandID': buttonData.commandID,
                      'editForm': isEdited.toString(),
                      'filePath': filePath,
                      'requestID': widget.itemData!.requestDetails.requestID
                    };

                    // // String jsonTutorial = jsonEncode(items);
                    print(jsonEncode(items));

                    setState(() {
                      // textHolder = '';
                      // errTextHolder = '';
                      _requestStatus = RequestStatus.Sending;
                    });
                    final Future<Map<String, dynamic>> successfulMessage =
                        sendReplyData(context, jsonEncode(items), otherItems);

                    successfulMessage.then((response) {
                      if (response['status']) {
                        setState(() {
                          _requestStatus = RequestStatus.Done;
                          _showAlertDialog('عملیات با موفقیت انجام شد', true);
                          getErpSideMenuData(context);
                          // textHolder = response['message'];
                        });
                      } else {
                        setState(() {
                          _requestStatus = RequestStatus.Done;
                          _showAlertDialog('عملیات نا موفق بود', false);
                          // errTextHolder = response['message'];
                        });
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: SharedVars.buttonColor,
                  ),
                  child: Text(buttonData.cammandTitle!))),
        );
      }
      // sendFormData(context, jsonEncode(items));
      return rowList;
    }
  }

  /// Generates the list of items for the history view
  List<Widget> getHistoryList() {
    final List<Widget> historyList = [];
    for (HistoryItems historyItem in widget.itemData!.history.items) {
      if (historyItem.command != 'منتظر بررسی') {
        historyList.add(Container(
            color: Colors.blue[50],
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ListTile(
                        leading: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blueGrey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Text(
                              historyItem.step,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        title: Text(
                          historyItem.userName,
                        ),
                        subtitle: Text(historyItem.roleTitle),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        'وضعیت: ' + historyItem.command,
                        style: TextStyle(),
                      ),
                    ),
                    Responsive.isDesktop(context)
                        ? SizedBox(
                            width: 100,
                            child: historyItem.editForm == 'False'
                                ? Text(
                                    'ویرایش شده: خیر',
                                    style: TextStyle(),
                                  )
                                : Text(
                                    'ویرایش شده: بله',
                                    style: TextStyle(),
                                  ),
                          )
                        : Text(''),
                    Text(historyItem.date),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('توضیحات: ' + historyItem.description),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('فایل ضمیمه: '),
                    historyItem.attachFile != 'True'
                        ? Text('ندارد')
                        : Image.network(
                            historyItem.fileUrl,
                            width: 200,
                            height: 200,
                          ),
                  ],
                ),
              ],
            )));
      }
    }
    return historyList;
  }

  Future _showUpdatedDialog(String path) {
    final alert = AlertDialog(
      title: const Text("تصویر"),
      content: Expanded(
          child: Image.network(
        path,
      )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("بستن"),
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
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Map<String, dynamic> params = <String, dynamic>{
                  "itemData": ErpMenuItemsData('all', 'کارتابل', '-1')
                };
                Provider.of<ChangeProvider>(context, listen: false)
                    .setMidScreen(ScreenName.messageList, params);
              },
              child: const Text("بستن"),
            ),
          ],
        ));
    return showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  void onEditClick() {
    Map<String, String> items = <String, String>{};
    for (FormItem listItem in _formData!.items) {
      if (listItem.control == 'textbox') {
        items[listItem.controlName] =
            widget.controllerMap[listItem.controlName]!.text;
      } else if (listItem.control == 'listbox') {
        items[listItem.controlName] = widget.dropDownMap[listItem.controlName]!;
      }
    }
    // String jsonTutorial = jsonEncode(items);
    print(jsonEncode(items));
    setState(() {
      // textHolder = '';
      // errTextHolder = '';
      _requestStatus = RequestStatus.Sending;
    });
    final Future<Map<String, dynamic>> successfulMessage =
        editFormData(context, jsonEncode(items), 'filePath');

    successfulMessage.then((response) {
      if (response['status']) {
        setState(() {
          _requestStatus = RequestStatus.Done;
          _showAlertDialog('ویرایش با موفقیت انجام شد', true);
          // textHolder = response['message'];
        });
      } else {
        setState(() {
          _requestStatus = RequestStatus.Done;
          _showAlertDialog('خطا در ویرایش اطلاعات', false);
          // errTextHolder = response['message'];
        });
      }
    });
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
        widget.canEdit!
            ? Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ), //SizedBox
                  Checkbox(
                    value: this.value,
                    onChanged: (bool? value) {
                      setState(() {
                        this.value = value!;
                        isEditEnabled = !isEditEnabled;
                      });
                    },
                  ), //Text
                  const SizedBox(width: 5), //SizedBox
                  /** Checkbox Widget **/
                  const Text(
                    'ویرایش درخواست',
                    style: TextStyle(fontSize: 15.0),
                  ), //Checkbox
                ], //<Widget>[]
              )
            : const Text('امکان ویرایش داده ها وجود ندارد'),
        SizedBox(
          height: 5,
        ),
        widget.canEdit! && isEditEnabled
            ? _futureBuilder()
            : _requestOverviewBuilder(),
        Row(
          children: [
            const Text('فایل ضمیمه'),
            const SizedBox(
              width: 20,
            ),
            if (widget.itemData!.requestDetails.attachFile == 'True')
              GestureDetector(
                  onTap: () {
                    _showUpdatedDialog(mainUrl +
                        widget.itemData!.requestDetails.fileUrl +
                        Provider.of<AuthProvider>(context, listen: false)
                            .authUser
                            .token!);
                  },
                  child: Image.network(
                    mainUrl +
                        widget.itemData!.requestDetails.fileUrl +
                        Provider.of<AuthProvider>(context, listen: false)
                            .authUser
                            .token!,
                    width: 100,
                    height: 100,
                  ))
          ],
        ),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.blue[50],
          child: widget.itemData!.canReply == 'true'
              ? Column(
                  children: [
                    TextFormField(
                      controller: descriptionController,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: '',
                        labelText: 'توضیحات',
                      ),
                      onSaved: (String? value) {
                        descriptionController.text = value!;
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      // validator: (String? value) {
                      //   return value!.contains('@')
                      //       ? 'Do not use the @ char.'
                      //       : null;
                      // },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                            ? Image.file(
                                File(filePath),
                                width: 200,
                                height: 200,
                              )
                            : Text('بدون فایل ضمیمه'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _requestStatus == RequestStatus.Sending
                        ? loading
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: getButtons(context),
                          )
                  ],
                )
              : widget.itemData!.editable == 'true'
                  ? isEditEnabled
                      ? _requestStatus == RequestStatus.Sending
                          ? loading
                          : SizedBox(
                              width: 140,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary: SharedVars.buttonColor,
                                ),
                                onPressed: onEditClick,
                                child: Text('ویرایش درخواست'),
                              ),
                            )
                      : Container()
                  : const Text(
                      'امکان پاسخ گویی یا ویرایش برای شما میسر نمی باشد'),
        ),
        Responsive.isDesktop(context)
            ? Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6 / 3,
                child: Image.network(
                  'http://cms2.iau-neyshabur.ac.ir/api/Request/pnghistory/${SharedVars.requestID}?dir=horiz&rnd=${Random().nextInt(1000000)}',
                  // fit: BoxFit.fill,
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7 * 3,
                child: Image.network(
                  'http://cms2.iau-neyshabur.ac.ir/api/Request/pnghistory/${SharedVars.requestID}?dir=vert&rnd=${Random().nextInt(1000000)}',
                  // fit: BoxFit.fill,
                ),
              ),
        SizedBox(
          height: 10,
        ),
        Text('شرح سوابق'),
        Container(
          margin: EdgeInsets.all(10),
          child: Column(children: getHistoryList()),
        ),

        // Container(
        //   padding: EdgeInsets.all(10),
        //   // color: Colors.yellow[100],
        //   height: 250,
        //   // width: 700,
        //   child: ErpTimeline(widget.itemData!.historyChart.items),

        //   // ProcessTimeline(
        //   //     2, _processes, widget.itemData!.historyChart.items),
        // ),
      ],
    );
  }
}
