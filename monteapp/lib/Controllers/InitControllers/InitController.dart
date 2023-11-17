import 'package:get/get.dart';
import 'package:monteapp/Controllers/CardController.dart';
import 'package:monteapp/Controllers/LevelsController.dart';
import 'package:monteapp/Controllers/LoginController.dart';
import 'package:monteapp/Controllers/MainCategoryController.dart';
import 'package:monteapp/Controllers/SignupController.dart';
import 'package:monteapp/Controllers/UserController.dart';

class InitController with Bindings{
  @override
  void dependencies() {
    Get.put(LevelsController(),permanent: true);
    Get.put(LoginController(),permanent: true);
    Get.put(SignupController(),permanent: true);
    Get.put(UserController(),permanent: true);
    Get.put(CardController(),permanent: true);
    Get.put(MainCategoryController(),permanent: true);
  }


}