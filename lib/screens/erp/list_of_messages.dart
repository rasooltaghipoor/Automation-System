import 'package:automation_system/models/MenuDetails.dart';
import 'package:automation_system/providers/cartable_provider.dart';
import 'package:automation_system/providers/change_provider.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/screens/erp/message_card.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:automation_system/utils/communication/web_request.dart';
import 'package:automation_system/utils/shared_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    getErpCartableData(context, widget.itemsData);
  }

  @override
  Widget build(BuildContext context) {
    if (SharedVars.refreshPage) {
      SharedVars.refreshPage = false;
      getErpCartableData(context, widget.itemsData);
    }
    return Scaffold(
        key: _scaffoldKey,
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {},
                            onSubmitted: (value) {
                              getErpCartableData(context, widget.itemsData,
                                  search: value);
                            },
                            decoration: InputDecoration(
                              hintText: "جستجو",
                              fillColor: kBgLightColor,
                              filled: true,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(
                                    kDefaultPadding * 0.75), //15
                                child: SvgPicture.asset(
                                  "assets/Icons/Search.svg",
                                  width: 24,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
