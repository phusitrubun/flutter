// To parse this JSON data, do
//
//     final lotteriesIOwnAndOnStoreGetResponse = lotteriesIOwnAndOnStoreGetResponseFromJson(jsonString);

import 'dart:convert';

LotteriesIOwnAndOnStoreGetResponse lotteriesIOwnAndOnStoreGetResponseFromJson(String str) => LotteriesIOwnAndOnStoreGetResponse.fromJson(json.decode(str));

String lotteriesIOwnAndOnStoreGetResponseToJson(LotteriesIOwnAndOnStoreGetResponse data) => json.encode(data.toJson());

class LotteriesIOwnAndOnStoreGetResponse {
    String message;
    List<Lottery> lotteries;

    LotteriesIOwnAndOnStoreGetResponse({
        required this.message,
        required this.lotteries,
    });

    factory LotteriesIOwnAndOnStoreGetResponse.fromJson(Map<String, dynamic> json) => LotteriesIOwnAndOnStoreGetResponse(
        message: json["message"],
        lotteries: List<Lottery>.from(json["lotteries"].map((x) => Lottery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "lotteries": List<dynamic>.from(lotteries.map((x) => x.toJson())),
    };
}

class Lottery {
    int lid;
    int number;
    int price;
    int status;

    Lottery({
        required this.lid,
        required this.number,
        required this.price,
        required this.status,
    });

    factory Lottery.fromJson(Map<String, dynamic> json) => Lottery(
        lid: json["lid"],
        number: json["number"],
        price: json["price"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "lid": lid,
        "number": number,
        "price": price,
        "status": status,
    };
}
