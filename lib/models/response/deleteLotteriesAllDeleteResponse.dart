import 'dart:convert';

DeleteLotteriesAllDeleteResponse deleteLotteriesAllDeleteResponseFromJson(String str) => DeleteLotteriesAllDeleteResponse.fromJson(json.decode(str));

String deleteLotteriesAllDeleteResponseToJson(DeleteLotteriesAllDeleteResponse data) => json.encode(data.toJson());

class DeleteLotteriesAllDeleteResponse {
    String message;

    DeleteLotteriesAllDeleteResponse({
        required this.message,
    });

    factory DeleteLotteriesAllDeleteResponse.fromJson(Map<String, dynamic> json) => DeleteLotteriesAllDeleteResponse(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
