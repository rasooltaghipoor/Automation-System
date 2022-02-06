import 'package:automation_system/models/Email.dart';
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
  final Email? email;
  final VoidCallback? press;
  bool? value = false;

  @override
  State<LetterCard> createState() => _LetterCardState();
}

class _LetterCardState extends State<LetterCard> {
  @override
  Widget build(BuildContext context) {
    //  Here the shadow is not showing properly
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: widget.press,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: widget.isActive! ? kPrimaryColor : kBgDarkColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Wrap(
                spacing: kDefaultPaddingSmaller,
                runSpacing: kDefaultPaddingSmall,
                children: [
                  //Row(
                  //children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      // Type: Incoming, Outgoing, ...
                      widget.email!.type!,
                      /* style: Theme.of(context).textTheme.caption?.copyWith(
                            color: widget.isActive! ? Colors.white70 : null,
                          ),*/
                    ),
                  ),
                  const SizedBox(
                    width: kDefaultPaddingMedium,
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      // Required Action
                      widget.email!.requiredAction!,
                      /*style: Theme.of(context).textTheme.caption?.copyWith(
                            color: widget.isActive! ? Colors.white70 : null,
                          ),*/
                    ),
                  ),
                  //],
                  //),
                  const SizedBox(
                    width: kDefaultPaddingMedium,
                  ),
                  SizedBox(
                    width: 50,
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
                        Text(widget.email!.time!),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: kDefaultPaddingMedium,
                  ),
                  SizedBox(
                    width: 500,
                    child: Column(
                      // Subject, Sender, Source
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 500,
                          child: Text(
                            widget.email!.subject!,
                          ),
                        ),
                        SizedBox(
                          width: 500,
                          child: Row(
                            children: [
                              SizedBox(
                                // User Image
                                width: 32,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage(widget.email!.image!),
                                ),
                              ),
                              const SizedBox(width: kDefaultPadding / 2),
                              Text(widget.email!.name!),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 500,
                          child: Text(
                            widget.email!.source!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: kDefaultPaddingMedium,
                  ),
                  SizedBox(
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 300,
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
                                  text: widget.email!.idNumber!,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 300,
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
                                  text: widget.email!.time!,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                if (widget.email!.isAttachmentAvailable!)
                                  const WidgetSpan(
                                    child: Icon(Icons.attach_file, size: 14),
                                  ),
                                const TextSpan(
                                  text: "پیوست: ",
                                ),
                                TextSpan(
                                  text: widget.email!.idNumber!,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: kDefaultPaddingMedium,
                  ),
                  SizedBox(
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                if (widget.email!.isOriginal!)
                                  const WidgetSpan(
                                    child: Icon(Icons.crop_original, size: 14),
                                  ),
                                if (widget.email!.isOriginal!)
                                  const TextSpan(
                                    text: "اصل",
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                if (widget.email!.isConfidential!)
                                  const WidgetSpan(
                                    child: Icon(Icons.privacy_tip, size: 14),
                                  ),
                                if (widget.email!.isConfidential!)
                                  const TextSpan(
                                    text: "محرمانه",
                                  ),
                              ],
                            ),
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
            if (!widget.email!.isChecked!)
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
              )
          ],
        ),
      ),
    );
  }
}
