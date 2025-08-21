class ApiEndPoints {
  ApiEndPoints._privateConstructor();
  static final ApiEndPoints instance = ApiEndPoints._privateConstructor();
  // static const String baseUrl = "https://epgl.schsems.com/";

  static const String baseUrl = "http://116.68.205.179/";

  static const String splash = "splash";
  static const String login = "api/Account/login";
  // static const String getStatement = "api/Account/get-company-statement?Email=sahadat.26%40gmail.com'";
  static String getStatement(String mail) =>
      "api/Account/get-company-statement?Email=$mail";

  static String getStatementByShortCode(String shortCode, String date) =>
      "api/Account/get-loan?shortCode=$shortCode&balanceDate=$date";
  // api/Account/get-loan?shortCode=EEL&balanceDate=2025-08-09T00%3A00%3A00

  static String getStatementHistory(String mail, String date) =>
      "api/Account/get-company-statement-history?Email=$mail&BalanceDate=$date"; //2025-08-06

  static String getCompany(String mail) =>
      "api/Account/get-company-list?Email=$mail";
  static String submit() => "api/Account/add-update-loan";
  static String changePassword = "api/Account/ChangePassword";

  static String deleteUser(int userid) =>
      "api/Account/ActiveDeactive?UserID=$userid";

  static String register() => "api/Account/Register";

  static String getStatusList = "api/Account/get-status-list";

  static String getUserList = "api/Account/UserGetAll";

  //
  // // api/Account/get-company-list?Email=sahadat.26%40gmail.com
  // static const String checkUserExist = "user/check-user";
  // static const String register = "auth/user/register";
  // static const String getMenuProtectedData = "api/menuPassword/list";
}
