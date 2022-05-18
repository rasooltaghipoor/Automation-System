class CartableModel {
  final List<CartableData> catableData;

  CartableModel(this.catableData);
  factory CartableModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    //print(list.runtimeType);
    List<CartableData> msgList =
        list.map((i) => CartableData.fromMap(i)).toList();
    return CartableModel(msgList);
  }
}

class CartableData {
  String? letterID;
  String? historyID;
  String? letterTypeTitle;
  String? actionTypeTitle;
  String? hDate;
  String? deadLine;
  String? priorityTypeTitle;
  String? header;
  String? sourceTitle;
  String? fromTitle;
  String? letterNumber;
  String? letterDate;
  String? attachCount;
  String? securityTypeTitle;
  String? refTitle;
  String? profilePic;
  String? lStateID;
  String? lStateTitle;

  CartableData(
      this.letterID,
      this.historyID,
      this.letterTypeTitle,
      this.actionTypeTitle,
      this.hDate,
      this.deadLine,
      this.priorityTypeTitle,
      this.header,
      this.sourceTitle,
      this.fromTitle,
      this.letterNumber,
      this.letterDate,
      this.attachCount,
      this.securityTypeTitle,
      this.refTitle,
      this.profilePic,
      this.lStateID,
      this.lStateTitle);
  factory CartableData.fromMap(Map<String, dynamic> parsedJson) {
    return CartableData(
      parsedJson['LetterID'],
      parsedJson['HistoryID'],
      parsedJson['LetterTypeTitle'],
      parsedJson['ActionTypeTitle'],
      parsedJson['HDate'],
      parsedJson['DeadLine'],
      parsedJson['PriorityTypeTitle'],
      parsedJson['Header'],
      parsedJson['SourceTitle'],
      parsedJson['fromTitle'],
      parsedJson['LetterNumber'],
      parsedJson['LetterDate'],
      parsedJson['AttachCount'],
      parsedJson['SecurityTypeTitle'],
      parsedJson['Reftitle'],
      parsedJson['profilepic'],
      parsedJson['LStateID'],
      parsedJson['LStateTitle'],
    );
  }
}

class ErpCartableModel {
  final List<ErpCartableData> catableData;

  ErpCartableModel(this.catableData);
  factory ErpCartableModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    //print(list.runtimeType);
    List<ErpCartableData> msgList =
        list.map((i) => ErpCartableData.fromMap(i)).toList();
    return ErpCartableModel(msgList);
  }
}

class ErpCartableData {
  String? history;
  String? requestID;
  String? formName_F;
  String? requester;
  String? profile;
  String? priority;
  String? date;
  String? icon;
  String itemsTitle;

  ErpCartableData(
    this.history,
    this.requestID,
    this.formName_F,
    this.requester,
    this.profile,
    this.priority,
    this.date,
    this.icon,
    this.itemsTitle,
  );
  factory ErpCartableData.fromMap(Map<String, dynamic> parsedJson) {
    return ErpCartableData(
      parsedJson['History'],
      parsedJson['Requestid'],
      parsedJson['formName_F'],
      parsedJson['Requester'],
      parsedJson['profile'],
      parsedJson['priority'],
      parsedJson['date'],
      parsedJson['icon'],
      parsedJson['itemstitle'],
    );
  }
}
