import 'dart:convert';

GenerateLotteriesPostResponse generateLotteriesPostResponseFromJson(String str) => GenerateLotteriesPostResponse.fromJson(json.decode(str));

String generateLotteriesPostResponseToJson(GenerateLotteriesPostResponse data) => json.encode(data.toJson());

class GenerateLotteriesPostResponse {
    int count;

    GenerateLotteriesPostResponse({
        required this.count,
    });

    factory GenerateLotteriesPostResponse.fromJson(Map<String, dynamic> json) => GenerateLotteriesPostResponse(
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
    };
}
