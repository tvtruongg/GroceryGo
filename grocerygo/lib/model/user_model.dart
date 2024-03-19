class UserModel {
  int? userId;
  int? uType;
  String? userName;
  String? uEmail;
  String? uRefreshToken;
  String? uAccessToken;
  String? uMobileCode;
  String? uResetCode;
  int? uStatus;
  String? uCreatedDate;
  String? uModifyDate;

  UserModel(
      {this.userId,
      this.uType,
      this.userName,
      this.uEmail,
      this.uRefreshToken,
      this.uAccessToken,
      this.uMobileCode,
      this.uResetCode,
      this.uStatus,
      this.uCreatedDate,
      this.uModifyDate});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    uType = json['u_type'];
    userName = json['user_name'];
    uEmail = json['u_email'];
    uRefreshToken = json['u_refresh_token'];
    uAccessToken = json['u_access_token'];
    uMobileCode = json['u_mobile_code'];
    uResetCode = json['u_reset_code'];
    uStatus = json['u_status'];
    uCreatedDate = json['u_created_date'];
    uModifyDate = json['u_modify_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = userId;
    data['u_type'] = uType;
    data['user_name'] = userName;
    data['u_email'] = uEmail;
    data['u_refresh_token'] = uRefreshToken;
    data['u_access_token'] = uAccessToken;
    data['u_mobile_code'] = uMobileCode;
    data['u_reset_code'] = uResetCode;
    data['u_status'] = uStatus;
    data['u_created_date'] = uCreatedDate;
    data['u_modify_date'] = uModifyDate;
    return data;
  }
}