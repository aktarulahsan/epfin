import 'dart:convert';

CompanyModel companyModelFromJson(String str) => CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
    String shortCode;
    String name;
    String logo;

    CompanyModel({
        required this.shortCode,
        required this.name,
        required this.logo,
    });

    factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        shortCode: json["shortCode"],
        name: json["name"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "shortCode": shortCode,
        "name": name,
        "logo": logo,
    };
}
