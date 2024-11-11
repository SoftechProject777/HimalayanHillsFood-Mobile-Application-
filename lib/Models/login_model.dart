class LoginClass {
  String? username;
  String? password;

  LoginClass.fromJson(Map<String, dynamic> json) {
    username = json['username'] as String;
    password = json['password'] as String;
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
