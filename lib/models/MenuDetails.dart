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

class ErpSideMenuModel {
  final List<ErpMenuItemsData> menuData;

  ErpSideMenuModel(this.menuData);
  factory ErpSideMenuModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['menu'] as List;
    //print(list.runtimeType);
    List<ErpMenuItemsData> msgList =
        list.map((i) => ErpMenuItemsData.fromMap(i)).toList();
    return ErpSideMenuModel(msgList);
  }
}

class ErpMenuItemsData {
  String? id;
  String? title;
  String? count;

  ErpMenuItemsData(this.id, this.title, this.count);
  factory ErpMenuItemsData.fromMap(Map<String, dynamic> parsedJson) {
    return ErpMenuItemsData(
      parsedJson['id'],
      parsedJson['title'],
      parsedJson['Count'],
    );
  }
}
