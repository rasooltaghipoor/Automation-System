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

class RequestCard extends StatefulWidget {
  RequestCard({
    Key? key,
    this.isActive = true,
    this.request,
    this.press,
  }) : super(key: key);

  final bool? isActive;
  final Request? request;
  final VoidCallback? press;
  bool? value = false;

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
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
                  color: Colors.amber[100],
                  width: Responsive.isDesktop(context)
                      ? SizeConfig.safeBlockHorizontal! * 90
                      : SizeConfig.safeBlockHorizontal! * 90,
                  child: Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 2 * zarib1,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(widget.request!.formName_F),
                        ),
                      ),
                      /*const SizedBox(
                      width: kDefaultPaddingMedium,
                    ),*/
                      /* SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 2 * zarib1,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(widget.email!.actionTypeTitle!),
                        ),
                      ),
                      //],
                      //),
                      const SizedBox(
                        width: kDefaultPaddingMedium,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 4 * zarib1,
                        child: Column(
                          children: [
                            Checkbox(
                              value: widget.value,
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.value = value;
                                });
                              },
                            ),
                            const SizedBox(
                              height: kDefaultPaddingSmall,
                            ),
                            Text(widget.email!.hDate!),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: kDefaultPaddingMedium,
                      ),
                      SizedBox(
                        width: Responsive.isDesktop(context)
                            ? SizeConfig.safeBlockHorizontal! * 60 * zarib1
                            : SizeConfig.safeBlockHorizontal! * 30 * zarib1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          // Subject, Sender, Source
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                widget.email!.header!,
                                //overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  SizedBox(
                                    // User Image
                                    width: 32,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.network(
                                          mainUrl + widget.email!.profilePic!),
                                    ),
                                  ),
                                  const SizedBox(width: kDefaultPadding / 2),
                                  Text(widget.email!.fromTitle!),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                'فرستنده اصلی: ' + widget.email!.sourceTitle!,
                              ),
                            ),
                          ],
                        ),
                      ),*/
                    ],
                  ),
                ),
                /* const SizedBox(
                width: kDefaultPaddingMedium,
              ),*/
                Container(
                  color: Colors.white70,
                  width: Responsive.isDesktop(context)
                      ? SizeConfig.safeBlockHorizontal! * 90
                      : SizeConfig.safeBlockHorizontal! * 90,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: SizeConfig.safeBlockHorizontal! * 10,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.confirmation_number_outlined,
                                    size: 20,
                                  ),
                                  Text(widget.request!.requestID),
                                ],
                              )),
                          const SizedBox(
                            height: kDefaultPaddingSmaller,
                          ),
                          SizedBox(
                              width: SizeConfig.safeBlockHorizontal! * 10,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.date_range,
                                    size: 20,
                                  ),
                                  Text(widget.request!.requestDate),
                                ],
                              )),
                          /*const SizedBox(height: kDefaultPaddingSmaller),
                          SizedBox(
                              width: SizeConfig.safeBlockHorizontal! * 10,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.attach_file,
                                    size: 20,
                                  ),
                                  Text(widget.email!.attachCount!),
                                ],
                              )),
                          const SizedBox(height: kDefaultPaddingSmaller),
                          SizedBox(
                              width: SizeConfig.safeBlockHorizontal! * 10,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    size: 20,
                                  ),
                                  Text(widget.email!.deadLine!),
                                ],
                              )),*/
                        ],
                      ),
                      /*const SizedBox(
                      width: kDefaultPaddingMedium,
                    ),*/
                      /*Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: SizeConfig.safeBlockHorizontal! * 10,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.important_devices,
                                    size: 20,
                                  ),
                                  Text(widget.email!.priorityTypeTitle!),
                                ],
                              )),
                          const SizedBox(height: kDefaultPaddingSmaller),
                          SizedBox(
                              width: SizeConfig.safeBlockHorizontal! * 10,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.link,
                                    size: 20,
                                  ),
                                  Text(widget.email!.refTitle!),
                                ],
                              )),
                          const SizedBox(height: kDefaultPaddingSmaller),
                          SizedBox(
                              width: SizeConfig.safeBlockHorizontal! * 10,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.security,
                                    size: 20,
                                  ),
                                  Text(widget.email!.securityTypeTitle!),
                                ],
                              )),
                          const SizedBox(height: kDefaultPaddingSmaller),
                          SizedBox(
                              width: SizeConfig.safeBlockHorizontal! * 10,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.remove_red_eye,
                                    size: 20,
                                  ),
                                  Text(widget.email!.lStateTitle!),
                                ],
                              )),
                        ],
                      ),*/
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
