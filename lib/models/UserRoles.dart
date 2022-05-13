class UserRoleModel {
  final List<RoleData> rolesData;

  UserRoleModel(this.rolesData);
  factory UserRoleModel.fromMap(List<dynamic> parsedJson) {
    var list = parsedJson;
    //print(list.runtimeType);
    List<RoleData> itemList = list.map((i) => RoleData.fromMap(i)).toList();
    return UserRoleModel(itemList);
  }
}

class RoleData {
  String? roleID;
  String? roleTitle;

  RoleData(this.roleID, this.roleTitle);
  factory RoleData.fromMap(Map<String, dynamic> parsedJson) {
    return RoleData(
      parsedJson['RoleID'],
      parsedJson['Title'],
    );
  }
}
