// To parse this JSON data, do
//
//     final statementModel = statementModelFromJson(jsonString);

import 'dart:convert';

StatementModel statementModelFromJson(String str) => StatementModel.fromJson(json.decode(str));

String statementModelToJson(StatementModel data) => json.encode(data.toJson());
// List<StatementModel> statementModelListFromJson(var v) => List<StatementModel>.from(
//     json.decode(v!).map((x) => StatementModel.fromJson(x)));

List<StatementModel> statementModelListFromJson(dynamic v) =>
    List<StatementModel>.from(v.map((x) => StatementModel.fromJson(x)));

class StatementModel {
  int? id;
  DateTime? balanceDate;
  String? shortCode;
  String? companyName;
  double? totalLone;
  double? overDue;
  double? ss;
  double? bl;
  String? status;
  String? displayCompany;

  StatementModel({
    this.id,
    this.balanceDate,
    this.shortCode,
    this.companyName,
    this.totalLone,
    this.overDue,
    this.ss,
    this.bl,
    this.status,
    this.displayCompany,
  });

  factory StatementModel.fromJson(Map<String, dynamic> json) => StatementModel(
    id: json["id"],
    balanceDate: json["balanceDate"] == null ? null : DateTime.parse(json["balanceDate"]),
    shortCode: json["shortCode"],
    companyName: json["companyName"],
    totalLone: json["totalLone"],
    overDue: json["overDue"],
    ss: json["ss"],
    bl: json["bl"],
    status: json["status"],
    displayCompany: json["displayCompany"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "balanceDate": balanceDate?.toIso8601String(),
    "shortCode": shortCode,
    "companyName": companyName,
    "totalLone": totalLone,
    "overDue": overDue,
    "ss": ss,
    "bl": bl,
    "status": status,
    "displayCompany": displayCompany,
  };
}
