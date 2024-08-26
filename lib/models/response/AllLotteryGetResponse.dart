import 'dart:convert';

List<AllLotteryGetResponse> allLotteryGetResponseFromJson(String str) =>
    List<AllLotteryGetResponse>.from(
        json.decode(str).map((x) => AllLotteryGetResponse.fromJson(x)));

String allLotteryGetResponseToJson(List<AllLotteryGetResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllLotteryGetResponse {
  int lid;
  int number;
  int price;
  int status;
  List<dynamic> lotteryOwns;

  AllLotteryGetResponse({
    required this.lid,
    required this.number,
    required this.price,
    required this.status,
    required this.lotteryOwns,
  });

  factory AllLotteryGetResponse.fromJson(Map<String, dynamic> json) =>
      AllLotteryGetResponse(
        lid: json["lid"],
        number: json["number"],
        price: json["price"],
        status: json["status"],
        lotteryOwns: List<dynamic>.from(json["lotteryOwns"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "lid": lid,
        "number": number,
        "price": price,
        "status": status,
        "lotteryOwns": List<dynamic>.from(lotteryOwns.map((x) => x)),
      };
}
