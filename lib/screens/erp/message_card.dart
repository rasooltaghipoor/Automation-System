import 'package:automation_system/models/Cartable.dart';
import 'package:automation_system/responsive.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../constants.dart';
import '../../../extensions.dart';

class MessageCard extends StatefulWidget {
  MessageCard({
    Key? key,
    this.isActive = false,
    this.cartableData,
    this.press,
  }) : super(key: key);

  final bool? isActive;
  final ErpCartableData? cartableData;
  final VoidCallback? press;
  bool? value = false;

  @override
  State<MessageCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    //  Here the shadow is not showing properly
    final zarib1 = Responsive.isDesktop(context)
        ? 1
        : (Responsive.isTablet(context) ? 1.5 : 2);
    final zarib2 = Responsive.isDesktop(context)
        ? 1
        : (Responsive.isTablet(context) ? 3 : 4);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: InkWell(
          onTap: widget.press,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(kDefaultPaddingSmall / 2),
            decoration: BoxDecoration(
              color: widget.isActive! ? kPrimaryColor : kBgDarkColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ResponsiveRowColumn(
              rowMainAxisAlignment: MainAxisAlignment.start,
              rowPadding: const EdgeInsets.all(1),
              columnPadding: const EdgeInsets.all(10),
              layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 4,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              mainUrl + widget.cartableData!.icon!,
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            SizedBox(
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  widget.cartableData!.formName_F!,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(widget.cartableData!.itemsTitle),
                        ),
                        SizedBox(
                          width: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    mainUrl + widget.cartableData!.profile!),
                              ),
                              Text(widget.cartableData!.requester!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 3,
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('اولویت: ' + widget.cartableData!.priority!),
                            Text(widget.cartableData!.date!),
                            Responsive.isDesktop(context)
                                ? Image.network(
                                    mainUrl + widget.cartableData!.stateIcon,
                                    width: 30,
                                    height: 30,
                                  )
                                : Text(''),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).addNeumorphism(
            blurRadius: 15,
            borderRadius: 15,
            offset: const Offset(5, 5),
            topShadowColor: Colors.white60,
            bottomShadowColor: const Color(0xFF234395).withOpacity(0.15),
          ),
        ),
      ),
    );
  }
}
