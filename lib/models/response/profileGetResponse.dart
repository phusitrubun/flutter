
import 'dart:convert';

ProfileGetResponse profileGetResponseFromJson(String str) => ProfileGetResponse.fromJson(json.decode(str));

String profileGetResponseToJson(ProfileGetResponse data) => json.encode(data.toJson());

class ProfileGetResponse {
    int uid;
    String username;
    String email;
    int tid;
    int wallet;
   

    ProfileGetResponse({
        required this.uid,
        required this.username,
        required this.email,
        required this.tid,
        required this.wallet,
     
    });

    factory ProfileGetResponse.fromJson(Map<String, dynamic> json) => ProfileGetResponse(
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
