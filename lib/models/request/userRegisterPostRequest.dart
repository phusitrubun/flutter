// To parse this JSON data, do
//
//     final userRegisterPostRequest = userRegisterPostRequestFromJson(jsonString);

import 'dart:convert';

UserRegisterPostRequest userRegisterPostRequestFromJson(String str) => UserRegisterPostRequest.fromJson(json.decode(str));

String userRegisterPostRequestToJson(UserRegisterPostRequest data) => json.encode(data.toJson());

class UserRegisterPostRequest {
    String username;
    String email;
    String password;

    UserRegisterPostRequest({
        required this.username,
        required this.email,
        required this.password,
    });

    factory UserRegisterPostRequest.fromJson(Map<String, dynamic> json) => UserRegisterPostRequest(
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
