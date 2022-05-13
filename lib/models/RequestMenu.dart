class RequestMenuModel {
  String title;
  final List<RequestItem> items;

  RequestMenuModel(this.title, this.items);
  factory RequestMenuModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['RequestType'] as List;
    //print(list.runtimeType);
    List<RequestItem> itemList =
        list[0]['items'].map((i) => RequestItem.fromMap(i)).toList();
    return RequestMenuModel(list[0]['title'], itemList);
  }
}

class RequestItem {
  String? id;
  String? title;

  RequestItem(this.id, this.title);
  factory RequestItem.fromMap(Map<String, dynamic> parsedJson) {
    return RequestItem(
      parsedJson['id'],
      parsedJson['title'],
    );
  }
}
