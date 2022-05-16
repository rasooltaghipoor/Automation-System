class RequestMenuModel {
  String title;
  final List<RequestItem> items;

  RequestMenuModel(this.title, this.items);
  factory RequestMenuModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['RequestType'] as List;
    var listItem = list[0];
    var items = listItem['items'] as List;
    //print(list.runtimeType);
    List<RequestItem> itemList =
        items.map((i) => RequestItem.fromMap(i)).toList();
    return RequestMenuModel(listItem['title'], itemList);
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
