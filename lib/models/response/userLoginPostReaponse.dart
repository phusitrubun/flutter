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
    String password;
    int tid;
    int wallet;

    User({
        required this.uid,
        required this.username,
        required this.email,
        required this.password,
        required this.tid,
        required this.wallet,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        tid: json["tid"],
        wallet: json["wallet"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "password": password,
        "tid": tid,
        "wallet": wallet,
    };
}
