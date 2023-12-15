import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monteapp/Controllers/CardController.dart';
import 'package:monteapp/Widgets/CustomSnackbar.dart';

import '../../Constants/colors.dart';
import '../../Database/databasehelper.dart';

class BuyPackage extends StatefulWidget {
  final  price;
final String callingScreenName;
  const BuyPackage(this.price,this.callingScreenName, {super.key});

  @override
  State<BuyPackage> createState() => _BuyPackageState();
}

class _BuyPackageState extends State<BuyPackage> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return BuyPackagePortrait(widget.price,widget.callingScreenName);
        } else {
          return BuyPackageLandscape(widget.price,widget.callingScreenName);
        }
      },
    );
  }
}

class BuyPackagePortrait extends StatefulWidget {
  final price;
  final String callingScreenName;
  const BuyPackagePortrait(this.price,this.callingScreenName, {super.key});

  @override
  State<BuyPackagePortrait> createState() => _BuyPackagePortraitState();
}

class _BuyPackagePortraitState extends State<BuyPackagePortrait>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
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
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/loginBgPortrait.jpg"))),
          ),
          Positioned(
              bottom: 50,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value,
                    child: Image.asset(
                      "assets/images/balloons.png",
                      width: 250,
                      height: 250,
                    ), // Replace with your balloon image
                  );
                },
              )),
          Positioned(
              bottom: 10,
              child: Image.asset(
                "assets/images/homeCart.png",
                width: 100,
                height: 100,
              )),
          Positioned(
            top: 55,
            child: Container(
                width: 265,
                height: MediaQuery.of(context).size.height*0.65,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/loginPotraitContainer.png"),
                )),
                child: GetBuilder<CardController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        Container(
                          width: 65,
                          height: 75,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/LoginPortraitMonte.png"))),
                        ).marginOnly(right: 10),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              controller: controller.nameController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Name on card',
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 3.5, top: 2.5, bottom: 2.5),
                              ),
                            ),
                          ),
                        ),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              controller: controller.cardNumberController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Card number',
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 3.5, top: 2.5, bottom: 2.5),
                              ),
                            ),
                          ),
                        ).marginOnly(top: 10),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              readOnly: true,
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2025),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        primaryColor: const Color(0xffD90F4E),
                                        accentColor: const Color(0xffD90F4E),
                                        colorScheme: const ColorScheme.light(
                                            primary: Colors.pink),
                                        buttonTheme: const ButtonThemeData(
                                            textTheme: ButtonTextTheme.primary),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (picked != null) {
                                  final formattedDate =
                                      DateFormat('yyyy-MM').format(picked);
                                  controller.expDateController.text =
                                      formattedDate;
                                }
                              },
                              controller: controller.expDateController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Exp (Month/Year)',
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 3.5, top: 2.5, bottom: 2.5),
                              ),
                            ),
                          ),
                        ).marginOnly(top: 10),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              controller: controller.cvvController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'CVV',
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 3.5, top: 2.5, bottom: 2.5),
                              ),
                            ),
                          ),
                        ).marginOnly(top: 10),
                        Material(
                            elevation: 10,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(60),
                            child: InkWell(
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                                if (controller.nameController.text.isEmpty ||
                                    controller.cardNumberController.text.isEmpty ||
                                    controller.cvvController.text.isEmpty||
                                    controller.expDateController.text.isEmpty) {
                                  CustomSnackbar.show(
                                      "All fields are required", kRed);
                                  return;
                                } else {
                                  if(widget.callingScreenName=="BuyPackage"){
                                    await DatabaseHelper()
                                        .makePayment(widget.price);
                                  }else{
                                    await DatabaseHelper().placeOrder(widget.price);
                                  }
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 160,
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
                                  "Make payment",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            )).marginOnly(top: 20),
                        // Material(
                        //     elevation: 10,
                        //     color: Colors.transparent,
                        //     borderRadius: BorderRadius.circular(60),
                        //     child: InkWell(
                        //       onTap: () async{
                        //         await DatabaseHelper().playTapAudio();
                        //
                        //       },
                        //       child: Container(
                        //         alignment: Alignment.center,
                        //         width: 130,
                        //         height: 30,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(60),
                        //           border: Border.all(color: Colors.yellow),
                        //           gradient: const LinearGradient(
                        //             colors: [
                        //               Color(0xff104e99),
                        //               Color(0xff8dabc9)
                        //             ],
                        //             begin: Alignment.bottomCenter,
                        //             end: Alignment.topCenter,
                        //           ),
                        //         ),
                        //         child: const Text(
                        //           "Create new account",
                        //           style: TextStyle(
                        //               color: Colors.white, fontSize: 12),
                        //         ),
                        //       ),
                        //     )).marginOnly(top: 10),
                      ],
                    ).marginSymmetric(horizontal: 30).marginOnly(top: 40);
                  },
                )),
          ),
        ],
      ),
    );
  }
}

