class SideMenuModel {
  final List<MenuItemsData> menuData;

  SideMenuModel(this.menuData);
  factory SideMenuModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    //print(list.runtimeType);
    List<MenuItemsData> msgList =
        list.map((i) => MenuItemsData.fromMap(i)).toList();
    return SideMenuModel(msgList);
  }
}

class MenuItemsData {
  String? title;
  String? count;
  String? action;

  MenuItemsData(this.title, this.count, this.action);
  factory MenuItemsData.fromMap(Map<String, dynamic> parsedJson) {
    return MenuItemsData(
      parsedJson['Title'],
      parsedJson['Count'],
      parsedJson['Action'],
    );
  }
}
