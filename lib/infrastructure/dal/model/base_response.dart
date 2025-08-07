// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromJson(jsonString);

import 'dart:convert';

BaseResponse baseResponseFromJson(String str) => BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  String? message;
  bool? success;
  dynamic data;
  dynamic dataList;

  BaseResponse({
    this.message,
    this.success,
    this.data,
    this.dataList,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    message: json["message"],
    success: json["success"],
    data: json["data"],
    dataList: json["dataList"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data,
    "dataList": dataList,
  };
}
