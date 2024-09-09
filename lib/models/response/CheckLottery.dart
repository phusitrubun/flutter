import 'dart:convert';

CheckLottery checkLotteryFromJson(String str) =>
    CheckLottery.fromJson(json.decode(str));

String checkLotteryToJson(CheckLottery data) => json.encode(data.toJson());

class CheckLottery {
  List<Result> results;
  int totalCount;

  CheckLottery({
    required this.results,
    required this.totalCount,
  });

  factory CheckLottery.fromJson(Map<String, dynamic> json) => CheckLottery(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((result) => result.toJson()).toList(),
      'totalCount': totalCount,
    };
  }
}

class Result {
  int lid;
  int number;
  int status;
  String textStatus;
  int uid;
  int prize;
  int rank;

  Result({
    required this.lid,
    required this.number,
    required this.status,
    required this.textStatus,
    required this.uid,
    required this.prize,
    required this.rank,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        lid: json["lid"],
        number: json["number"],
        status: json["status"],
        textStatus: json["textStatus"],
        uid: json["uid"],
        prize: json["prize"],
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "lid": lid,
        "number": number,
        "status": status,
        "textStatus": textStatus,
        "uid": uid,
        "prize": prize,
        "rank": rank,
      };
}
