import 'dart:convert';

import 'package:automation_system/constants.dart';
import 'package:automation_system/models/DynamicForm.dart';
import 'package:automation_system/models/ReplyButtons.dart';
import 'package:automation_system/models/RequestData.dart';
import 'package:automation_system/models/RequestList.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/screens/erp/dynamic_edit_widget.dart';
import 'package:automation_system/screens/erp/timeline.dart';
import 'package:automation_system/screens/erp/timeline_widget.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewRequestScreen extends StatefulWidget {
  // final String title;
  // final String listTitle;
  final bool? canManage;

  ViewRequestScreen({Key? key, this.canManage}) : super(key: key);

  @override
  State<ViewRequestScreen> createState() => _ViewRequestScreenState();
}

class _ViewRequestScreenState extends State<ViewRequestScreen> {
  Future<RequestData>? itemData;
  // final items = Product.getProducts();

  @override
  void initState() {
    super.initState();
    itemData = getRequestDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: myCustomAppBar(title, SizeConfig.safeBlockVertical * 8, null),
        body: Center(
            child: Directionality(
      textDirection: TextDirection.rtl,
      child: FutureBuilder<RequestData>(
        future: itemData,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(canManage: widget.canManage, itemData: snapshot.data)
              :

              // return the ListView widget :
              const Center(child: CircularProgressIndicator());
        },
      ),
    )));
  }
}

class ItemList extends StatelessWidget {
  final _processes = [
    'مدیر بخش',
    'مدیر کل',
    'معاون',
    'رییس',
    'آقای سهرابی',
    'علی',
    'نقی'
  ];
  bool? canManage = false;
  final RequestData? itemData;
  DynamicEditWidget? dynamicEditWidget;
  TextEditingController descriptionController = TextEditingController();
  String filePath = "";

  ItemList({Key? key, this.canManage, this.itemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedVars.formNameE = itemData!.requestDetails.formName_E;
    dynamicEditWidget = DynamicEditWidget(
      isEdit: true,
      canEdit: itemData!.editable == 'true',
      itemData: itemData!,
    );

    // TODO Consider something to check in return statement
    return itemData! == null
        ? Text(
            'داده ای برای نمایش وجود ندارد',
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 4),
          )
        : ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.blue[50],
                // // The header will be here
                padding: EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //     color: SharedVars.headerColor,
                //     borderRadius: BorderRadius.all(
                //         Radius.circular(SizeConfig.safeBlockHorizontal! * 4))),
                child: Row(
                  children: [
                    Image.network(
                      mainUrl + itemData!.requestDetails.icon,
                      width: 35,
                      height: 35,
                    ),
                    Text(itemData!.requestDetails.formName_F),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 200,
                      // height: 100,
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: itemData!.requestDetails.profile !=
                                    null
                                ? NetworkImage(
                                    mainUrl + itemData!.requestDetails.profile)
                                // ? Image.asset("assets/images/user_3.png")
                                : NetworkImage("assets/images/user_3.png"),
                            //backgroundColor: Colors.purple,
                          ),
                          title: Text(itemData!.requestDetails.networkUser),
                          subtitle: Text(itemData!.requestDetails.title)),
                    ),
                  ],
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       Map<String, dynamic> params = <String, dynamic>{
              //         'edit': true,
              //         'itemData': itemData,
              //       };
              //       Provider.of<ChangeProvider>(context, listen: false)
              //           .setMidScreen(ScreenName.editRequest, params);
              //     },
              //     child: const Text('ویرایش درخواست')),
              Container(
                padding: EdgeInsets.all(10),
                // color: Colors.blue[50],
                child: dynamicEditWidget!,
              ),
              // Expanded(
              //   // The ListView
              //   child: ListView.builder(
              //     itemCount: itemData!.requestDetails.items.length,
              //     itemBuilder: (context, index) {
              //       return Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Text(
              //               itemData!.requestDetails.items.keys
              //                   .elementAt(index),
              //             ),
              //             const SizedBox(width: 20),
              //             Text(
              //               itemData!.requestDetails.items.values
              //                   .elementAt(index),
              //             ),
              //           ]);
              //     },
              //   ),
              // ),

              // )
            ],
          );
  }

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
  }

  List<Widget> getButtons(BuildContext context) {
    {
      final List<Widget> rowList = [];
      for (ReplyButtonData buttonData in itemData!.buttonsData) {
        rowList.add(ElevatedButton(
            onPressed: () {
              bool isEdited = false;

              Map<String, String> items = <String, String>{};
              for (FormItem listItem in dynamicEditWidget!.formItems) {
                if (listItem.control == 'textbox') {
                  items[listItem.controlName] = dynamicEditWidget!
                      .controllerMap[listItem.controlName]!.text;
                } else if (listItem.control == 'listbox') {
                  items[listItem.controlName] =
                      dynamicEditWidget!.dropDownMap[listItem.controlName]!;
                }
              }

              for (String key in items.keys) {
                if (items[key] != itemData!.requestDetails.items[key]) {
                  isEdited = true;
                  break;
                }
              }

              // print(isEdited.toString() + '   ++++++++++++');

              Map<String, dynamic> otherItems = {
                'description': descriptionController.text,
                'command': buttonData.cammandTitle,
                'commandID': buttonData.commandID,
                'editForm': isEdited.toString(),
                'filePath': filePath,
                // 'historyID': itemData!.requestDetails.requestID
              };

              sendReplyData(context, jsonEncode(items), otherItems);
              // // String jsonTutorial = jsonEncode(items);
              // print(jsonEncode(items));
            },
            child: Text(buttonData.cammandTitle!)));
      }
      // sendFormData(context, jsonEncode(items));
      return rowList;
    }
  }
}
