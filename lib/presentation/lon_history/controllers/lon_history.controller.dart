import 'package:epfin/infrastructure/dal/model/statement.model.dart';
import 'package:epfin/infrastructure/dal/services/lon_history.service.dart';
import 'package:epfin/infrastructure/navigation/bindings/controllers/auth.controller.binding.dart';
import 'package:epfin/main.dart';
import 'package:epfin/presentation/auth/auth.screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../infrastructure/dal/model/base_response.dart';

class LonHistoryController extends GetxController {
  //TODO: Implement LonHistoryController
  var selectedDate = DateTime(2025, 8, 9).obs;


  var date = "".obs;
  var isLoading = 0.obs;
  var statementList = <StatementModel>[].obs;

  @override
  void onInit() {
    getStatement();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() async {
    prefs.remove('userInfo');
    Get.offAll(const AuthScreen(), binding: AuthControllerBinding());
  }

  final showDrawer = false.obs;
  void toggleDrawer() {
    showDrawer.value = !showDrawer.value;
  }



  Future<void> getStatement() async {
    isLoading.value = 1;
    var mail = prefs.get('mail');
    String date = dateFormat(selectedDate.value);

    await LonHistoryService.getStatementHistory(mail,date).then((value) async {
      BaseResponse responses = BaseResponse();
      try{
        responses = BaseResponse.fromJson(value.data);
        if (responses.dataList !=null) {
          statementList.value = statementModelListFromJson(responses.dataList);
          print("statement lis is  ${statementList.length}");
        } else {

        }
      }catch(e){
        print(e);
      }finally{
        isLoading.value = 0;
      }
    });
  }
  String dateFormat(DateTime date) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }



}
