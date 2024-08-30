import 'dart:convert';

AwardRankPrizePostResponse awardRankPrizePostResponseFromJson(String str) => AwardRankPrizePostResponse.fromJson(json.decode(str));

String awardRankPrizePostResponseToJson(AwardRankPrizePostResponse data) => json.encode(data.toJson());

class AwardRankPrizePostResponse {
    String message;

    AwardRankPrizePostResponse({
        required this.message,
    });

    factory AwardRankPrizePostResponse.fromJson(Map<String, dynamic> json) => AwardRankPrizePostResponse(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}