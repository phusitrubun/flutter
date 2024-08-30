// To parse this JSON data, do
//
//     final lotteriesRankPrizeGetResponse = lotteriesRankPrizeGetResponseFromJson(jsonString);

import 'dart:convert';

LotteriesRankPrizeGetResponse lotteriesRankPrizeGetResponseFromJson(String str) => LotteriesRankPrizeGetResponse.fromJson(json.decode(str));

String lotteriesRankPrizeGetResponseToJson(LotteriesRankPrizeGetResponse data) => json.encode(data.toJson());

class LotteriesRankPrizeGetResponse {
    String message;
    List<DtoList> dtoList;

    LotteriesRankPrizeGetResponse({
        required this.message,
        required this.dtoList,
    });

    factory LotteriesRankPrizeGetResponse.fromJson(Map<String, dynamic> json) => LotteriesRankPrizeGetResponse(
        message: json["message"],
        dtoList: List<DtoList>.from(json["dtoList"].map((x) => DtoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "dtoList": List<dynamic>.from(dtoList.map((x) => x.toJson())),
    };
}

class DtoList {
    int wid;
    int lid;
    int uid;
    int number;
    int prize;
    int rank;

    DtoList({
        required this.wid,
        required this.lid,
        required this.uid,
        required this.number,
        required this.prize,
        required this.rank,
    });

    factory DtoList.fromJson(Map<String, dynamic> json) => DtoList(
        wid: json["wid"],
        lid: json["lid"],
        uid: json["uid"],
        number: json["number"],
        prize: json["prize"],
        rank: json["rank"],
    );

    Map<String, dynamic> toJson() => {
        "wid": wid,
        "lid": lid,
        "uid": uid,
        "number": number,
        "prize": prize,
        "rank": rank,
    };
}
