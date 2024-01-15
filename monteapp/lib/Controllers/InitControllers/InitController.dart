import 'package:get/get.dart';
import 'package:monteapp/Controllers/AddressController.dart';
import 'package:monteapp/Controllers/CardController.dart';
import 'package:monteapp/Controllers/CartController.dart';
import 'package:monteapp/Controllers/ContactUsController.dart';
import 'package:monteapp/Controllers/CountryCodeController.dart';
import 'package:monteapp/Controllers/LevelsController.dart';
import 'package:monteapp/Controllers/LoadingController.dart';
import 'package:monteapp/Controllers/LoginController.dart';
import 'package:monteapp/Controllers/MainCategoryController.dart';
import 'package:monteapp/Controllers/ShopController.dart';
import 'package:monteapp/Controllers/SignupController.dart';
import 'package:monteapp/Controllers/UserController.dart';

import '../PackageController.dart';

class InitController with Bindings{
  @override
  void dependencies() {
    Get.put(LevelsController(),permanent: true);
    Get.put(LoginController(),permanent: true);
    Get.put(SignupController(),permanent: true);
    Get.put(UserController(),permanent: true);
    Get.put(CardController(),permanent: true);
    Get.put(MainCategoryController(),permanent: true);
    Get.put(ShopController(),permanent: true);
    Get.put(CartController(),permanent: true);
    Get.put(PackageController(),permanent: true);
    Get.put(AddressController(),permanent: true);
    Get.put(CountryCodeController(),permanent: true);
    Get.put(ContactUsController(),permanent: true);
    Get.put(LoadingController(),permanent: true);
  }


}