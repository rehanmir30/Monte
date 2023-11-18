import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:monteapp/Constants/SharedPref/shared_pref_services.dart';
import 'package:monteapp/Constants/colors.dart';
import 'package:monteapp/Controllers/CardController.dart';
import 'package:monteapp/Controllers/LoginController.dart';
import 'package:monteapp/Controllers/MainCategoryController.dart';
import 'package:monteapp/Controllers/SignupController.dart';
import 'package:monteapp/Controllers/UserController.dart';
import 'package:monteapp/Models/LevelModel.dart';
import 'package:monteapp/Models/MainCategoryModel.dart';
import 'package:monteapp/Models/PackageModel.dart';
import 'package:monteapp/Models/SubCategoryModel.dart';
import 'package:monteapp/Models/VideoModel.dart';
import 'package:monteapp/Screens/auth/Login/LoginScreen.dart';
import 'package:monteapp/Screens/home/Home.dart';
import 'package:monteapp/Screens/package/BuyPackage.dart';
import 'package:monteapp/Widgets/CustomSnackbar.dart';

import '../Constants/ApiConstants.dart';
import '../Models/UserModel.dart';
import '../Screens/auth/OTP/OTPScreen.dart';

class DatabaseHelper {
  //play tap audio
  playTapAudio() async {
    final player = AudioPlayer();
    await player.play(AssetSource("sounds/tap.mp3"));
  }

