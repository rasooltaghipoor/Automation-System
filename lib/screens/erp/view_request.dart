import 'package:automation_system/constants.dart';
import 'package:automation_system/models/RequestData.dart';
import 'package:automation_system/models/RequestList.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/screens/erp/timeline.dart';
import 'package:automation_system/screens/erp/timeline_widget.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewRequestScreen extends StatelessWidget {
  // final String title;
  // final String listTitle;
  final Future<RequestData>? itemData;

  const ViewRequestScreen({Key? key, this.itemData}) : super(key: key);

  // final items = Product.getProducts();
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
              ? ItemList(itemData: snapshot.data)
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
  final RequestData? itemData;

  ItemList({Key? key, this.itemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO Consider something to check in return statement
    return itemData! == null
        ? Text(
            'داده ای برای نمایش وجود ندارد',
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal! * 4),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
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
              ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> params = <String, dynamic>{
                      'edit': true,
                      'itemData': itemData,
                    };
                    Provider.of<ChangeProvider>(context, listen: false)
                        .setMidScreen(ScreenName.editRequest, params);
                  },
                  child: const Text('ویرایش درخواست')),
              Expanded(
                // The ListView
                child: ListView.builder(
                  itemCount: itemData!.requestDetails.items.length,
                  itemBuilder: (context, index) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            itemData!.requestDetails.items.keys
                                .elementAt(index),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            itemData!.requestDetails.items.values
                                .elementAt(index),
                          ),
                        ]);
                  },
                ),
              ),
              ProcessTimeline(2, _processes, itemData!.historyChart.items),
            ],
          );
  }
}
