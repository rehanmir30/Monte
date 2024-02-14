import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Constants/SharedPref/shared_pref_services.dart';
import 'package:monteapp/Controllers/CartController.dart';
import 'package:monteapp/Controllers/LoadingController.dart';
import 'package:monteapp/Controllers/MainCategoryController.dart';
import 'package:monteapp/Controllers/UserController.dart';
import 'package:monteapp/Database/databasehelper.dart';
import 'package:monteapp/Models/MainCategoryModel.dart';
import 'package:monteapp/Models/SubCategoryModel.dart';
import 'package:monteapp/Screens/auth/Login/LoginScreen.dart';
import 'package:monteapp/Screens/info/ContactUs.dart';
import 'package:monteapp/Screens/shop/CartScreen.dart';
import 'package:monteapp/Screens/shop/ShopScreen.dart';
import 'package:monteapp/Widgets/CustomSnackbar.dart';

import '../../Constants/colors.dart';
import '../../Widgets/LoadingAnimation.dart';
import '../../main.dart';
import '../Category/CategoryDetailScreen.dart';
import '../info/AboutMonte.dart';
import '../info/termsOfUse.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver{
  Timer? _timer;
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const HomePortrait();
        } else {
          return const HomeLandscape();
        }
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    if(userController.userModel.approved=="0"){
      _startPopupTimer();
    }
    getCart();
  }

  @override
  void dispose() {
    super.dispose();
    _stopPopupTimer();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startPopupTimer();
    } else if (state == AppLifecycleState.paused) {
      _stopPopupTimer();
    }
  }
  void _startPopupTimer() async{
    int time=await DatabaseHelper().getTrialPeriodTime();
    print("Timer started");
    _timer?.cancel();
    _timer = Timer(Duration(minutes: time), () {
      _showPopup();
    });
  }
  void _stopPopupTimer() {
    print("Timer stoped");
    _timer?.cancel();
  }
  void _showPopup() {
    if (navigatorKey.currentState?.overlay?.context != null) {
      showDialog(
        context: navigatorKey.currentState!.overlay!.context,
        barrierDismissible: false, // Prevents closing the dialog by tapping outside of it
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40), // Curved borders
              side: BorderSide(color: Colors.yellow, width: 3), // Border color and width
            ),
            child: Container(
              decoration: BoxDecoration(
                color: kPink,
                borderRadius: BorderRadius.circular(40)
              ),
              padding: EdgeInsets.all(26.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the dialog compact
                children: <Widget>[
                  const Text(
                    'Trial version',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'It seems like your trial version time has ended. Please restart the app to get trial time again',style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                  ),
                  const SizedBox(height: 24.0),
                  Material(
                      elevation: 10,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(60),
                      child: InkWell(
                        onTap: () async{
                          await DatabaseHelper().playTapAudio();
                          await SharedPref.removeStudent();
                          Get.offAll(const LoginScreen(),transition: Transition.zoom);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(color: Colors.yellow),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff104e99),
                                Color(0xff8dabc9)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      )).marginOnly(top: 20),
                  // ElevatedButton(
                  //   child: Text('Close'),
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                ],
              ),
            ),
          );
        },
      );

    }
  }
  getCart() async {
    await DatabaseHelper().getCart();
  }
}

class HomePortrait extends StatefulWidget {
  const HomePortrait({super.key});

  @override
  State<HomePortrait> createState() => _HomePortraitState();
}

