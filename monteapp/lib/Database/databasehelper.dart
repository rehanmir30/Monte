import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:monteapp/Constants/SharedPref/shared_pref_services.dart';
import 'package:monteapp/Constants/colors.dart';
import 'package:monteapp/Controllers/CardController.dart';
import 'package:monteapp/Controllers/CartController.dart';
import 'package:monteapp/Controllers/LoginController.dart';
import 'package:monteapp/Controllers/MainCategoryController.dart';
import 'package:monteapp/Controllers/ShopController.dart';
import 'package:monteapp/Controllers/SignupController.dart';
import 'package:monteapp/Controllers/UserController.dart';
import 'package:monteapp/Models/CartModel.dart';
import 'package:monteapp/Models/LevelModel.dart';
import 'package:monteapp/Models/MainCategoryModel.dart';
import 'package:monteapp/Models/PackageModel.dart';
import 'package:monteapp/Models/ShopModel.dart';
import 'package:monteapp/Models/ShopProduct.dart';
import 'package:monteapp/Models/SubCategoryModel.dart';
import 'package:monteapp/Models/VideoModel.dart';
import 'package:monteapp/Screens/auth/Login/LoginScreen.dart';
import 'package:monteapp/Screens/auth/Signup/SignUpScreen.dart';
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
      // String token = responseJson['token'];
      // user.accessToken = token;
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
      CustomSnackbar.show(responseJson['message'], kRed);
      Get.to(SignupScreen(),transition: Transition.zoom);

      return;
    }
  }

  //verify OTP
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

  //get package
  Future<void> getPackage(id, accessToken, context) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    var url = Uri.parse(
        ApiConstants.baseUrl + ApiConstants.getPackage + id.toString());
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      print("Bearer: ${accessToken}");
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
                          Get.to(BuyPackage(package.price ?? 0, "BuyPackage"),
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

  //make package payment
  Future<void> makePayment(var price) async {
    UserController userController = Get.find<UserController>();
    CardController cardController = Get.find<CardController>();
    List<String> parts = cardController.expDateController.text.split("-");
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };
    Map<String, dynamic> params = {
      'fullName': cardController.nameController.text,
      "cardNumber": cardController.cardNumberController.text,
      "month": parts[1],
      "year": parts[0],
      "cvv": cardController.cvvController.text,
      "price": price,
      "user_id": "${userController.userModel.id}"
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

  //get main categories
  Future<void> getMainCategories() async {
    UserController userController = Get.find<UserController>();
    MainCategoryController mainCategoryController =
        Get.find<MainCategoryController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };

    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.mainCategory +
        userController.userModel.detail!.levelId.toString());
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200 && responseJson['success'] == true) {
      mainCategoryController.clearCategoryList();
      for (var cat in responseJson['data']) {
        MainCategoryModel model = MainCategoryModel.fromMap(cat);
        mainCategoryController.addItemInMainCategoryList(model);
      }
      Get.offAll(const Home(), transition: Transition.circularReveal);

      return;
    } else {
      print("Get main Category error: ${responseJson['message']}");
    }
  }

  //get sub categories of main category
  Future<List<SubCategoryModel>> getSubCategories(
      MainCategoryModel mainCategoryModel) async {
    List<SubCategoryModel> subCategoryList = [];
    UserController userController = Get.find<UserController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };

    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.subCategory +
        (mainCategoryModel.id.toString()));
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      for (var item in responseJson['data']) {
        SubCategoryModel subCategoryModel = SubCategoryModel.fromMap(item);
        subCategoryList.add(subCategoryModel);
      }
      return subCategoryList;
    } else {
      return subCategoryList;
    }
  }

  //get videos of sub categories
  Future<List<VideoModel>> getVideos(SubCategoryModel subCategoryModel) async {
    List<VideoModel> videoList = [];
    UserController userController = Get.find<UserController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };

    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.getVideos +
        (subCategoryModel.id.toString()));
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      for (var item in responseJson['data']) {
        VideoModel videoModel = VideoModel.fromMap(item);
        videoList.add(videoModel);
      }
      return videoList;
    } else {
      return videoList;
    }
  }

  //get shop products (toys/material)
  Future<void> getShopProducts(String type) async {
    UserController userController = Get.find<UserController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };
    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.getShopProduct +
        "level_id=${userController.userModel.detail?.levelId}" +
        "&name=${type}");
    print("Bearer: ${userController.userModel.accessToken}");
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      ShopModel shopModel = ShopModel.fromMap(responseJson);
      shopModel.products = [];
      for (var item in responseJson['data']['products']) {
        ShopProduct shopProduct = ShopProduct.fromMap(item);
        shopModel.products!.add(shopProduct);
      }
      if (type == 'material') {
        Get.find<ShopController>().setMaterialShopModel(shopModel);
      } else {
        Get.find<ShopController>().setToyShopModel(shopModel);
      }
    } else {
      if (kDebugMode) {
        print("Shop API Error: ${response.body}");
      }
    }
  }

  //Add product to cart
  Future<void> addProductToCart(ShopProduct shopProduct) async {
    UserController userController = Get.find<UserController>();

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };
    print("Bearer: ${userController.userModel.accessToken}");
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.addProductToCart);

    Map<String, dynamic> params = {
      'productId': shopProduct.id.toString(),
      "userId": userController.userModel.id.toString(),
      "price": shopProduct.price.toString(),
      "quantity":"1"
    };
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      CartModel cartModel=CartModel.fromMap(responseJson['data']);
      Get.find<CartController>().setCartModel(cartModel);
      CustomSnackbar.show(responseJson['message'], kRed);
    } else {
      print("Add to cart error: " + response.body.toString());
    }
  }

  //Get cart
  Future<void>getCart()async{
    UserController userController = Get.find<UserController>();

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getCart+"userId=${userController.userModel.id}");
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);

    if(response.statusCode==200){
      CartModel cartModel=CartModel.fromMap(responseJson['data']);
      Get.find<CartController>().setCartModel(cartModel);
    }else{
      Get.find<CartController>().setCartModel(null);
      print("Error in get cart: "+response.body);
    }
  }

  //Remove item from cart
  Future<void>removeProductFromCart(CartItem? cartItem)async{
    UserController userController = Get.find<UserController>();

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };
    Map<String, dynamic> params = {
      "userId": userController.userModel.id.toString(),
      "cartItemId": cartItem?.id.toString()
    };

    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.removeProductFromCart);
    var response = await http.post(url, headers: headers,body: params);
    var responseJson = json.decode(response.body);
    if(response.statusCode==200){
      // CartModel cartModel=CartModel.fromMap(responseJson['data']);
      // Get.find<CartController>().setCartModel(cartModel);
      await getCart();
      CustomSnackbar.show(responseJson['message'], kRed);
    }
  }

  //Place order
  Future<void> placeOrder(String price)async{
    UserController userController = Get.find<UserController>();
    CardController cardController = Get.find<CardController>();

    List<String> parts = cardController.expDateController.text.split("-");
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };
    Map<String, dynamic> params = {
      'fullName': cardController.nameController.text,
      "cardNumber": cardController.cardNumberController.text,
      "month": parts[1],
      "year": parts[0],
      "cvv": cardController.cvvController.text,
      "price": price,
      "userId": "${userController.userModel.id}"
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.orderPayment);

    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      if(responseJson['message']=='Payment completed Order Placed.'){
        Get.find<CartController>().setCartModel(null);
        Get.back();
        Get.back();
      }


      CustomSnackbar.show(responseJson['message'], kRed);
    }else{
      print("Order place API error: "+response.body);
      CustomSnackbar.show(responseJson['message'], kRed);
    }
  }
}
