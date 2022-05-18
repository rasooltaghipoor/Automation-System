import 'package:automation_system/components/side_menu.dart';
import 'package:automation_system/models/Email.dart';
import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/providers/cartable_provider.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/providers/request_list_provider.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/screens/email/email_screen.dart';
import 'package:automation_system/screens/erp/message_card.dart';
import 'package:automation_system/screens/erp/request_card.dart';
import 'package:automation_system/screens/main/components/letter_card.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class ListOfMessages extends StatefulWidget {
  ErpMenuItemsData itemsData;
  // Press "Command + ."
  ListOfMessages(
    this.itemsData, {
    Key? key,
  }) : super(key: key);

  @override
  _ListOfEmailsState createState() => _ListOfEmailsState();
}

class _ListOfEmailsState extends State<ListOfMessages> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _mycontroller1 = ScrollController();

  @override
  Widget build(BuildContext context) {
    //TODO: These two lines should be removed in the future
    getErpCartableData(context, widget.itemsData);
    SizeConfig().init(context);

    return Scaffold(
        key: _scaffoldKey,
        // endDrawer: ConstrainedBox(
        //   constraints: const BoxConstraints(maxWidth: 250),
        //   child: const SideMenu(),
        // ),
        body: Container(
          padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
          color: kBgDarkColor,
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
                  const SizedBox(height: kDefaultPadding),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      children: [
                        Icon(Icons.email),
                        const SizedBox(width: 5),
                        Consumer<ErpCartableProvider>(
                          builder: (context, cartablrModel, child) {
                            return Text(
                              cartablrModel.letterListTitle,
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
                    child: Consumer<ErpCartableProvider>(
                      builder: (context, cartablrModel, child) {
                        return cartablrModel.cartable == null
                            ? Center(child: CircularProgressIndicator())
                            : cartablrModel.cartable!.catableData.isEmpty
                                ? const Center(
                                    child: Text(
                                    'داده ای برای نمایش وجود ندارد',
                                    style: TextStyle(fontSize: 20),
                                  ))
                                : ListView.builder(
                                    controller: _mycontroller1,
                                    itemCount: cartablrModel
                                        .cartable!.catableData.length,
                                    // On mobile this active dosen't mean anything
                                    itemBuilder: (context, index) =>
                                        MessageCard(
                                          // isActive: Responsive.isMobile(context)
                                          //     ? false
                                          //     : index == 0,
                                          cartableData: cartablrModel
                                              .cartable!.catableData[index],
                                          press: () {
                                            //FIXME: This map is not necessary for now, but I keep it temporarily
                                            Map<String, dynamic> params =
                                                <String, dynamic>{
                                              'canManage': true
                                            };
                                            SharedVars.requestID = cartablrModel
                                                .cartable!
                                                .catableData[index]
                                                .requestID!;
                                            SharedVars.historyID = cartablrModel
                                                .cartable!
                                                .catableData[index]
                                                .history!;
                                            SharedVars.formNameF = cartablrModel
                                                .cartable!
                                                .catableData[index]
                                                .formName_F!;
                                            // SharedVars.formNameE = requestListModel
                                            //     .requestList!
                                            //     .items[index]
                                            //     .formName_E;
                                            Provider.of<ChangeProvider>(context,
                                                    listen: false)
                                                .setMidScreen(
                                                    ScreenName.viewRequest,
                                                    params);
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => EmailScreen(
                                            //         email: emails[index]),
                                            //   ),
                                            // );
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
