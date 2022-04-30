class RequestListModel {
  List<Request> items;

  RequestListModel(this.items);

  factory RequestListModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<Request> itemList = list.map((i) => Request.fromMap(i)).toList();
    return RequestListModel(
      itemList,
    );
  }
}

class Request {
  String requestID;
  String requestDate;
  String formName_E;
  String formName_F;

  Request(this.requestID, this.requestDate, this.formName_E, this.formName_F);

  factory Request.fromMap(Map<String, dynamic> parsedJson) {
    return Request(
      parsedJson['Requestid'],
      parsedJson['Column1'],
      parsedJson['formname_E'],
      parsedJson['formname_F'],
    );
  }
}

class RequestDetail {}
