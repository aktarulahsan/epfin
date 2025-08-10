import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constant/api_endpoint.dart';

class ChangePasswordService{


  static Future<Response> changePassword({

    required String email,
    required String confirmPassword,
    required String newPassword,
    required String oldPassword,

  }) async {
    Response? response;
    var dio = Dio();
    var url = '${ApiEndPoints.baseUrl}${ApiEndPoints.changePassword}';
    final jsonData = jsonEncode({
    "email": email,
    "confirmPassword": confirmPassword,
    "newPassword": newPassword,
    "oldPassword": oldPassword
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