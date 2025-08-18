import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:epfin/constant/api_endpoint.dart';

class RegistrationService {
  // This class is responsible for handling registration-related operations.
  // It can include methods for user registration, validation, etc.

  // Example method to register a user
  static Future<Response> registration({
    required String email,
    required String name,
    required String password,
    required int userType,
    required String companyName,
  }) async {
    Response? response;
    var dio = Dio();
    var url = '${ApiEndPoints.baseUrl}${ApiEndPoints.register()}';
    final jsonData = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
      "userType": userType,
      "companyName": companyName, // Assuming a default company name
    });


    print(url);

    try {
      response = await dio.post(
        url,
        data: jsonData,
        options: Options(contentType: Headers.jsonContentType),
      );
    } catch (e) {
      print("Registration Error: $e");
    }
    return response!;
  }
}
