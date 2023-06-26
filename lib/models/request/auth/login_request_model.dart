import 'dart:convert';

LoginRequestModel loginModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginModelToJson(LoginRequestModel data) => json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