  //get all age levels
  Future<List<LevelModel>> getAllLevels() async {
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    List<LevelModel> levelList = [];
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.levelUrl);
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      for (var item in responseJson['data']) {
        LevelModel levelModel = LevelModel.fromMap(item);
        levelList.add(levelModel);
      }
      return levelList;
    } else {
      CustomSnackbar.show("Failed to fetch levels", kRed);
      return levelList;
    }
  }

  //sign nup user
  Future<void> signUp() async {
    // Get.to(const OTPScreen(),transition: Transition.circularReveal);
    SignupController signupController = Get.find<SignupController>();
    UserController userController = Get.find<UserController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    Map<String, String> params = {
      'name': signupController.name.text,
      'email': signupController.email.text,
      'phone': signupController.phone.text,
      'dob': signupController.age.text,
      'level_id': signupController.selectedLevel?.id.toString() ?? ""
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.register);
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromMap(responseJson['data']);
      String token = responseJson['token'];
      user.accessToken = token;
      userController.setUser(user);
      Get.offAll(const LoginScreen());
      // if(user.approved=="0"){
      //   // Get.offAll(const BuyPackage(),transition: Transition.circularReveal);
      // }else{
      //   Get.offAll(const Home(),transition: Transition.circularReveal);
      // }
      CustomSnackbar.show(responseJson['message'], kRed);
      return;
    } else {
      if (kDebugMode) {
        print(responseJson['message']);
      }
      CustomSnackbar.show(responseJson['message'], kRed);
      return;
    }
  }

  //login user
  Future<void> login() async {
    LoginController loginController = Get.find<LoginController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    Map<String, String> params = {
      'phone': loginController.phone.text,
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.login);
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      CustomSnackbar.show(responseJson['message'], kRed);
      Get.to(const OTPScreen(), transition: Transition.circularReveal);
      return;
    } else {
      if (kDebugMode) {
        print(responseJson['message']);
      }
      CustomSnackbar.show(responseJson['message'], kRed);
      return;
    }
  }

  Future<void> loginVerifyOTP(context) async {
    UserController userController = Get.find<UserController>();
    LoginController loginController = Get.find<LoginController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    Map<String, String> params = {
      'phone': loginController.phone.text,
      'otp': loginController.otp.text
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.verifyOtp);
    var response = await http.post(url, headers: headers, body: params);

    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromMap(responseJson['data']);
      String token = responseJson['token'];
      user.accessToken = token;
      userController.setUser(user);
      await SharedPref.saveUser(user);
      if (user.approved == "0") {
        CustomSnackbar.show(responseJson['message'], kRed);
        await getPackage(
            user.detail?.levelId ?? "0", user.accessToken, context);
        // Get.offAll(const BuyPackage(),transition: Transition.circularReveal);
      } else {
        CustomSnackbar.show(responseJson['message'], kRed);
        await getMainCategories();
        Get.offAll(const Home(), transition: Transition.circularReveal);
      }
      return;
    } else {
      if (kDebugMode) {
        print(responseJson['message']);
      }
      CustomSnackbar.show(responseJson['message'], kRed);
      return;
    }
  }

  Future<void> getPackage(id, accessToken, context) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getPackage + id.toString());
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      print(responseJson['data']);
      PackageModel package = PackageModel.fromMap(responseJson['data']);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              // width: MediaQuery.of(context).size.width*0.7,
              // height: 350,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: AssetImage("assets/images/packageContainerPortrait.png"),
              )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/balloons.png",
                    width: 100,
                    height: 100,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/packageNameBg.png"),
                    )),
                    child: Text(
                      package.name ?? "",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ).paddingSymmetric(horizontal: 20, vertical: 12),
                  ),
                  Text(
                    "- ${package.description}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ).marginOnly(top: 12, left: 20, right: 20),
                  Material(
                      elevation: 10,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(60),
                      child: InkWell(
                        onTap: () async {
                          Get.to(BuyPackage(package.price ?? ""),
                              transition: Transition.upToDown);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(color: Colors.yellow),
                            gradient: const LinearGradient(
                              colors: [Color(0xff104e99), Color(0xff8dabc9)],
                              // Define your gradient colors
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: const Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      )).marginOnly(top: 20),
                  TextButton(
                      onPressed: () {
                        // Get.to(const Home(),transition: Transition.upToDown);
                      },
                      child: const Text(
                        "Try free version",
                        style: TextStyle(
                          color: kRed,
                          decoration: TextDecoration.underline,
                        ),
                      ))
                ],
              ).marginSymmetric(vertical: 20),
            ),
          );
        },
      );
    } else {
      print("Api error: ${responseJson['message']}");
    }
  }

  Future<void> makePayment(String price) async {
    UserController _userController = Get.find<UserController>();
    CardController _cardController = Get.find<CardController>();
    List<String> parts = _cardController.expDateController.text.split("-");
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${_userController.userModel.accessToken}"
    };
    Map<String, String> params = {
      'fullName': _cardController.nameController.text,
      "cardNumber": _cardController.cardNumberController.text,
      "month": parts[1],
      "year": parts[0],
      "cvv": _cardController.cvvController.text,
      "price": price,
      "user_id": "${_userController.userModel.id}"
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.makePayment);
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      CustomSnackbar.show(responseJson['message'], kRed);
      await getMainCategories();
      // Get.to(const OTPScreen(),transition: Transition.circularReveal);
      return;
    } else {
      if (kDebugMode) {
        print(responseJson['message']);
      }
      CustomSnackbar.show(responseJson['message'], kRed);
      return;
    }
  }

  Future<void> getMainCategories() async {
    UserController _userController = Get.find<UserController>();
    MainCategoryController _mainCategoryControllert =
        Get.find<MainCategoryController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${_userController.userModel.accessToken}"
    };

    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.mainCategory +
        _userController.userModel.detail!.levelId.toString());
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200 && responseJson['success'] == true) {
      print("success");
      for (var cat in responseJson['data']) {
        MainCategoryModel _model = MainCategoryModel.fromMap(cat);
        _mainCategoryControllert.addItemInMainCategoryList(_model);
      }
      Get.offAll(const Home(), transition: Transition.circularReveal);

      return;
    } else {
      print("Get main Category error: ${responseJson['message']}");
    }
  }

  Future<List<SubCategoryModel>> getSubCategories(
      MainCategoryModel _mainCategoryModel) async {
    List<SubCategoryModel> _subCategoryList = [];
    UserController _userController = Get.find<UserController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${_userController.userModel.accessToken}"
    };

    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.subCategory +
        (_mainCategoryModel.id.toString()));
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      for (var item in responseJson['data']) {
        SubCategoryModel _subCategoryModel = SubCategoryModel.fromMap(item);
        _subCategoryList.add(_subCategoryModel);
      }
      return _subCategoryList;
    } else {
      return _subCategoryList;
    }
  }

  Future<List<VideoModel>> getVideos(SubCategoryModel subCategoryModel)async{
    List<VideoModel> _videoList = [];
    UserController _userController = Get.find<UserController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${_userController.userModel.accessToken}"
    };

    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.getVideos +
        (subCategoryModel.id.toString()));
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      for (var item in responseJson['data']) {
        VideoModel _videoModel = VideoModel.fromMap(item);
        _videoList.add(_videoModel);
      }
      return _videoList;
    }else{
      return _videoList;
    }

  }

}