class _HomePortraitState extends State<HomePortrait>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  List<String> menuOptions = ['Contact us', 'About Monte', 'Terms of use'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      ..repeat(reverse: true);


    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
    _animation2 = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/homeBgPortrait.png"))),
          ),
          Positioned(
            right: 10,
            top: 0,
            child: Container(
              width: 100,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: menuOptions.length,
                primary: false,
                itemBuilder: (context, index) {
                  return MenuItem(menuOptions[index]);
                },
              ),
            ),
          ),
          Positioned(
              top: 55,
              // bottom: 50,
              left: 25,
              child: GetBuilder<MainCategoryController>(
                builder: (controller) {
                  return Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.6,
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // Adjust the number of columns as needed
                          childAspectRatio: 0.8),
                      itemCount:
                      controller.mainCategoryList.length,
                      // The number of balloons you want to display
                      itemBuilder: (context, index) {
                        // Generate a random index to select a balloon image and name
                        int randomIndex = Random()
                            .nextInt(controller.mainCategoryList.length);

                        // Get the asset path for the random balloon image

                        String balloonImage =
                            'assets/images/baloon${index + 1}.png';

                        return BalloonTile(
                          imagePath: balloonImage,
                          index: index,
                          mainCategoryModel: controller.mainCategoryList[index],
                        );
                      },
                    ),
                  );
                },
              )
          ),
          Positioned(
              left: 65,
              bottom: 20,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _animation.value),
                    child: InkWell(
                      onTap: () {
                        Get.to(const ShopScreen(),
                            transition: Transition.downToUp);
                      },
                      child: Image.asset(
                        "assets/images/shopImg.png",
                        // "assets/images/homeCart.png",
                        width: 185,
                        height: 180,
                      ),
                    ),
                  );
                },

              )),
          Positioned(
              right: 10,
              child: AnimatedBuilder(
                  animation: _animation2,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation2.value),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                              const CartScreen(), transition: Transition.zoom);
                        },
                        child: Container(
                            width: 100,
                            height: 100,
                            child: Stack(
                              children: [
                                Image.asset("assets/images/cartIcon.png"),
                                Positioned(
                                  right: 20,
                                  top: 10,
                                  child: GetBuilder<CartController>(
                                    builder: (controller2) {
                                      return Visibility(
                                        visible: controller2.cartModel == null
                                            ? false
                                            : true,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: kRed,
                                              shape: BoxShape.circle
                                          ),
                                        ),
                                      );
                                    },)
                                  ,
                                )
                              ],
                            )),
                      ),
                    );
                  }
              )

          ),
          LoadingAnimation()
        ],
      ),
    );
  }
}

class BalloonTile extends StatefulWidget {
  final String imagePath;
  final int index;
  final MainCategoryModel mainCategoryModel;

  BalloonTile({required this.imagePath,required this.index ,required this.mainCategoryModel});

  @override
  State<BalloonTile> createState() => _BalloonTileState();
}

class _BalloonTileState extends State<BalloonTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  UserController _userController=Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if(_userController.userModel.approved=="0"){
          if(widget.index==0){
            Get.find<LoadingController>().setLoading(true);
            List<SubCategoryModel> subCategoryList =
            await DatabaseHelper().getSubCategories(widget.mainCategoryModel);
            if (subCategoryList.isNotEmpty) {
              Get.to(CategoryDetailScreen(subCategoryList),
                  transition: Transition.circularReveal);
              Get.find<LoadingController>().setLoading(false);

            } else {
              Get.find<LoadingController>().setLoading(false);
              CustomSnackbar.show("No data found", kRed);
            }
          }else{
            showDialog(
              context: context,
              barrierDismissible: false, // Prevents closing the dialog by tapping outside of it
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40), // Curved borders
                    side: BorderSide(color: Colors.yellow, width: 3), // Border color and width
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: kPink,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    padding: EdgeInsets.all(26.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // To make the dialog compact
                      children: <Widget>[
                        const Text(
                          'Trial version',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'It seems like you are using trial version. Please buy subscription for ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              TextSpan(
                                text: 'Rs.840 ',
                                style: TextStyle(
                                    color: kRed,
                                    fontSize: 20,
                                fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'only for an year to get access to full content.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        //  Text(
                        //   'It seems like you are using trial version. Please buy subscription for Rs.840 only for an year to get access to full content',style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 20,
                        //   fontWeight: FontWeight.bold
                        // ),
                        // ),
                        const SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Material(
                                elevation: 10,
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(60),
                                child: InkWell(
                                  onTap: () async{
                                    await DatabaseHelper().playTapAudio();
                                    Get.back();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(color: Colors.yellow),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xffef097a),
                                          Color(0xffad66b6)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                )).marginOnly(top: 20),
                            Material(
                                elevation: 10,
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(60),
                                child: InkWell(
                                  onTap: () async{
                                    await DatabaseHelper().playTapAudio();
                                    await SharedPref.removeStudent();
                                    Get.offAll(const LoginScreen(),transition: Transition.zoom);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(color: Colors.yellow),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xff104e99),
                                          Color(0xff8dabc9)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    child: const Text(
                                      "Buy now!",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                )).marginOnly(top: 20),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            );

          }
        }else{
          Get.find<LoadingController>().setLoading(true);
          List<SubCategoryModel> subCategoryList =
          await DatabaseHelper().getSubCategories(widget.mainCategoryModel);
          if (subCategoryList.isNotEmpty) {
            Get.to(CategoryDetailScreen(subCategoryList),
                transition: Transition.circularReveal);
            Get.find<LoadingController>().setLoading(false);

          } else {
            Get.find<LoadingController>().setLoading(false);
            CustomSnackbar.show("No data found", kRed);
          }
        }

      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
              angle: _animation.value,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(widget.imagePath))),
                child: Text(
                  widget.mainCategoryModel.name ?? "",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
          );
        },
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  final String option;

