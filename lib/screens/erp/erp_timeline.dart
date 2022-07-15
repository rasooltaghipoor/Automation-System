import 'dart:math';

import 'package:automation_system/models/RequestData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

const kTileHeight = 50.0;

const completeColor = Color.fromARGB(255, 46, 64, 163);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class ErpTimeline extends StatelessWidget {
  int _processIndex = 0;
  List<HistoryChartItems> items;
  final ScrollController _mycontroller = ScrollController();

  ErpTimeline(this.items, {Key? key}) : super(key: key);

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  Icon getIcon(int index) {
    if (index == _processIndex) {
      return Icon(
        Icons.timer_outlined,
        size: 60,
        color: getColor(index),
      );
    } else if (index < _processIndex) {
      return Icon(
        Icons.check_circle_outline,
        size: 60,
        color: getColor(index),
      );
      ;
    } else {
      return Icon(
        Icons.do_not_touch_outlined,
        size: 60,
        color: getColor(index),
      );
    }
  }

  Widget getCircularIndicator(int index) {
    if (index == _processIndex) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
              width: 5,
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Center(
          child: Text(
            (index + 1).toString(),
            style: TextStyle(
                color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else if (index < _processIndex) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
              width: 5,
              color: Colors.green,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Center(
          child: Text(
            (index + 1).toString(),
            style: TextStyle(
                color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
              width: 5,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Center(
          child: Text(
            (index + 1).toString(),
            style: TextStyle(
                color: Colors.grey, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  Widget getIndicator(int index) {
    return Row(
      children: [
        index > 0
            ? Container(
                width: 50,
                height: 5,
                color: index <= _processIndex ? Colors.green : Colors.grey,
              )
            : Icon(Icons.arrow_right_rounded),
        getCircularIndicator(index),
        index < items.length - 1
            ? Container(
                width: 50,
                height: 5,
                color: index < _processIndex ? Colors.green : Colors.grey,
              )
            : Icon(Icons.arrow_left_rounded),
      ],
    );
  }

  Widget horizontalProgressItem(int index) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: SizedBox(
            height: 50,
            // color: Colors.amber,
            child: Column(
              children: [
                Text(
                  items[index].userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: getColor(index),
                  ),
                ),
                Text(
                  items[index].roleTitle,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: getColor(index),
                  ),
                ),
              ],
            ),
          ),
        ),
        getIndicator(index),
        Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                Text(
                  items[index].date,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: getColor(index),
                  ),
                ),
                Text(
                  items[index].command,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: getColor(index),
                  ),
                ),
              ],
            )),
      ],
    ));
  }

  List<Widget> generateTimelineItems() {
    final List<Widget> rowList = [];
    for (int i = 0; i < items.length; i++) {
      rowList.add(horizontalProgressItem(i));
      // rowList.add(Container(
      //   width: 50,
      //   height: 5,
      //   color: Colors.red,
      // ));
    }
    return rowList;
  }

  Widget generateIndicator(int index) {
    var color;
    var child;
    if (index == _processIndex) {
      color = inProgressColor;
      child = const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      );
    } else if (index < _processIndex) {
      color = completeColor;
      child = const Icon(
        Icons.check,
        color: Colors.white,
        size: 15.0,
      );
    } else {
      color = todoColor;
    }

    if (index <= _processIndex) {
      return Stack(
        children: [
          CustomPaint(
            size: const Size(30.0, 30.0),
            painter: _BezierPainter(
              color: color,
              drawStart: index > 0,
              drawEnd: index < _processIndex,
            ),
          ),
          DotIndicator(
            size: 30.0,
            color: color,
            child: child,
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          CustomPaint(
            size: const Size(15.0, 15.0),
            painter: _BezierPainter(
              color: color,
              drawEnd: index < items.length - 1,
            ),
          ),
          OutlinedDotIndicator(
            borderWidth: 4.0,
            color: color,
          ),
        ],
      );
    }
  }

  Widget build(BuildContext context) {
    _processIndex = 0;
    for (HistoryChartItems item in items) {
      if (item.command == 'منتظر بررسی') break;
      _processIndex++;
    }
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: generateTimelineItems(),
    );
  }
}

/// hardcoded bezier painter
/// TODO: Bezier curve into package component
class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
