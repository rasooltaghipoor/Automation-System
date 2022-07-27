class ErpReplyButtonsModel {
  final List<ReplyButtonData> itemsData;

  ErpReplyButtonsModel(this.itemsData);
  factory ErpReplyButtonsModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<ReplyButtonData> itemList =
        list.map((i) => ReplyButtonData.fromMap(i)).toList();
    return ErpReplyButtonsModel(itemList);
  }
}

class ReplyButtonData {
  String? commandID;
  String? cammandTitle;

  ReplyButtonData(this.commandID, this.cammandTitle);
  factory ReplyButtonData.fromMap(Map<String, dynamic> parsedJson) {
    return ReplyButtonData(
      parsedJson['Commandid'],
      parsedJson['Caption'],
    );
  }
}
