import 'package:automation_system/constants.dart';
import 'package:automation_system/extensions.dart';
import 'package:flutter/material.dart';

class CounterBadge extends StatelessWidget {
  const CounterBadge({
    Key? key,
    @required this.count,
  }) : super(key: key);

  final int? count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: count! > 0 ? kBadgeColor : kGrayColor,
          borderRadius: BorderRadius.circular(9)),
      child: Text(
        count.toString(),
        style: Theme.of(context).textTheme.caption?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
      ),
    ).addNeumorphism(
      offset: const Offset(4, 4),
      borderRadius: 9,
      blurRadius: 4,
      topShadowColor: Colors.white,
      bottomShadowColor: const Color(0xFF30384D).withOpacity(0.3),
    );
  }
}
