import 'package:automation_system/models/BuyModel.dart';
import 'package:automation_system/models/Email.dart';
import 'package:automation_system/models/RequestList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../constants.dart';
import 'components/header.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({
    Key? key,
    this.itemData,
  }) : super(key: key);

  final ItemData? itemData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              const Header(),
              const Divider(thickness: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        maxRadius: 24,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(emails[1].image!),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: emails[1].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                          children: [
                                            TextSpan(
                                                text:
                                                    "  <elvia.atkins@gmail.com> به محمد علوی",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "برو ای گدای مسکین در خانه علی زن",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: kDefaultPadding / 2),
                                Text(
                                  "تاریخ 1400/02/27 ساعت 14:36",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LayoutBuilder(
                              builder: (context, constraints) => SizedBox(
                                width: constraints.maxWidth > 850
                                    ? 800
                                    : constraints.maxWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "خواهشمند است در صورت موافقت و صلاحدید با تقاضای خرید اقلام هماهنگی لازم جهت تایید انجام گردد.\nقبلا از دستور مساعدت و محبتی که می فرمایید نهایت تشکر و قدر دانی را دارم.\nبا تقدیم احترام\nنام و نام خانوادگی\nامضاء",
                                      style: TextStyle(
                                        height: 1.5,
                                        color: Color(0xFF4D5875),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const SizedBox(height: kDefaultPadding),
                                    Row(
                                      children: [
                                        const Text(
                                          "6 الحاقیه",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "دانلود همه",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        const SizedBox(
                                            width: kDefaultPadding / 4),
                                        WebsafeSvg.asset(
                                          "assets/Icons/Download.svg",
                                          height: 16,
                                          color: kGrayColor,
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 1),
                                    const SizedBox(height: kDefaultPadding / 2),
                                    SizedBox(
                                      height: 200,
                                      child: StaggeredGrid.count(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 4,
                                        children: [
                                          StaggeredGridTile.count(
                                            crossAxisCellCount: 2,
                                            mainAxisCellCount: 2,
                                            child: Image.asset(
                                              "assets/images/Img_1.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          StaggeredGridTile.count(
                                            crossAxisCellCount: 2,
                                            mainAxisCellCount: 1,
                                            child: Image.asset(
                                              "assets/images/Img_1.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          StaggeredGridTile.count(
                                            crossAxisCellCount: 1,
                                            mainAxisCellCount: 1,
                                            child: Image.asset(
                                              "assets/images/Img_1.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          StaggeredGridTile.count(
                                            crossAxisCellCount: 1,
                                            mainAxisCellCount: 1,
                                            child: Image.asset(
                                              "assets/images/Img_1.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          StaggeredGridTile.count(
                                            crossAxisCellCount: 4,
                                            mainAxisCellCount: 2,
                                            child: Image.asset(
                                              "assets/images/Img_1.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      /*StaggeredGridView.countBuilder(
                                        physics: NeverScrollableScrollPhysics(),
                                        crossAxisCount: 4,
                                        itemCount: 3,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            "assets/images/Img_$index.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        staggeredTileBuilder: (int index) =>
                                            StaggeredTile.count(
                                          2,
                                          index.isOdd ? 2 : 1,
                                        ),
                                        mainAxisSpacing: kDefaultPadding,
                                        crossAxisSpacing: kDefaultPadding,
                                      ),*/
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
