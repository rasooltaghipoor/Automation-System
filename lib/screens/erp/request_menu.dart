import 'package:automation_system/models/RequestMenu.dart';
import 'package:automation_system/providers/change_provider.dart';
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
                  padding: const EdgeInsets.all(10),
                  itemCount: menuModel!.items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: SizeConfig.safeBlockHorizontal! * 35,
                      height: SizeConfig.safeBlockHorizontal! * 35,
                      padding:
                          EdgeInsets.all(SizeConfig.safeBlockHorizontal! * 2),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.safeBlockHorizontal! * 4),
                            ),
                            primary: Colors.blue,
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.safeBlockHorizontal!,
                                vertical: SizeConfig.safeBlockHorizontal!),
                            textStyle: TextStyle(
                                fontSize: SharedVars.buttonFontSize! * 0.8,
                                fontWeight: FontWeight.bold)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.library_books,
                              color: Colors.white,
                              size: SizeConfig.safeBlockHorizontal! * 12,
                            ),
                            Text(
                              menuModel!.items[index].title!,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        onPressed: () {
                          Map<String, dynamic> params = <String, dynamic>{
                            'edit': false,
                            'itemData': '',
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
            ],
          );
  }
}