  const MenuItem(this.option, {super.key});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.option=="Contact us"){
          Get.to(ContactUs(),transition: Transition.zoom);
        }else if(widget.option=="About Monte"){
          Get.to(AboutMonte(),transition: Transition.zoom);
        }else{
          Get.to(TermsOfUse(),transition: Transition.zoom);
        }
      },
      child: Container(
        width: 100,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/menuItemBg.png"))),
        child: Text(
          "${widget.option}",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ).marginOnly(top: 15),
      ),
    );
  }
}

class HomeLandscape extends StatefulWidget {

  const HomeLandscape({super.key});

  @override
  State<HomeLandscape> createState() => _HomeLandscapeState();
}

class _HomeLandscapeState extends State<HomeLandscape>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  late Animation<double> _animation2;
  List<String> menuOptions = ['Contact us', 'About Monte', 'Terms of use'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      ..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );
    _animation2 = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/homeBgLandscape.png"))),
          ),
          Positioned(
            top: 0,
            left: 10,
            child: Container(
              width: 100,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: menuOptions.length,
                primary: false,
                itemBuilder: (context, index) {
                  return MenuItem(menuOptions[index]);
                },
              ),
            ),
          ),
          Positioned(
              top: 50,
              // right: 50,
              child: GetBuilder<MainCategoryController>(builder: (controller) {
                return Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.7,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7,
                  // color: Colors.transparent,
                  child: Stack(
                    children: List.generate(
                        controller.mainCategoryList.length, (index) {
                      return FanShape(index, controller
                          .mainCategoryList[index]);
                    }),
                  ),
                );
              },)),
          Positioned(
            // right: 260,
              bottom: 0,
              child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation.value),
                      child: InkWell(
                        onTap: () {
                          Get.to(const ShopScreen(),
                              transition: Transition.downToUp);
                        },
                        child: Image.asset(
                          "assets/images/shopImg.png",
                          width: 150,
                          height: 150,
                        ),
                      ),
                    );
                  })),
          Positioned(
              right: 10,
              child: AnimatedBuilder(
                  animation: _animation2,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation2.value),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                              const CartScreen(), transition: Transition.zoom);
                        },
                        child: Container(
                            width: 100,
                            height: 100,
                            child: Stack(
                              children: [
                                Image.asset("assets/images/cartIcon.png"),
                                Positioned(
                                  right: 20,
                                  top: 10,
                                  child: GetBuilder<CartController>(
                                    builder: (controller2) {
                                      return Visibility(
                                        visible: controller2.cartModel == null
                                            ? false
                                            : true,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: kRed,
                                              shape: BoxShape.circle
                                          ),
                                        ),
                                      );
                                    },)
                                  ,
                                )
                              ],
                            )),
                      ),
                    );
                  }
              )

          ),
          LoadingAnimation()
        ],
      ),
    );
  }
}

