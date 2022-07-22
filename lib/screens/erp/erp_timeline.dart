import 'package:automation_system/models/RequestData.dart';
import 'package:automation_system/responsive.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

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
  RequestData requestData;
  final ScrollController _mycontroller = ScrollController();
  double? _lineLength;
  double? _tooltipWidth;
  bool? _isDesktop;
  ProgressState? _progressState;

  ErpTimeline(this.requestData, {Key? key}) : super(key: key);

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

  Widget getDetailsTip(int index) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            color: Colors.yellow[50],
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            width: _tooltipWidth,
            height: 275,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ListTile(
                    leading: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Text(
                          requestData.history.items[index].step,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    title: Text(
                      requestData.history.items[index].userName,
                    ),
                    subtitle: Text(requestData.history.items[index].roleTitle),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    'وضعیت: ' + requestData.history.items[index].command,
                    style: TextStyle(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: requestData.history.items[index].editForm == 'True'
                      ? Text(
                          'ویرایش شده: بله',
                          style: TextStyle(),
                        )
                      : Text(
                          'ویرایش شده: خیر',
                          style: TextStyle(),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child:
                      Text('تاریخ: ' + requestData.history.items[index].date),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text('توضیحات: ' +
                      requestData.history.items[index].description),
                ),
                SizedBox(
                  height: 5,
                ),
                // Row(
                //   children: [
                //     Text('فایل ضمیمه: '),
                //     requestData.history.items[index].attachFile != 'True'
                //         ? Text('ندارد')
                //         : GestureDetector(
                //             onTap: () {
                //               _showUpdatedDialog(mainUrl +
                //                   requestData.history.items[index].fileUrl +
                //                   Provider.of<AuthProvider>(context, listen: false)
                //                       .authUser
                //                       .token!);
                //             },
                //             child: Image.network(
                //               mainUrl +
                //                   requestData.history.items[index].fileUrl +
                //                   Provider.of<AuthProvider>(context, listen: false)
                //                       .authUser
                //                       .token!,
                //               width: 100,
                //               height: 100,
                //             )),
                //   ],
                // ),
              ],
            )));
  }

  Widget getCircularIndicator(int index) {
    if (index == _processIndex) {
      return JustTheTooltip(
        preferredDirection: AxisDirection.up,
        child: Stack(alignment: AlignmentDirectional.center, children: [
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
        ]),
        content: getDetailsTip(index),
      );
    } else if (index < _processIndex) {
      return JustTheTooltip(
        preferredDirection: AxisDirection.up,
        child: Container(
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
                  color: Colors.green,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        content: getDetailsTip(index),
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
                color: index >= requestData.historyChart.items.length - 1 ||
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
                color: index >= requestData.historyChart.items.length - 1 ||
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
                      requestData.historyChart.items[index].date,
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
                      !requestData.historyChart.items[index].userName.isEmpty
                          ? requestData.historyChart.items[index].userName
                          : requestData.historyChart.items[index].roleTitle,
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
                      !requestData.historyChart.items[index].userName.isEmpty
                          ? requestData.historyChart.items[index].roleTitle
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
                  requestData.historyChart.items[index].date,
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
                  !requestData.historyChart.items[index].userName.isEmpty
                      ? requestData.historyChart.items[index].userName
                      : requestData.historyChart.items[index].roleTitle,
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
                  !requestData.historyChart.items[index].userName.isEmpty
                      ? requestData.historyChart.items[index].roleTitle
                      : '',
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
    for (int i = 0; i < requestData.historyChart.items.length; i++) {
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
    _isDesktop!
        ? _tooltipWidth = MediaQuery.of(context).size.width * 0.25
        : _tooltipWidth = MediaQuery.of(context).size.width * 0.75;

    _progressState = ProgressState.Completed;
    for (HistoryChartItems item in requestData.historyChart.items) {
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
