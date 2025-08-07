import 'dart:convert';

LoginModel loginResponseFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginResponseToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? userId;
  String? name;
  String? email;
  String? password;
  String? hostName;
  bool? exist;
  bool? ischangePassword;
  int? userType;
  DateTime? lastUpdate;
  String? searchText;
  String? displayText;
  String? token;

  LoginModel({
    this.userId,
    this.name,
    this.email,
    this.password,
    this.hostName,
    this.exist,
    this.ischangePassword,
    this.userType,
    this.lastUpdate,
    this.searchText,
    this.displayText,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    userId: json["userId"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    hostName: json["hostName"],
    exist: json["exist"],
    ischangePassword: json["ischangePassword"],
    userType: json["userType"],
    lastUpdate: json["lastUpdate"] == null ? null : DateTime.parse(json["lastUpdate"]),
    searchText: json["searchText"],
    displayText: json["displayText"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "email": email,
    "password": password,
    "hostName": hostName,
    "exist": exist,
    "ischangePassword": ischangePassword,
    "userType": userType,
    "lastUpdate": lastUpdate?.toIso8601String(),
    "searchText": searchText,
    "displayText": displayText,
    "token": token,
  };
}
