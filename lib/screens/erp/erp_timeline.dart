import 'dart:math';

import 'package:automation_system/models/RequestData.dart';
import 'package:automation_system/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:timelines/timelines.dart';

const kTileHeight = 50.0;
const circleDiameter = 60.0;
const horizontalContainerHeight = 150.0;
const verticalLineLength = 20.0;

const completeColor = Colors.green;
const inProgressColor = Colors.red;
const todoColor = Colors.grey;
const rejectedColor = Colors.green;

enum ProgressState {
  Completed,
  InProgress,
  Rejected,
}

class ErpTimeline extends StatelessWidget {
  int _processIndex = 0;
  List<HistoryChartItems> items;
  final ScrollController _mycontroller = ScrollController();
  double? _lineLength;
  bool? _isDesktop;
  ProgressState? _progressState;

  ErpTimeline(this.items, {Key? key}) : super(key: key);

  Color getColor(int index) {
    if (index == _processIndex) {
      if (_progressState == ProgressState.InProgress)
        return inProgressColor;
      else
        return rejectedColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  Widget getCircularIndicator(int index) {
    if (index == _processIndex) {
      return Stack(alignment: AlignmentDirectional.center, children: [
        Container(
          width: circleDiameter,
          height: circleDiameter,
          decoration: BoxDecoration(
              border: Border.all(
                width: 5,
                color: _progressState == ProgressState.InProgress
                    ? Colors.red
                    : Colors.green,
              ),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Center(
            child: Text(
              (index + 1).toString(),
              style: TextStyle(
                  color: _progressState == ProgressState.InProgress
                      ? Colors.red
                      : Colors.green,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        _progressState == ProgressState.InProgress
            ? Text('')
            : Image.asset(
                'assets/images/rejected.png',
                width: circleDiameter * 0.75,
                height: circleDiameter * 0.75,
              ),
      ]);
    } else if (index < _processIndex) {
      return Container(
        width: circleDiameter,
        height: circleDiameter,
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
        width: circleDiameter,
        height: circleDiameter,
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
    return _isDesktop!
        ? Row(
            children: [
              Container(
                width: _lineLength,
                height: 5,
                color: index <= 0
                    ? Colors.white
                    : index <= _processIndex
                        ? Colors.green
                        : Colors.grey,
              ),
              getCircularIndicator(index),
              Container(
                width: _lineLength,
                height: 5,
                color: index >= items.length - 1 ||
                        (index == _processIndex &&
                            _progressState == ProgressState.Rejected)
                    ? Colors.white
                    : index < _processIndex
                        ? Colors.green
                        : Colors.grey,
              )
            ],
          )
        : Column(
            children: [
              Container(
                width: 5,
                height: _lineLength,
                color: index <= 0
                    ? Colors.white
                    : index <= _processIndex
                        ? Colors.green
                        : Colors.grey,
              ),
              getCircularIndicator(index),
              Container(
                width: 5,
                height: _lineLength,
                color: index >= items.length - 1 ||
                        (index == _processIndex &&
                            _progressState == ProgressState.Rejected)
                    ? Colors.white
                    : index < _processIndex
                        ? Colors.green
                        : Colors.grey,
              )
            ],
          );
    ;
  }

  Widget horizontalProgressItem(int index) {
    return Container(
        child: Column(
      children: [
        getIndicator(index),
        Container(
            width: circleDiameter + 2 * _lineLength!,
            height: horizontalContainerHeight,
            padding: const EdgeInsets.only(top: 5.0),
            child: RotatedBox(
                quarterTurns: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items[index].date,
                      style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: getColor(index),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      !items[index].userName.isEmpty
                          ? items[index].userName
                          : items[index].roleTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: getColor(index),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      !items[index].userName.isEmpty
                          ? items[index].roleTitle
                          : '',
                      style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: getColor(index),
                      ),
                    ),
                    // Text(
                    //   items[index].command,
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     color: getColor(index),
                    //   ),
                    // ),
                  ],
                ))),
      ],
    ));
  }

  Widget verticalProgressItem(int index) {
    return Container(
        child: Row(
      children: [
        SizedBox(
          width: 75,
        ),
        getIndicator(index),
        Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  items[index].date,
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: getColor(index),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  !items[index].userName.isEmpty
                      ? items[index].userName
                      : items[index].roleTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: getColor(index),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  !items[index].userName.isEmpty ? items[index].roleTitle : '',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
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
      _isDesktop!
          ? rowList.add(horizontalProgressItem(i))
          : rowList.add(verticalProgressItem(i));
    }
    return rowList;
  }

  Widget build(BuildContext context) {
    _processIndex = 0;
    _isDesktop = Responsive.isDesktop(context);
    _isDesktop!
        ? _lineLength = MediaQuery.of(context).size.width * 0.5 * 0.04
        : _lineLength = verticalLineLength;

    _progressState = ProgressState.Completed;
    for (HistoryChartItems item in items) {
      if (item.state == '0') {
        _progressState = ProgressState.InProgress;
        break;
      }
      if (item.state == '-1') {
        _progressState = ProgressState.Rejected;
        break;
      }
      _processIndex++;
    }

    return Responsive.isDesktop(context)
        ? Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: generateTimelineItems(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: generateTimelineItems(),
          );
  }
}
