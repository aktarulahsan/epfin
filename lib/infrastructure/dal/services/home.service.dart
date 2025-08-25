import 'package:dio/dio.dart';
import 'package:epfin/constant/api_endpoint.dart';

class HomeService {
  static Future<Response> getStatement(var mail) async {
    //  https://dev.api.lead.academy:6071/auth/login
    Response? response;
    var dio = Dio();
    var url = '${ApiEndPoints.baseUrl}${ApiEndPoints.getStatement(mail)}';
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

  static Future<Response> getStatementByShortCode(
    var shortCode,
    var date,
  ) async {
    //  https://dev.api.lead.academy:6071/auth/login
    Response? response;
    var dio = Dio();
    var url =
        '${ApiEndPoints.baseUrl}${ApiEndPoints.getStatementByShortCode(shortCode, date)}';
    print("url - getStatementByShortCode $url");
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
