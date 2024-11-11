class LoggedUserModel {
  User? user;
  String? message;
  String? status;

  LoggedUserModel({this.user, this.message, this.status});

  LoggedUserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  // Null? avatar;
  // Null? emailVerifiedAt;
  // Null? twoFactorSecret;
  // Null? twoFactorRecoveryCodes;
  // Null? twoFactorConfirmedAt;
  // Null? username;
  // Null? mobile;
  // Null? roleSuper;
  // Null? roleId;
  // Null? forgottenPasswordTime;
  String? role;
  int? status;
  String? createdAt;
  String? updatedAt;
  // Null? lastLoginAt;
  // Null? lastLoginIp;
  // Null? deletedAt;

  User(
      {this.id,
      this.name,
      this.email,
      // this.avatar,
      // this.emailVerifiedAt,
      // this.twoFactorSecret,
      // this.twoFactorRecoveryCodes,
      // this.twoFactorConfirmedAt,
      // this.username,
      // this.mobile,
      // this.roleSuper,
      // this.roleId,
      // this.forgottenPasswordTime,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt,
      // this.lastLoginAt,
      // this.lastLoginIp,
      // this.deletedAt
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    // avatar = json['avatar'];
    // emailVerifiedAt = json['email_verified_at'];
    // twoFactorSecret = json['two_factor_secret'];
    // twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    // twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    // username = json['username'];
    // mobile = json['mobile'];
    // roleSuper = json['role_super'];
    // roleId = json['role_id'];
    // forgottenPasswordTime = json['forgotten_password_time'];
    role = json['role'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // lastLoginAt = json['last_login_at'];
    // lastLoginIp = json['last_login_ip'];
    // deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    // data['avatar'] = this.avatar;
    // data['email_verified_at'] = this.emailVerifiedAt;
    // data['two_factor_secret'] = this.twoFactorSecret;
    // data['two_factor_recovery_codes'] = this.twoFactorRecoveryCodes;
    // data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    // data['username'] = this.username;
    // data['mobile'] = this.mobile;
    // data['role_super'] = this.roleSuper;
    // data['role_id'] = this.roleId;
    // data['forgotten_password_time'] = this.forgottenPasswordTime;
    data['role'] = role;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    // data['last_login_at'] = this.lastLoginAt;
    // data['last_login_ip'] = this.lastLoginIp;
    // data['deleted_at'] = this.deletedAt;
    return data;
  }
}
