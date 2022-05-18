class RequestListModel {
  List<Request> items;

  RequestListModel(this.items);

  factory RequestListModel.fromMap(Map<String, dynamic> parsedJson) {
    //TODO: What to to do when the items are empty?
    if (parsedJson['items'] == '') {
      List<Request> itemList = [];
      return RequestListModel(
        itemList,
      );
    }
    var list = parsedJson['items'] as List;
    List<Request> itemList = list.map((i) => Request.fromMap(i)).toList();
    return RequestListModel(
      itemList,
    );
  }
}

class Request {
  String requestID;
  String formName_F;
  String priority;
  String state;
  String date;
  String icon;
  String itemsTitle;

  Request(this.requestID, this.formName_F, this.priority, this.state, this.date,
      this.icon, this.itemsTitle);

  factory Request.fromMap(Map<String, dynamic> parsedJson) {
    return Request(
      parsedJson['Requestid'],
      parsedJson['formname_F'],
      parsedJson['priority'],
      parsedJson['Column1'],
      parsedJson['Column2'],
      parsedJson['icon'],
      parsedJson['itemstitle'],
    );
  }
}

class RequestDetail {}
