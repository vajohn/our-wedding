class UserData {
  late List<String> roles;

  UserData({required this.roles});

  UserData.fromJson(Map<String, dynamic>? json) {
    roles = json!['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roles'] = this.roles;
    return data;
  }
}
class Users {
  String? displayName;
  String? email;
  String? password;
  String? phone;
  String? role;
  String? uuid;

  Users();

  Users.fromMap(Map<String, dynamic> data) {
    displayName = data['displayName'];
    email = data['email'];
    password = data['password'];
    phone = data['phone'];
    role = data['role'];
    uuid = data['uuid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
      'uuid': uuid,
    };
  }
}