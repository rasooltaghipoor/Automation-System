import 'package:automation_system/models/ReplyButtons.dart';

class RequestData {
  RequestDetail requestDetails;
  History history;
  HistoryChart historyChart;
  String editable;
  String canReply;
  final List<ReplyButtonData> buttonsData;

  RequestData(this.requestDetails, this.history, this.historyChart,
      this.editable, this.canReply, this.buttonsData);

  factory RequestData.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Request'] as List;
    RequestDetail requestDtls = RequestDetail.fromMap(list[0]);

    var list2 = parsedJson['History'] as List;
    History historyData = History.fromMap(list2[0]);

    var list3 = parsedJson['HistoryChart'] as List;
    HistoryChart historyChartData = HistoryChart.fromMap(list3[0]);

    var list4 = parsedJson['button'] as List;
    //print(list.runtimeType);
    List<ReplyButtonData> btnList = [];
    if (list4.isNotEmpty) {
      btnList = list4.map((i) => ReplyButtonData.fromMap(i)).toList();
    }

    return RequestData(requestDtls, historyData, historyChartData,
        parsedJson['editable'], parsedJson['reply'], btnList);
  }
}

class RequestDetail {
  String requestID;
  String formName_F;
  String formName_E;
  String networkUser;
  String title;
  Map<String, dynamic> items;
  String state;
  String priority;
  String date;
  String profile;
  String icon;
  String attachFile;
  String fileUrl;

  RequestDetail(
      this.requestID,
      this.formName_F,
      this.formName_E,
      this.networkUser,
      this.title,
      this.items,
      this.state,
      this.priority,
      this.date,
      this.profile,
      this.icon,
      this.attachFile,
      this.fileUrl);

  factory RequestDetail.fromMap(Map<String, dynamic> parsedJson) {
    Map<String, dynamic> items = parsedJson['items'][0];
    return RequestDetail(
      parsedJson['Requestid'],
      parsedJson['formName_F'],
      parsedJson['formName_E'],
      parsedJson['NetworkUser'],
      parsedJson['title'],
      items,
      parsedJson['state'],
      parsedJson['priority'],
      parsedJson['date'],
      parsedJson['profile'],
      parsedJson['icon'],
      parsedJson['Attachfile'],
      parsedJson['fileurl'],
    );
  }
}

class History {
  String result;
  List<HistoryItems> items;

  History(this.result, this.items);

  factory History.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<HistoryItems> historyItems =
        list.map((i) => HistoryItems.fromMap(i)).toList();
    return History(
      parsedJson['Result'],
      historyItems,
    );
  }
}

class HistoryItems {
  String step;
  String historyID;
  String command;
  String description;
  String editForm;
  String date;
  String userName;
  String roleTitle;
  String attachFile;
  String fileUrl;

  HistoryItems(
      this.step,
      this.historyID,
      this.command,
      this.description,
      this.editForm,
      this.date,
      this.userName,
      this.roleTitle,
      this.attachFile,
      this.fileUrl);

  factory HistoryItems.fromMap(Map<String, dynamic> parsedJson) {
    return HistoryItems(
      parsedJson['step'],
      parsedJson['HistoryID'],
      parsedJson['Command'],
      parsedJson['Description'],
      parsedJson['EditForm'],
      parsedJson['date'],
      parsedJson['username'],
      parsedJson['Roletitle'],
      parsedJson['Attachfile'],
      parsedJson['fileurl'],
    );
  }
}

class HistoryChart {
  String result;
  List<HistoryChartItems> items;

  HistoryChart(this.result, this.items);

  factory HistoryChart.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<HistoryChartItems> historyItems =
        list.map((i) => HistoryChartItems.fromMap(i)).toList();
    return HistoryChart(
      parsedJson['Result'],
      historyItems,
    );
  }
}

class HistoryChartItems {
  String step;
  String command;
  String date;
  String userName;
  String roleTitle;

  HistoryChartItems(
    this.step,
    this.command,
    this.date,
    this.userName,
    this.roleTitle,
  );

  factory HistoryChartItems.fromMap(Map<String, dynamic> parsedJson) {
    return HistoryChartItems(
      parsedJson['step'],
      parsedJson['Command'],
      parsedJson['Date'],
      parsedJson['username'],
      parsedJson['Roletitle'],
    );
  }
}
