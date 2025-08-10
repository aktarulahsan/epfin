import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:epfin/constant/api_endpoint.dart';

class LonEntryService {
  static Future<Response> getCompany(var mail) async {
    //  https://dev.api.lead.academy:6071/auth/login
    Response? response;
    var dio = Dio();
    var url = '${ApiEndPoints.baseUrl}${ApiEndPoints.getCompany(mail)}';
    print("url - logIn $url");
    try {
      response = await dio.get(
        url,
        options: Options(contentType: Headers.jsonContentType),
      );
    } catch (e) {
      // if (kDebugMode) {
      print(e);
      // }
    }
    return response!;
  }

  static Future<Response> submitData({
    required int id,
    required String shortCode,
    required double totalLoan,
    required double overDue,
    required double ss,
    required double bl,
    required String status,
    required DateTime balanceDate,
    required DateTime entryDateTime,
    required String hostName,
  }) async {
    Response? response;
    var dio = Dio();
    var url = '${ApiEndPoints.baseUrl}${ApiEndPoints.submit()}';
    final jsonData = jsonEncode({
      "id": id,
      "shortCode": shortCode,
      "totalLone": totalLoan,
      "overDue": overDue,
      "ss": ss,
      "bl": bl,
      "status": status,
      "balanceDate": balanceDate.toIso8601String(),
      "entryDateTime": entryDateTime.toIso8601String(),
      "hostName": hostName,
    });
    print(url);

    try {
      response = await dio.post(
        url,
        data: jsonData,
        options: Options(contentType: Headers.jsonContentType),
      );
    } catch (e) {
      print("Submit Error: $e");
    }
    return response!;
  }
}
