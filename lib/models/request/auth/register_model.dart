import 'dart:convert';

RegisterRequestModel registerModelFromJson(String str) => RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) => json.encode(data.toJson());

class RegisterRequestModel {
    final String username;
    final String email;
    final String password;

    RegisterRequestModel({
        required this.username,
        required this.email,
        required this.password,
    });

    factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => RegisterRequestModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
    };
}
