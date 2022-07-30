class LoginResponse {
  Data? data;
  int? code;
  String? message;

  LoginResponse({this.data, this.code, this.message});

  LoginResponse.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    code = json['code'];
    message = json['message'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? token;
  String? passwordHash;
  String? email;
  int? userId;
  String? userName;

  Data({this.token, this.passwordHash, this.email, this.userId, this.userName});

  Data.fromJson(Map<dynamic, dynamic> json) {
    token = json['token'];
    passwordHash = json['passwordHash'];
    email = json['email'];
    userId = json['userId'];
    userName = json['userName'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['token'] = this.token;
    data['passwordHash'] = this.passwordHash;
    data['email'] = this.email;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    return data;
  }
}