class BuyPackageLandscape extends StatefulWidget {
  final price;
  final String callingScreenName;
  const BuyPackageLandscape(this.price, this.callingScreenName,{super.key});

  @override
  State<BuyPackageLandscape> createState() => _BuyPackageLandscapeState();
}

class _BuyPackageLandscapeState extends State<BuyPackageLandscape>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
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
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/loginBgLandscape.jpg"))),
          ),
          Positioned(
            right: 0,
            child: SizedBox(
              width: 250,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      top: 20,
                      right: -30,
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _animation.value,
                            child: Image.asset(
                              "assets/images/balloons.png",
                              width: 200,
                              height: 200,
                            ), // Replace with your balloon image
                          );
                        },
                      )),
                  Positioned(
                      right: 20,
                      bottom: 15,
                      child: Image.asset(
                        "assets/images/homeCart.png",
                        width: 100,
                        height: 100,
                      )),
                ],
              ),
            ),
          ),
          Container(
            width: 500,
            height: 280,
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/signupLandscapeContainer.png"),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 65,
                  height: 75,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/LoginPortraitMonte.png"))),
                ).marginOnly(right: 10),
                GetBuilder<CardController>(
                  builder: (controller) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              controller: controller.nameController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Name on card',
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 3.5, top: 2.5, bottom: 2.5),
                              ),
                            ),
                          ),
                        ),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              controller: controller.cardNumberController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Card number',
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 3.5, top: 2.5, bottom: 2.5),
                              ),
                            ),
                          ),
                        ).marginOnly(top: 10),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              readOnly: true,
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2025),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        primaryColor: const Color(0xffD90F4E),
                                        accentColor: const Color(0xffD90F4E),
                                        colorScheme: const ColorScheme.light(
                                            primary: Colors.pink),
                                        buttonTheme: const ButtonThemeData(
                                            textTheme: ButtonTextTheme.primary),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (picked != null) {
                                  final formattedDate =
                                      DateFormat('yyyy-MM').format(picked);
                                  controller.expDateController.text =
                                      formattedDate;
                                }
                              },
                              controller: controller.expDateController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Exp (Month/Year)',
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 3.5, top: 2.5, bottom: 2.5),
                              ),
                            ),
                          ),
                        ).marginOnly(top: 10),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              controller: controller.cvvController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'CVV',
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 3.5, top: 2.5, bottom: 2.5),
                              ),
                            ),
                          ),
                        ).marginOnly(top: 10),
                      ],
                    );
                  },
                ),
                GetBuilder<CardController>(
                  builder: (controller) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                            elevation: 10,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(60),
                            child: InkWell(
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                                if (controller.nameController.text.isEmpty ||
                                    controller.cardNumberController.text.isEmpty ||
                                    controller.cvvController.text.isEmpty||
                                    controller.expDateController.text.isEmpty) {
                                  CustomSnackbar.show(
                                      "All fields are required", kRed);
                                  return;
                                } else {
                                  await DatabaseHelper()
                                      .makePayment(widget.price);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 150,
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
                                  "Make payment",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            )).marginOnly(top: 20),
                      ],
                    );
                  },
                )
              ],
            ),
          ).marginOnly(left: 35)
        ],
      ),
    );
  }
}
