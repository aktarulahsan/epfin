import 'dart:convert';

LoginModel loginResponseFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginResponseToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? userId;
  String? u; // For Firebase User UID
  String? companyName; // For Firebase User Company Name
  String? role; // For Firebase User Role
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
  String? userTypeName;

  LoginModel({
    this.userId,
    this.u,
    this.companyName,
    this.role,
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
    this.userTypeName,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    userId: json["userId"],
    u: json["u"] ?? '',
    companyName: json["companyName"] ?? '',
    role: json["role"] ?? '',
    name: json["name"],
    email: json["email"],
    password: json["password"],
    hostName: json["hostName"],
    exist: json["exist"],
    ischangePassword: json["ischangePassword"],
    userType: json["userType"],
    lastUpdate:
        json["lastUpdate"] == null ? null : DateTime.parse(json["lastUpdate"]),
    searchText: json["searchText"],
    displayText: json["displayText"],
    token: json["token"],
    userTypeName: json["userTypeName"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "u": u,
    "companyName": companyName,
    "role": role,
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
    "userTypeName": userTypeName,
  };
}
