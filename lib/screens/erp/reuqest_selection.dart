import 'package:automation_system/constants.dart';
import 'package:automation_system/models/RequestMenu.dart';
import 'package:automation_system/models/UserRoles.dart';
import 'package:automation_system/providers/auth.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/providers/request_list_provider.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/screens/erp/request_menu.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class RequestSelectionWidget extends StatelessWidget {
  final String? title;
  final Future<RequestMenuModel>? menuModel;

  RequestSelectionWidget({Key? key, this.title, this.menuModel})
      : super(key: key);

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
              ? RequestSelection(
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

class RequestSelection extends StatefulWidget {
  RequestMenuModel? menuModel;
  String? title;

  RequestSelection({Key? key, this.menuModel, this.title}) : super(key: key);

  @override
  _RequestSelectionState createState() =>
      _RequestSelectionState(menuModel!.items[0].id);
}

class _RequestSelectionState extends State<RequestSelection> {
  String? _requestTypeID;
  String? _requestTypeTitle;

  _RequestSelectionState(this._requestTypeID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('انتخاب درخواست'),
        // ),
        body: SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  Icon(Icons.email),
                  const SizedBox(width: 5),
                  Consumer<RequestListProvider>(
                    builder: (context, requestListModel, child) {
                      return Text(
                        widget.title!,
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockVertical! * 2,
                            color: const Color.fromARGB(255, 2, 19, 94),
                            fontWeight: FontWeight.w500),
                      );
                    },
                  ),
                  const Spacer(),
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {},
                    child: WebsafeSvg.asset(
                      "assets/Icons/Sort.svg",
                      width: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            Expanded(
              // The ListView
              child: ListView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: Responsive.isDesktop(context)
                        ? EdgeInsets.fromLTRB(
                            SizeConfig.safeBlockHorizontal! * 20,
                            1,
                            SizeConfig.safeBlockHorizontal! * 20,
                            1)
                        : EdgeInsets.all(10),
                    itemCount: widget.menuModel!.items.length,
                    itemBuilder: (context, index) {
                      return RadioListTile<String>(
                        title: Text(widget.menuModel!.items[index].title!),
                        // selected:
                        //     SharedVars.userRoles!.rolesData[index].roleID! ==
                        //         SharedVars.roleID,
                        value: widget.menuModel!.items[index].id!,
                        contentPadding: EdgeInsets.only(left: 100, right: 100),
                        groupValue: _requestTypeID,
                        onChanged: (String? value) {
                          setState(() {
                            _requestTypeID = value;
                            _requestTypeTitle =
                                widget.menuModel!.items[index].title!;
                            print('$_requestTypeTitle is selected');
                          });
                        },
                      );
                    },
                  ),
                  Container(
                      height: Responsive.isDesktop(context)
                          ? SizeConfig.safeBlockHorizontal! * 12
                          : SizeConfig.safeBlockVertical! * 15,
                      width: SizeConfig.safeBlockHorizontal! * 50,
                      padding: Responsive.isDesktop(context)
                          ? EdgeInsets.fromLTRB(
                              SizeConfig.safeBlockHorizontal! * 30,
                              SizeConfig.safeBlockHorizontal! * 5,
                              SizeConfig.safeBlockHorizontal! * 30,
                              SizeConfig.safeBlockHorizontal! * 3)
                          : EdgeInsets.all(20),
                      // SizeConfig.safeBlockHorizontal! * 20,
                      // SizeConfig.safeBlockHorizontal! * 5,
                      // SizeConfig.safeBlockHorizontal! * 20,
                      // SizeConfig.safeBlockHorizontal! * 3),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: SharedVars.buttonColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.safeBlockHorizontal!,
                                  vertical: SizeConfig.safeBlockHorizontal!),
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: SharedVars.fontFamily,
                                fontSize: 20,
                              )),
                          onPressed: () {
                            Map<String, dynamic> items = <String, dynamic>{
                              'item': ''
                            };
                            Map<String, dynamic> params = <String, dynamic>{
                              'edit': false,
                              'itemData': items,
                            };
                            SharedVars.formNameE = _requestTypeID!;

                            Provider.of<ChangeProvider>(context, listen: false)
                                .setMidScreen(ScreenName.editRequest, params);
                          },
                          child: const Text('ادامه'))),
                ],
              ),
            ),
            // RadioListTile<String>(
            //   title: const Text('استاد'),
            //   value: 'استاد',
            //   contentPadding: EdgeInsets.only(left: 100, right: 100),
            //   groupValue: _requestTypeID,
            //   onChanged: (String? value) {
            //     setState(() {
            //       print('Teacher is selected');
            //       _requestTypeID = value;
            //     });
            //   },
            // ),
            // RadioListTile<String>(
            //   title: const Text('مدیر کل'),
            //   value: 'مدیر کل',
            //   contentPadding: EdgeInsets.only(left: 100, right: 100),
            //   groupValue: _requestTypeID,
            //   onChanged: (String? value) {
            //     setState(() {
            //       print('Manager is selected');
            //       _requestTypeID = value;
            //     });
            //   },
            // ),
          ],
        ),
      ),
    ));
  }
}
