import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:monteapp/Constants/SharedPref/shared_pref_services.dart';
import 'package:monteapp/Constants/colors.dart';
import 'package:monteapp/Controllers/AddressController.dart';
import 'package:monteapp/Controllers/CardController.dart';
import 'package:monteapp/Controllers/CartController.dart';
import 'package:monteapp/Controllers/CountryCodeController.dart';
import 'package:monteapp/Controllers/LoginController.dart';
import 'package:monteapp/Controllers/MainCategoryController.dart';
import 'package:monteapp/Controllers/PackageController.dart';
import 'package:monteapp/Controllers/ShopController.dart';
import 'package:monteapp/Controllers/SignupController.dart';
import 'package:monteapp/Controllers/UserController.dart';
import 'package:monteapp/Models/CartModel.dart';
import 'package:monteapp/Models/CountryCode.dart';
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
import '../Screens/package/PackageScreen.dart';

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
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
      return levelList;
    } else {
      CustomSnackbar.show("Failed to fetch levels", kRed);
      return levelList;
    }
  }

  //sign nup user
  Future<void> signUp() async {
    SignupController signupController = Get.find<SignupController>();
    UserController userController = Get.find<UserController>();
    CountryCodeController countryCodeController=Get.find<CountryCodeController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    Map<String, String> params = {
      'name': signupController.name.text,
      'email': signupController.email.text,
      'phone': "${countryCodeController.selectedCountryCode?.code}${signupController.phone.text}",
      'dob': signupController.age.text,
      'level_id': signupController.selectedLevel?.id.toString() ?? ""
    };
    print("Params: ${params}");
    print("Params: ${signupController.phone.text}");
    print("Params: ${countryCodeController.selectedCountryCode?.code}");
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.register);
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromMap(responseJson['data']);
      LoginController loginController = Get.find<LoginController>();
      loginController.phone != signupController.phone;
      userController.setUser(user);
      Get.to(const OTPScreen(), transition: Transition.circularReveal);
      CustomSnackbar.show(responseJson['message'], kRed);
      return;
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
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
    CountryCodeController countryCodeController=Get.find<CountryCodeController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    Map<String, String> params = {
      'phone': "${countryCodeController.selectedCountryCode?.code}${loginController.phone.text}",
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.login);
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      CustomSnackbar.show(responseJson['message'], kRed);
      Get.to(const OTPScreen(), transition: Transition.circularReveal);
      return;
    } else if (response.statusCode == 401) {
      CustomSnackbar.show(responseJson['message'], kRed);
      return;
    } else {
      CustomSnackbar.show(responseJson['message'], kRed);
      Get.to(SignupScreen(), transition: Transition.zoom);
      return;
    }
  }

  //verify OTP
  Future<void> loginVerifyOTP(context) async {
    UserController userController = Get.find<UserController>();
    LoginController loginController = Get.find<LoginController>();
    CountryCodeController countryCodeController=Get.find<CountryCodeController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    Map<String, String> params = {
      'phone': "${countryCodeController.selectedCountryCode?.code}${loginController.phone.text}",
      'otp': loginController.otp.text
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.verifyOtp);
    var response = await http.post(url, headers: headers, body: params);

    var responseJson = json.decode(response.body);
    print(responseJson);
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
      } else {
        CustomSnackbar.show(responseJson['message'], kRed);
        await getMainCategories();
        Get.offAll(const Home(), transition: Transition.circularReveal);
      }
      return;
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
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
      PackageModel package = PackageModel.fromMap(responseJson);
      print("Bearer: ${package.data?.package?.name}");
      Get.find<PackageController>().setPackageModel(package);
      Get.find<PackageController>().setPrice(true);
      Get.to(PackageScreen(), transition: Transition.downToUp);
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
    } else {
      print("Api error: ${responseJson['message']}");
    }
  }

  //make package payment
  Future<void> makePayment(var price) async {
    UserController userController = Get.find<UserController>();
    CardController cardController = Get.find<CardController>();
    AddressController addressController = Get.find<AddressController>();
    PackageController packageController = Get.find<PackageController>();
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
      "user_id": "${userController.userModel.id}",
      "bundleId": "${packageController.packageModel.data!.bundle!.id}",
      "address": "${addressController.homeAddress}",
      "city": "${addressController.city}",
      "state": "${addressController.state}",
      "country": "${addressController.country}",
      "pincode": "${addressController.postalCode}",
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.makePayment);
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      CustomSnackbar.show(responseJson['message'], kRed);
      await getMainCategories();
      return;
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
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
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
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
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
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
    print("Bearer: ${userController.userModel.accessToken}");
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
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
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
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
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
      "quantity": "1"
    };
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      CartModel cartModel = CartModel.fromMap(responseJson['data']);
      Get.find<CartController>().setCartModel(cartModel);
      CustomSnackbar.show(responseJson['message'], kRed);
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
    } else {
      print("Add to cart error: " + response.body.toString());
    }
  }

  //Get cart
  Future<void> getCart() async {
    UserController userController = Get.find<UserController>();

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };
    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.getCart +
        "userId=${userController.userModel.id}");
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      CartModel cartModel = CartModel.fromMap(responseJson['data']);
      Get.find<CartController>().setCartModel(cartModel);
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
    } else {
      Get.find<CartController>().setCartModel(null);
      print("Error in get cart: " + response.body);
      print(response.statusCode);
    }
  }

  //Remove item from cart
  Future<void> removeProductFromCart(CartItem? cartItem) async {
    UserController userController = Get.find<UserController>();

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };
    Map<String, dynamic> params = {
      "userId": userController.userModel.id.toString(),
      "cartItemId": cartItem?.id.toString()
    };

    var url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.removeProductFromCart);
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      // CartModel cartModel=CartModel.fromMap(responseJson['data']);
      // Get.find<CartController>().setCartModel(cartModel);
      await getCart();
      CustomSnackbar.show(responseJson['message'], kRed);
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
    }
  }

  //Place order
  Future<void> placeOrder(String price) async {
    UserController userController = Get.find<UserController>();
    CardController cardController = Get.find<CardController>();
    AddressController addressController = Get.find<AddressController>();

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
      "userId": "${userController.userModel.id}",
      "address": "${addressController.homeAddress}",
      "city": "${addressController.city}",
      "state": "${addressController.state}",
      "country": "${addressController.country}",
      "pincode": "${addressController.postalCode}",
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.orderPayment);

    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseJson['message'] == 'Payment completed Order Placed.') {
        Get.find<CartController>().setCartModel(null);
        Get.back();
        Get.back();
      }

      CustomSnackbar.show(responseJson['message'], kRed);
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
    } else {
      print("Order place API error: " + response.body);
      CustomSnackbar.show(responseJson['message'], kRed);
    }
  }

  //Get Country Codes
  Future<void>getCountryCodes()async{
    CountryCodeController _countryCodeController=Get.find<CountryCodeController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    var url = Uri.parse(ApiConstants.baseUrl +ApiConstants.getCountryCodes);
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if(response.statusCode==200){
      for(var code in responseJson['data']){
        CountryCode countryCode=CountryCode.fromMap(code);
        _countryCodeController.addCountryCode(countryCode);
        print("countryCodevalue: ${countryCode.code}");
      }
      _countryCodeController.setSelectedCountry(_countryCodeController.countryCodeList[1]);
    }else{
      CustomSnackbar.show("Failed to get country codes", kRed);
    }
  }
}
