import 'dart:convert';

GetLotteryOwner getLotteryOwnerFromJson(String str) =>
    GetLotteryOwner.fromJson(json.decode(str));

String getLotteryOwnerToJson(GetLotteryOwner data) =>
    json.encode(data.toJson());

class GetLotteryOwner {
  List<Lotterylist> lotterylist;

  GetLotteryOwner({
    required this.lotterylist,
  });

  factory GetLotteryOwner.fromJson(Map<String, dynamic> json) =>
      GetLotteryOwner(
        lotterylist: List<Lotterylist>.from(
            json["lotterylist"].map((x) => Lotterylist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lotterylist": List<dynamic>.from(lotterylist.map((x) => x.toJson())),
      };
}

class Lotterylist {
  int lid;
  int number;
  int price;
  int status;
  int uid;

  Lotterylist({
    required this.lid,
    required this.number,
    required this.price,
    required this.status,
    required this.uid,
  });

  factory Lotterylist.fromJson(Map<String, dynamic> json) => Lotterylist(
        lid: json["lid"],
        number: json["number"],
        price: json["price"],
        status: json["status"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "lid": lid,
        "number": number,
        "price": price,
        "status": status,
        "uid": uid,
      };
}
