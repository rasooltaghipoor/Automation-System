import 'package:automation_system/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'counter_badge.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    Key? key,
    this.isActive,
    this.isHover = false,
    this.itemCount,
    this.showBorder = true,
    @required this.iconSrc,
    @required this.title,
    @required this.press,
  }) : super(key: key);

  final bool? isActive, isHover, showBorder;
  final int? itemCount;
  final String? iconSrc, title;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: TextButton(
        onPressed: itemCount == null ? null : press,
        style: ElevatedButton.styleFrom(
            primary: (isActive!) ? kTitleTextColor : Colors.white70,
            textStyle: const TextStyle(
                color: Colors.white,
                //fontSize:
                //SharedVars.buttonFontSize * 0.8,
                fontWeight: FontWeight.bold)),
        child: Container(
          height: 45,
          padding: const EdgeInsets.only(right: 5),
          decoration: showBorder!
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFDFE2EF)),
                  ),
                )
              : null,
          child: Row(
            children: [
              SvgPicture.asset(
                iconSrc!,
                height: 20,
                color: (isActive! || isHover!) ? kPrimaryColor : kGrayColor,
              ),
              const SizedBox(width: kDefaultPadding * 0.75),
              Text(
                title!,
                style: Theme.of(context).textTheme.button?.copyWith(
                      color: (isActive! || isHover!)
                          ? kBgLightColor
                          : kTitleTextColor,
                    ),
              ),
              const Spacer(),
              if (itemCount != null && itemCount! >= 0)
                CounterBadge(count: itemCount)
            ],
          ),
        ),
      ),
    );
  }
}
