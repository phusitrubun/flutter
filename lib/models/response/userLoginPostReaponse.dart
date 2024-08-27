// To parse this JSON data, do
//
//     final userLoginPostResponse = userLoginPostResponseFromJson(jsonString);

import 'dart:convert';

UserLoginPostResponse userLoginPostResponseFromJson(String str) => UserLoginPostResponse.fromJson(json.decode(str));

String userLoginPostResponseToJson(UserLoginPostResponse data) => json.encode(data.toJson());

class UserLoginPostResponse {
    String message;
    User user;

    UserLoginPostResponse({
        required this.message,
        required this.user,
    });

    factory UserLoginPostResponse.fromJson(Map<String, dynamic> json) => UserLoginPostResponse(
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
    };
}

class User {
    int uid;
    String username;
    String email;
    int tid;
    int wallet;

    User({
        required this.uid,
        required this.username,
        required this.email,
        required this.tid,
        required this.wallet,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        tid: json["tid"],
        wallet: json["wallet"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "tid": tid,
        "wallet": wallet,
    };
}
