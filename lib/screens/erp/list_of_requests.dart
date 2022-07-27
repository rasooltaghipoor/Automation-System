import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/providers/request_list_provider.dart';
import 'package:automation_system/screens/erp/request_card.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class ListOfRequests extends StatefulWidget {
  const ListOfRequests({
    Key? key,
  }) : super(key: key);

  @override
  _ListOfEmailsState createState() => _ListOfEmailsState();
}

class _ListOfEmailsState extends State<ListOfRequests> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _mycontroller1 = ScrollController();

  @override
  void initState() {
    super.initState();
    getRequestList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
          color: kBgLightColor,
          child: SafeArea(
            right: false,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  // This is our Search bar
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  //   child: Row(
                  //     children: [
                  //       // Once user click the menu icon the menu shows like drawer
                  //       // Also we want to hide this menu icon on desktop
                  //       if (!Responsive.isDesktop(context))
                  //         IconButton(
                  //           icon: const Icon(Icons.menu),
                  //           onPressed: () {
                  //             _scaffoldKey.currentState?.openEndDrawer();
                  //           },
                  //         ),
                  //       if (!Responsive.isDesktop(context))
                  //         const SizedBox(width: 5),
                  //       /*Expanded(
                  //         child: TextField(
                  //           onChanged: (value) {},
                  //           decoration: InputDecoration(
                  //             hintText: "جستجو",
                  //             fillColor: kBgLightColor,
                  //             filled: true,
                  //             suffixIcon: Padding(
                  //               padding: const EdgeInsets.all(
                  //                   kDefaultPadding * 0.75), //15
                  //               child: WebsafeSvg.asset(
                  //                 "assets/Icons/Search.svg",
                  //                 width: 24,
                  //               ),
                  //             ),
                  //             border: const OutlineInputBorder(
                  //               borderRadius: BorderRadius.all(
                  //                   Radius.circular(10)),
                  //               borderSide: BorderSide.none,
                  //             ),
                  //           ),
                  //         ),
                  //       ),*/
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: kDefaultPadding),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      children: [
                        Icon(Icons.email),
                        const SizedBox(width: 5),
                        Consumer<RequestListProvider>(
                          builder: (context, requestListModel, child) {
                            return Text(
                              requestListModel.listTitle,
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
                          child: SvgPicture.asset(
                            "assets/Icons/Sort.svg",
                            width: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Expanded(
                    child: Consumer<RequestListProvider>(
                      builder: (context, requestListModel, child) {
                        return requestListModel.requestList == null
                            ? Center(child: CircularProgressIndicator())
                            : requestListModel.requestList!.items.isEmpty
                                ? const Center(
                                    child: Text(
                                    'داده ای برای نمایش وجود ندارد',
                                    style: TextStyle(fontSize: 20),
                                  ))
                                : ListView.builder(
                                    controller: _mycontroller1,
                                    itemCount: requestListModel
                                        .requestList!.items.length,
                                    // On mobile this active dosen't mean anything
                                    itemBuilder: (context, index) =>
                                        RequestCard(
                                          request: requestListModel
                                              .requestList!.items[index],
                                          press: () {
                                            //FIXME: This map is not necessary for now, but I keep it temporarily
                                            Map<String, dynamic> params =
                                                <String, dynamic>{
                                              'canManage': false
                                            };
                                            SharedVars.requestID =
                                                requestListModel.requestList!
                                                    .items[index].requestID;
                                            SharedVars.formNameF =
                                                requestListModel.requestList!
                                                    .items[index].formName_F;
                                            Provider.of<ChangeProvider>(context,
                                                    listen: false)
                                                .setMidScreen(
                                                    ScreenName.viewRequest,
                                                    params);
                                          },
                                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
