import 'package:dio/dio.dart';

import '../../../constant/api_endpoint.dart';

class LonHistoryService {


  static Future<Response> getStatementHistory(var mail,var date) async {
    //  https://dev.api.lead.academy:6071/auth/login
    Response? response;
    var dio = Dio();
    var url = '${ApiEndPoints.baseUrl}${ApiEndPoints.getStatementHistory(mail, date)}';
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