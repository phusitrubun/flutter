import 'dart:convert';

UserLoginPostReqest userLoginPostReqestFromJson(String str) => UserLoginPostReqest.fromJson(json.decode(str));

String userLoginPostReqestToJson(UserLoginPostReqest data) => json.encode(data.toJson());

class UserLoginPostReqest {
    String email;
    String password;

    UserLoginPostReqest({
        required this.email,
        required this.password,
    });

    factory UserLoginPostReqest.fromJson(Map<String, dynamic> json) => UserLoginPostReqest(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
