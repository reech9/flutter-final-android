class LoginResponse {
  bool? success;
  String? token;
  String? userId;

  LoginResponse({this.success, this.token, this.userId});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(success: json['success'], token: json['token'], userId: json["userId"]);
  }

  Map<String, dynamic> toJson() => {"success": success, "token": token, "userId": userId};
}
