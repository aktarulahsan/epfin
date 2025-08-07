import 'package:epfin/config.dart';

class ApiEndPoints {
  ApiEndPoints._privateConstructor();
  static final ApiEndPoints instance = ApiEndPoints._privateConstructor();
  static const String baseUrl ="https://epgl.schsems.com/";

  static const String splash = "splash";
  static const String login = "api/Account/login";
  // static const String getStatement = "api/Account/get-company-statement?Email=sahadat.26%40gmail.com'";
  static String getStatement(String mail) => "api/Account/get-company-statement?Email=$mail";
  static const String checkUserExist = "user/check-user";
  static const String register = "auth/user/register";
  static const String getMenuProtectedData = "api/menuPassword/list";


}