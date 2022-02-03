import 'package:automation_system/models/Email.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';
import '../../../extensions.dart';

class LetterCard extends StatelessWidget {
  const LetterCard({
    Key? key,
    this.isActive = true,
    this.email,
    this.press,
  }) : super(key: key);

  final bool? isActive;
  final Email? email;
  final VoidCallback? press;
  final bool value = false;

  @override
  Widget build(BuildContext context) {
    //  Here the shadow is not showing properly
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: press,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: isActive! ? kPrimaryColor : kBgDarkColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                      Text( // Type: Incoming, Outgoing, ...
                        email!.type!,
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption
                            ?.copyWith(
                          color: isActive! ? Colors.white70 : null,
                        ),
                      ),
                      Text( // Required Action
                        email!.requiredAction!,
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption
                            ?.copyWith(
                          color: isActive! ? Colors.white70 : null,
                        ),
                      ),
                    ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Checkbox(
                          value: value,
                          onChanged: (bool? value) {
                            /*setState(() {
                            this.value = value;
                          });*/
                          },
                        ),
                        Text(email!.time!),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Text(email!.subject!),
                        Row(
                          children: [
                            SizedBox( // User Image
                              width: 32,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(email!.image!),
                              ),
                            ),
                            const SizedBox(width: kDefaultPadding / 2),
                            Text(
                                email!.name!
                            ),
                          ],
                        ),
                        Text(email!.source!),
                        /*const SizedBox(height: kDefaultPadding / 2),
                  Text(
                    email!.body!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                      height: 1.5,
                      color: isActive! ? Colors.white70 : null,
                    ),
                  )*/
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.apartment_outlined, size: 14),
                              ),
                              const TextSpan(
                                text: "شماره: ",
                              ),
                              TextSpan(
                                text: email!.idNumber!,
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.date_range, size: 14),
                              ),
                              const TextSpan(
                                text: "تاریخ: ",
                              ),
                              TextSpan(
                                text: email!.time!,
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              if (email!.isAttachmentAvailable!)
                                const WidgetSpan(
                                  child: Icon(Icons.attach_file, size: 14),
                                ),
                              const TextSpan(
                                text: "پیوست: ",
                              ),
                              TextSpan(
                                text: email!.idNumber!,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              if (email!.isOriginal!)
                                const WidgetSpan(
                                  child: Icon(Icons.crop_original, size: 14),
                                ),
                              if (email!.isOriginal!)
                                const TextSpan(
                                  text: "اصل",
                                ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              if (email!.isConfidential!)
                                const WidgetSpan(
                                  child: Icon(Icons.privacy_tip, size: 14),
                                ),
                              if (email!.isConfidential!)
                                const TextSpan(
                                  text: "محرمانه",
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
            if (!email!.isChecked!)
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
            if (email!.tagColor != null)
              Positioned(
                left: 8,
                top: 0,
                child: WebsafeSvg.asset(
                  "assets/Icons/Markup filled.svg",
                  height: 18,
                  color: email!.tagColor!,
                ),
              )
          ],
        ),
      ),
    );
  }
}