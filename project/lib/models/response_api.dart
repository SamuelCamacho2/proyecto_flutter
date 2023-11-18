import 'dart:convert';

ResponseApi responseApiFromJson(String str) =>
    ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  String? message;
  String? error;
  bool? success;
  dynamic data;

  ResponseApi({
    required this.message,
    required this.error,
    required this.success,
  });

  ResponseApi.fromJson(Map<String, dynamic> json) {
    message = json["message"] as String?;
    error = json["error"] as String?;
    success = json["success"] as bool?;
    try {
      data = json["data"];
    } catch (e) {
      print('execption: $e');
    }
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "success": success,
        "data": data,
      };
}
