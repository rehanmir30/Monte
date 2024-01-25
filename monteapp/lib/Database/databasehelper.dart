import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_stripe/flutter_stripe.dart';
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
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
  Future<void> signUp(context) async {
    SignupController signupController = Get.find<SignupController>();
    UserController userController = Get.find<UserController>();
    CountryCodeController countryCodeController =
        Get.find<CountryCodeController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    Map<String, String> params = {
      'name': signupController.name.text,
      'email': signupController.email.text,
      'phone':
          "${countryCodeController.selectedCountryCode?.code}${signupController.phone.text}",
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
      // loginController.phone != signupController.phone;
      loginController.setPhone(signupController.phone);
      userController.setUser(user);
      await login(context);
      // Get.to(const OTPScreen(), transition: Transition.circularReveal);
      // CustomSnackbar.show(responseJson['message'], kRed);
      return;
    } else if (response.statusCode == 401) {
      CustomSnackbar.show("Please login again", kRed);
      SharedPref.removeStudent();
      Get.offAll(LoginScreen(), transition: Transition.circularReveal);
    } else {
      if (kDebugMode) {
        print(
            "Phone: ${countryCodeController.selectedCountryCode?.code}${signupController.phone.text}");
        print(responseJson['message']);
      }
      CustomSnackbar.show("error: ${responseJson['message']}", kRed);
      return;
    }
  }

  //login user
  Future<void> login(context) async {
    LoginController loginController = Get.find<LoginController>();
    UserController userController = Get.find<UserController>();
    CountryCodeController countryCodeController =
        Get.find<CountryCodeController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    Map<String, String> params = {
      'phone':
          "${countryCodeController.selectedCountryCode?.code}${loginController.phone.text}",
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.login);
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      CustomSnackbar.show(responseJson['message'], kRed);
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
      // Get.back();
      // Get.to(const OTPScreen(), transition: Transition.circularReveal);
      return;
    } else if (response.statusCode == 401) {
      CustomSnackbar.show(responseJson['message'], kRed);
      return;
    } else {
      CustomSnackbar.show("${responseJson['message']}", kRed);
      Get.to(SignupScreen(), transition: Transition.zoom);
      return;
    }
  }

  //verify OTP
  Future<void> loginVerifyOTP(context) async {
    UserController userController = Get.find<UserController>();
    LoginController loginController = Get.find<LoginController>();
    CountryCodeController countryCodeController =
        Get.find<CountryCodeController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    Map<String, String> params = {
      'phone':
          "${countryCodeController.selectedCountryCode?.code}${loginController.phone.text}",
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

  //make package payment
  Future<void> makePayment(var price) async {
    UserController userController = Get.find<UserController>();
    AddressController addressController = Get.find<AddressController>();
    PackageController packageController = Get.find<PackageController>();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };
    Map<String, dynamic> params = {

      "amount": price,
      "user_id": "${userController.userModel.id}",
      "bundleId": "${packageController.packageModel.data!.bundle!.id}",
      "address": "${addressController.homeAddress}",
      "city": "${addressController.city}",
      "state": "${addressController.state}",
      "country": "${addressController.country}",
      "pincode": "${addressController.postalCode}",
      "payment_id": "${addressController.paymentId}",
      "receipt_url": "",
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

  //Place order
  Future<void> placeOrder(String price) async {
    UserController userController = Get.find<UserController>();
    // CardController cardController = Get.find<CardController>();
    AddressController addressController = Get.find<AddressController>();

    // List<String> parts = cardController.expDateController.text.split("-");
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${userController.userModel.accessToken}"
    };
    print("heellllll: ${userController.userModel.id}");
    Map<String, dynamic> params = {

      "userId": userController.userModel.id,
      "amount": price,
      "userId": "${userController.userModel.id}",
      "address": "${addressController.homeAddress}",
      "city": "${addressController.city}",
      "state": "${addressController.state}",
      "country": "${addressController.country}",
      "pincode": "${addressController.postalCode}",
      "payment_id": "${addressController.paymentId}",
      "receipt_url": "",
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


String tempPrice='';
String tempScreen='';
  //Razorpay functions
  Future<void> makeStripePayment(String price,String callingScreen) async {
    UserController _userController = Get.find<UserController>();
    late Razorpay _razorpay=Razorpay();
    String integerPart = price.split('.')[0];
tempScreen=callingScreen;
    tempPrice=integerPart;
    var options = {
      'key': 'rzp_test_fgz4kGF4KNakjY',
      'amount': '${integerPart}00',
      'name': 'Monte Kids',
      'prefill': {
        'contact': '${_userController.userModel.phone}',
        'email': '${_userController.userModel.email}'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
      _razorpay.open(options);
    } catch (e) {
      print("Make payment error: " + e.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response)async{
    AddressController _addressController=Get.find<AddressController>();
    print("Razor success: ${response.paymentId}");
    _addressController.setPaymentId(response.paymentId!);
    if(tempScreen=="BuyPackage"){
await makePayment(tempPrice);
    }else{
      await placeOrder(tempPrice);
    }

  }
  void handlePaymentError(PaymentFailureResponse response){
    print("Razor fail: ${response.message}");
  }
  void handleExternalWallet(ExternalWalletResponse response){
    print("Razor External: ${response.walletName}");
  }
  //Strip payment functions start
  // Future<void> makeStripePayment(String price) async {
  //   Stripe.publishableKey =
  //       "pk_live_51O2pdJSIJU0eR5PXPwM4BRkgfLHeOwdAMbsSgOUEOjDHJ9SWAw0zzmH0n0XTXtti0H9PGMdr3az1DuQjep0ylEXL004vew5qd6";
  //   Map<String, dynamic>? paymentIntent;
  //   await confirmPayment(paymentIntent, price);
  // }
  //
  // confirmPayment(paymentIntent, price) async {
  //   try {
  //     paymentIntent = await createPaymentIntent(price);
  //
  //     var gpay = PaymentSheetGooglePay(
  //       merchantCountryCode: "IN",
  //       currencyCode: "INR",
  //       testEnv: false,
  //     );
  //     await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //             paymentIntentClientSecret: paymentIntent!["client_secret"],
  //             merchantDisplayName: "Monte",
  //             googlePay: gpay));
  //     await displayPaymentSheet(price);
  //   } catch (e) {
  //     throw Exception("Confirm Payment: " + e.toString());
  //   }
  // }
  //
  // createPaymentIntent(String price) async {
  //   UserController userController = Get.find<UserController>();
  //
  //   try {
  //     String integerPart = price.split('.')[0];
  //     Map<String, dynamic> body = {
  //       "amount": "${integerPart}00",
  //       "currency": "INR",
  //       "description": "Shop items purchase",
  //     };
  //     Map<String, dynamic> userBody = {
  //       "email": "${userController.userModel.email}",
  //       "name": "${userController.userModel.name}",
  //     };
  //     http.Response createUserResponse = await http.post(
  //         Uri.parse("https://api.stripe.com/v1/customers"),
  //         body: userBody,
  //         headers: {
  //           "Authorization":
  //               "Bearer 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",
  //           "Content-Type": "application/x-www-form-urlencoded"
  //         });
  //     http.Response response = await http.post(
  //         Uri.parse("https://api.stripe.com/v1/payment_intents"),
  //         body: body,
  //         headers: {
  //           "Authorization":
  //               "Bearer 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",
  //           "Content-Type": "application/x-www-form-urlencoded"
  //         });
  //     var responseJson = json.decode(response.body);
  //     Get.find<AddressController>().setPaymentId(responseJson['id']);
  //     return json.decode(response.body);
  //   } catch (e) {
  //     throw Exception("Create payment intent: " + e.toString());
  //   }
  // }
  //
  // //order placing here
  // displayPaymentSheet(price) async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet();
  //     print("Done");
  //     await placeOrder(price);
  //   } catch (e) {
  //     print("Failed");
  //     print("Display Payment Sheet: ${e.toString()}");
  //   }
  // }
  //Strip payment functions end

  //contact us
  sendContactUs(String text, String text2, String text3, String text4) async {
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.postContactUs);

    Map<String, dynamic> params = {
      'name': text,
      "email": text2,
      "phone": text3,
      "message": text4
    };
    var response = await http.post(url, headers: headers, body: params);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200 && responseJson['success'] == true) {
      Get.back();
      CustomSnackbar.show(responseJson['message'], kRed);
    } else {
      CustomSnackbar.show(responseJson['message'], kRed);
    }
  }

  //Get Country Codes
  Future<void> getCountryCodes() async {
    CountryCodeController _countryCodeController =
    Get.find<CountryCodeController>();
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getCountryCodes);
    var response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      for (var code in responseJson['data']) {
        CountryCode countryCode = CountryCode.fromMap(code);
        _countryCodeController.addCountryCode(countryCode);
        print("countryCodevalue: ${countryCode.code}");
      }
      _countryCodeController
          .setSelectedCountry(_countryCodeController.countryCodeList[1]);
    } else {
      CustomSnackbar.show("Failed to get country codes", kRed);
    }
  }
}