class FanShape extends StatefulWidget {
  final int index;
  final MainCategoryModel mainCategoryModel;

  const FanShape(this.index, this.mainCategoryModel, {super.key});

  @override
  State<FanShape> createState() => _FanShapeState();
}

class _FanShapeState extends State<FanShape>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  UserController _userController=Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const separation = 80.0;
    final angle = (widget.index - 2.5) * 0.2;
    final balloonImage = 'assets/images/baloon${widget.index + 1}.png';
    return Positioned(
        left: (widget.index + 0.3) * separation,
        child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value,
                child: InkWell(
                  onTap: () async {
                    if(_userController.userModel.approved=="0"){
                      if(widget.index==0){
                        Get.find<LoadingController>().setLoading(true);
                        List<SubCategoryModel> subCategoryList =
                        await DatabaseHelper().getSubCategories(
                            widget.mainCategoryModel);
                        await DatabaseHelper().playTapAudio();
                        if (subCategoryList.isNotEmpty) {
                          Get.find<LoadingController>().setLoading(false);
                          Get.to(CategoryDetailScreen(subCategoryList),
                              transition: Transition.circularReveal);
                        } else {
                          Get.find<LoadingController>().setLoading(false);
                          CustomSnackbar.show("No data found", kRed);
                        }
                      }else{
                        showDialog(
                          context: context,
                          barrierDismissible: false, // Prevents closing the dialog by tapping outside of it
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40), // Curved borders
                                side: BorderSide(color: Colors.yellow, width: 3), // Border color and width
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kPink,
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                padding: EdgeInsets.all(26.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min, // To make the dialog compact
                                  children: <Widget>[
                                    const Text(
                                      'Trial version',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'It seems like you are using trial version. Please buy subscription for ',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                          TextSpan(
                                            text: 'Rs.840 ',
                                            style: TextStyle(
                                                color: kRed,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: 'only for an year to get access to full content.',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // const Text(
                                    //   'It seems like you are using trial version. Please buy subscription for Rs.840 only for an year to get access to full content',style: TextStyle(
                                    //     color: Colors.white,
                                    //     fontSize: 20,
                                    //   fontWeight: FontWeight.bold
                                    // ),
                                    // ),
                                    const SizedBox(height: 24.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Material(
                                            elevation: 10,
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(60),
                                            child: InkWell(
                                              onTap: () async{
                                                await DatabaseHelper().playTapAudio();
                                                Get.back();
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 120,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(60),
                                                  border: Border.all(color: Colors.yellow),
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xffef097a),
                                                      Color(0xffad66b6)
                                                    ],
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 12),
                                                ),
                                              ),
                                            )).marginOnly(top: 20),
                                        Material(
                                            elevation: 10,
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(60),
                                            child: InkWell(
                                              onTap: () async{
                                                await DatabaseHelper().playTapAudio();
                                                await SharedPref.removeStudent();
                                                Get.offAll(const LoginScreen(),transition: Transition.zoom);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 120,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(60),
                                                  border: Border.all(color: Colors.yellow),
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xff104e99),
                                                      Color(0xff8dabc9)
                                                    ],
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Buy now!",
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 12),
                                                ),
                                              ),
                                            )).marginOnly(top: 20),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }else{
                      Get.find<LoadingController>().setLoading(true);
                      List<SubCategoryModel> subCategoryList =
                      await DatabaseHelper().getSubCategories(
                          widget.mainCategoryModel);
                      await DatabaseHelper().playTapAudio();
                      if (subCategoryList.isNotEmpty) {
                        Get.find<LoadingController>().setLoading(false);
                        Get.to(CategoryDetailScreen(subCategoryList),
                            transition: Transition.circularReveal);
                      } else {
                        Get.find<LoadingController>().setLoading(false);
                        CustomSnackbar.show("No data found", kRed);
                      }
                    }
                  },
                  child: Container(
                    width: 100,
                    alignment: Alignment.center,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(balloonImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Text(
                      widget.mainCategoryModel.name ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
        )

    );
  }
}
