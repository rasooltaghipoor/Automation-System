import 'package:automation_system/models/RequestMenu.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestMenuScreen extends StatelessWidget {
  final String? title;
  final Future<RequestMenuModel>? menuModel;

  RequestMenuScreen({Key? key, this.title, this.menuModel}) : super(key: key);

  // final items = Product.getProducts();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: FutureBuilder<RequestMenuModel>(
        future: menuModel,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RequestItemList(
                  menuModel: snapshot.data,
                  title: title,
                )
              :

              // return the ListView widget :
              const Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }
}

class RequestItemList extends StatelessWidget {
  RequestMenuModel? menuModel;
  String? title;

  RequestItemList({Key? key, this.menuModel, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return menuModel!.items.isEmpty
        ? const Text(
            'داده ای برای نمایش وجود ندارد',
            style: TextStyle(fontSize: 20),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                // The header will be here
                padding: const EdgeInsets.all(5),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                // The ListView
                child: ListView.builder(
                  padding: Responsive.isDesktop(context)
                      ? EdgeInsets.fromLTRB(
                          SizeConfig.safeBlockHorizontal! * 20,
                          1,
                          SizeConfig.safeBlockHorizontal! * 20,
                          1)
                      : EdgeInsets.all(10),
                  itemCount: menuModel!.items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      height: 100,
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: Colors.grey[200],
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.safeBlockHorizontal!,
                                vertical: SizeConfig.safeBlockHorizontal!),
                            textStyle: TextStyle(
                              fontSize: 18,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.library_books,
                              color: Colors.blueGrey,
                              size: SizeConfig.safeBlockHorizontal! * 4,
                            ),
                            Text(menuModel!.items[index].title!,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.blueGrey)),
                          ],
                        ),
                        onPressed: () {
                          Map<String, dynamic> items = <String, dynamic>{
                            'item': ''
                          };
                          Map<String, dynamic> params = <String, dynamic>{
                            'edit': false,
                            'itemData': items,
                          };
                          SharedVars.formNameE = menuModel!.items[index].id!;

                          Provider.of<ChangeProvider>(context, listen: false)
                              .setMidScreen(ScreenName.editRequest, params);
                        },
                      ),
                    );
                  },
                ),
              ),
              // Expanded(
              //     child: GridView.builder(
              //   // physics: NeverScrollableScrollPhysics(),
              //   // shrinkWrap: true,
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 10.0,
              //     mainAxisSpacing: 10.0,
              //   ),
              //   itemCount: menuModel!.items.length,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       padding:
              //           EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 10),
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(40),
              //             ),
              //             primary: Colors.blue,
              //             padding: EdgeInsets.symmetric(
              //                 horizontal: SizeConfig.safeBlockHorizontal!,
              //                 vertical: SizeConfig.safeBlockHorizontal!),
              //             textStyle: TextStyle(
              //                 fontSize: 20, fontWeight: FontWeight.normal)),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: <Widget>[
              //             Icon(
              //               Icons.library_books,
              //               color: Colors.white,
              //               size: SizeConfig.safeBlockHorizontal! * 4,
              //             ),
              //             Text(
              //               menuModel!.items[index].title!,
              //               textAlign: TextAlign.center,
              //             ),
              //           ],
              //         ),
              //         onPressed: () {
              //           Map<String, dynamic> items = <String, dynamic>{
              //             'item': ''
              //           };
              //           Map<String, dynamic> params = <String, dynamic>{
              //             'edit': false,
              //             'itemData': items,
              //           };
              //           SharedVars.formNameE = menuModel!.items[index].id!;

              //           Provider.of<ChangeProvider>(context, listen: false)
              //               .setMidScreen(ScreenName.editRequest, params);
              //         },
              //       ),
              //     );
              //   },
              // ))
            ],
          );
  }
}
