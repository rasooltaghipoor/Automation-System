class User {
  String? userId;
  String? name;
  String? roleID;
  String? defaultRole;
  String? profilePic;
  String? token;
  String? renewalToken;
  int? roleCount;

  User(
      {this.userId,
      this.name,
      this.roleID,
      this.defaultRole,
      this.profilePic,
      this.token,
      this.renewalToken,
      this.roleCount});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['UserID'],
        name: responseData['username'],
        roleID: responseData['DefaultRoleid'],
        defaultRole: responseData['DefaultRole'],
        profilePic: responseData['profile'],
        token: responseData['token'],
        renewalToken: '',
        roleCount: 1); //responseData['renewal_token']);
  }
}

/// This class is responsible for deserilizing user data
class UserModel {
  List<UserData> userData;

  UserModel(this.userData);

  factory UserModel.fromMap(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<UserData> msgList = list.map((i) => UserData.fromMap(i)).toList();
    return UserModel(msgList);
  }
}

class UserData {
  String? name;
  String? roleID;
  String? role;
  String? img;

  UserData(this.name, this.roleID, this.role, this.img);

  factory UserData.fromMap(Map<String, dynamic> parsedJson) {
    return UserData(
      parsedJson['Name'],
      parsedJson['RoleID'],
      parsedJson['Role'],
      parsedJson['img'],
    );
  }
}
