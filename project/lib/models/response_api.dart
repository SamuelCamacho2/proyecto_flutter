import 'dart:convert';

ResponseApi responseApiFromJson(String str) => ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
    String? message;
    String? error;
    bool? succes;
    dynamic data;

    ResponseApi({
        required this.message,
        required this.error,
        required this.succes,
    });

    ResponseApi.fromJson(Map<String, dynamic> json) {
        message = json["message"];
        error = json["error"];
        succes = json["succes"];
        try {
          data = json["data"];
        } catch (e) {
          print('execption: $e');
        }
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "succes": succes,
    };
}
