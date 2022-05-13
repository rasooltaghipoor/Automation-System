import 'package:automation_system/models/Cartable.dart';
import 'package:automation_system/models/Email.dart';
import 'package:automation_system/models/RequestList.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_speech/generated/google/cloud/speech/v1p1beta1/cloud_speech.pb.dart';
import 'package:websafe_svg/websafe_svg.dart';

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
          //child: Stack(
          //children: [
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(kDefaultPaddingSmall),
            decoration: BoxDecoration(
              color: widget.isActive! ? kPrimaryColor : kBgDarkColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              //spacing: kDefaultPaddingSmaller,
              //runSpacing: kDefaultPaddingSmall,
              children: [
                Container(
                  // color: Colors.amber[100],
                  width: Responsive.isDesktop(context)
                      ? SizeConfig.safeBlockHorizontal! * 90
                      : SizeConfig.safeBlockHorizontal! * 90,
                  child: Row(
                    children: [
                      Image.network(
                        mainUrl + widget.cartableData!.icon!,
                        width: 35,
                        height: 35,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 2 * zarib1,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(widget.cartableData!.formName_F!),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            mainUrl + widget.cartableData!.profile!),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(widget.cartableData!.requester!),
                    ],
                  ),
                ),
                Container(
                  // color: Colors.white70,
                  width: Responsive.isDesktop(context)
                      ? SizeConfig.safeBlockHorizontal! * 90
                      : SizeConfig.safeBlockHorizontal! * 90,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('اولویت: ' + widget.cartableData!.priority!),
                          SizedBox(
                            width: 20,
                          ),
                          Text('تاریخ: ' + widget.cartableData!.date!),
                        ],
                      ),
                    ],
                  ),
                ),
                /*Column(
                    children: [
                      const SizedBox(height: 5),
                      if (email!.isAttachmentAvailable!)
                        WebsafeSvg.asset(
                          "assets/Icons/Paperclip.svg",
                          color: isActive! ? Colors.white70 : kGrayColor,
                        )
                    ],
                  ),*/
              ],
            ),
          ).addNeumorphism(
            blurRadius: 15,
            borderRadius: 15,
            offset: const Offset(5, 5),
            topShadowColor: Colors.white60,
            bottomShadowColor: const Color(0xFF234395).withOpacity(0.15),
          ),
          /*if (!widget.email!.isChecked!)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kBadgeColor,
                  ),
                ).addNeumorphism(
                  blurRadius: 4,
                  borderRadius: 8,
                  offset: const Offset(2, 2),
                ),
              ),
            if (widget.email!.tagColor != null)
              Positioned(
                left: 8,
                top: 0,
                child: WebsafeSvg.asset(
                  "assets/Icons/Markup filled.svg",
                  height: 18,
                  color: widget.email!.tagColor!,
                ),
              )*/
          // ],
          //),
        ),
      ),
    );
  }
}
