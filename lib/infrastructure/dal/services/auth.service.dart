import 'package:dio/dio.dart';

import '../../../constant/api_endpoint.dart';

class AuthService {
  static Future<Response> logIn(var userId, var pass) async {
    //  https://dev.api.lead.academy:6071/auth/login
    Response? response;
    var dio = Dio();
    var url = '${ApiEndPoints.baseUrl}${ApiEndPoints.login}';
    print("url - logIn $url");
    try {
      response = await dio.post(
        url,
        data: {'email': '$userId', 'password': '$pass'},
        options: Options(contentType: Headers.jsonContentType),
      );
    } catch (e) {
      // if (kDebugMode) {
      print(e);
      // }
    }
    return response!;
  }

  static Future<Response> deleteUser(var userId) async {
    //  https://dev.api.lead.academy:6071/auth/login
    Response? response;
    var dio = Dio();
    var url = '${ApiEndPoints.baseUrl}${ApiEndPoints.deleteUser(userId)}';
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
}
