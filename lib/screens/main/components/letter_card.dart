import 'package:automation_system/models/Cartable.dart';
import 'package:automation_system/models/Email.dart';
import 'package:automation_system/responsive.dart';
import 'package:automation_system/utils/SizeConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:google_speech/generated/google/cloud/speech/v1p1beta1/cloud_speech.pb.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';
import '../../../extensions.dart';

class LetterCard extends StatefulWidget {
  LetterCard({
    Key? key,
    this.isActive = true,
    this.email,
    this.press,
  }) : super(key: key);

  final bool? isActive;
  final CartableData? email;
  final VoidCallback? press;
  bool? value = false;

  @override
  State<LetterCard> createState() => _LetterCardState();
}

class _LetterCardState extends State<LetterCard> {
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
          child: Wrap(
            spacing: kDefaultPaddingSmaller,
            runSpacing: kDefaultPaddingSmall,
            children: [
              Container(
                //color: Colors.amberAccent,
                width: Responsive.isDesktop(context)
                    ? SizeConfig.safeBlockHorizontal! * 45
                    : SizeConfig.safeBlockHorizontal! * 90,
                child: Row(
                  children: [
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 2 * zarib1,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(widget.email!.letterTypeTitle!),
                      ),
                    ),
                    /*const SizedBox(
                      width: kDefaultPaddingMedium,
                    ),*/
                    SizedBox(
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
                      width: SizeConfig.safeBlockHorizontal! * 30 * zarib1,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        // Subject, Sender, Source
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              widget.email!.header!,
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
                    ),
                  ],
                ),
              ),
              /* const SizedBox(
                width: kDefaultPaddingMedium,
              ),*/
              Container(
                //color: Colors.white70,
                width: Responsive.isDesktop(context)
                    ? SizeConfig.safeBlockHorizontal! * 20
                    : SizeConfig.safeBlockHorizontal! * 90,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 10 * zarib2,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const WidgetSpan(
                                  child:
                                      Icon(Icons.apartment_outlined, size: 14),
                                ),
                                const TextSpan(
                                  text: "شماره: ",
                                ),
                                TextSpan(
                                  text: widget.email!.letterNumber!,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: kDefaultPaddingSmaller,
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 10 * zarib2,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const WidgetSpan(
                                  child: Icon(Icons.date_range, size: 14),
                                ),
                                const TextSpan(
                                  text: "تاریخ: ",
                                ),
                                TextSpan(
                                  text: widget.email!.letterDate!,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: kDefaultPaddingSmaller),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 10 * zarib2,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                if (int.parse(widget.email!.attachCount!) > 0)
                                  const WidgetSpan(
                                    child: Icon(Icons.attach_file, size: 14),
                                  ),
                                const TextSpan(
                                  text: "پیوست: ",
                                ),
                                TextSpan(
                                  text: widget.email!.attachCount!,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: kDefaultPaddingMedium,
                    ),
                    SizedBox(
                      //width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal! * 7 * zarib2,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: Icon(Icons.crop_original, size: 14),
                                  ),
                                  TextSpan(
                                    text: ' ' + widget.email!.refTitle!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: kDefaultPaddingSmaller),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal! * 7 * zarib2,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: Icon(Icons.privacy_tip, size: 14),
                                  ),
                                  TextSpan(
                                    text:
                                        ' ' + widget.email!.securityTypeTitle!,
                                  ),
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
    );
  }
}
