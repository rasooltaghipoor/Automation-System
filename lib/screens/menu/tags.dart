import 'package:automation_system/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tags extends StatelessWidget {
  const Tags({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset("assets/Icons/Angle down.svg", width: 16),
            const SizedBox(width: kDefaultPadding / 4),
            SvgPicture.asset("assets/Icons/Markup.svg", width: 20),
            const SizedBox(width: kDefaultPadding / 2),
            Text(
              "برچسب ها (تگ)",
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: kGrayColor),
            ),
            const Spacer(),
            MaterialButton(
              padding: const EdgeInsets.all(10),
              minWidth: 40,
              onPressed: () {},
              child: const Icon(
                Icons.add,
                color: kGrayColor,
                size: 20,
              ),
            )
          ],
        ),
        const SizedBox(height: kDefaultPadding / 2),
        buildTag(context, color: const Color(0xFF23CF91), title: "مالی"),
        buildTag(context, color: const Color(0xFF3A6FF7), title: "کارکنان"),
        buildTag(context, color: const Color(0xFFF3CF50), title: "ریاست"),
        buildTag(context, color: const Color(0xFF8338E1), title: "فناوری"),
      ],
    );
  }

  InkWell buildTag(BuildContext context,
      {@required Color? color, @required String? title}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(kDefaultPadding * 1.5, 10, 0, 10),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/Icons/Markup filled.svg",
              height: 18,
              color: color!,
            ),
            const SizedBox(width: kDefaultPadding / 2),
            Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: kGrayColor),
            ),
          ],
        ),
      ),
    );
  }
}
