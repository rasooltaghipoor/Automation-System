import 'package:automation_system/constants.dart';
import 'package:automation_system/models/RequestData.dart';
import 'package:automation_system/screens/erp/dynamic_edit_widget.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';

class ViewRequestScreen extends StatefulWidget {
  final bool? canManage;

  ViewRequestScreen({Key? key, this.canManage}) : super(key: key);

  @override
  State<ViewRequestScreen> createState() => _ViewRequestScreenState();
}

class _ViewRequestScreenState extends State<ViewRequestScreen> {
  Future<RequestData>? itemData;

  @override
  void initState() {
    super.initState();
    itemData = getRequestDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Directionality(
      textDirection: TextDirection.rtl,
      child: FutureBuilder<RequestData>(
        future: itemData,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(canManage: widget.canManage, itemData: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    )));
  }
}

class ItemList extends StatelessWidget {
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
            children: [
              Container(
                color: Colors.blue[50],
                // // The header will be here
                padding: EdgeInsets.all(10),
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
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: itemData!.requestDetails.profile !=
                                    null
                                ? NetworkImage(
                                    mainUrl + itemData!.requestDetails.profile)
                                : NetworkImage("assets/images/user_3.png"),
                          ),
                          title: Text(itemData!.requestDetails.networkUser),
                          subtitle: Text(itemData!.requestDetails.title)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: dynamicEditWidget!,
              ),
            ],
          );
  }
}
