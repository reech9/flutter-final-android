import 'dart:convert';

class User {
  String? firstName;
  String? lastName;
  String? age;
  String? dob;
  String? email;
  String? password;
  User(
      {this.firstName,
      this.lastName,
      this.age,
      this.email,
      this.password,
      this.dob});

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        age: json["age"],
        email: json["email"],
        password: json["password"],
        dob: json["dob"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "email": email,
        "password": password,
        "dob": dob,
      };
}

UserDetail userDetailFromJson(String str) =>
    UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  UserDetail({
    required this.data,
  });

  User data;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}
