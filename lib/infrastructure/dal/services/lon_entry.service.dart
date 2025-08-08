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
  
}