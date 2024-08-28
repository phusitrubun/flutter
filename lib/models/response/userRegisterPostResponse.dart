// To parse this JSON data, do
//
//     final userRegisterPostResponse = userRegisterPostResponseFromJson(jsonString);

import 'dart:convert';

UserRegisterPostResponse userRegisterPostResponseFromJson(String str) => UserRegisterPostResponse.fromJson(json.decode(str));

String userRegisterPostResponseToJson(UserRegisterPostResponse data) => json.encode(data.toJson());

class UserRegisterPostResponse {
    String message;

    UserRegisterPostResponse({
        required this.message,
    });

    factory UserRegisterPostResponse.fromJson(Map<String, dynamic> json) => UserRegisterPostResponse(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
