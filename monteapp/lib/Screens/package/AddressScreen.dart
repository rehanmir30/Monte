import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:monteapp/Constants/colors.dart';
import 'package:monteapp/Controllers/AddressController.dart';
import 'package:monteapp/Widgets/BackButton.dart';
import 'package:monteapp/Widgets/CustomSnackbar.dart';

import '../../Database/databasehelper.dart';
import 'BuyPackage.dart';

class AddressScreen extends StatefulWidget {
  final price;
  final String callingScreenName;

  const AddressScreen(this.price, this.callingScreenName, {super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return AddressPortrait(widget.price, widget.callingScreenName);
        } else {
          return AddressLandscape(widget.price, widget.callingScreenName);
        }
      },
    );
  }
}

class AddressPortrait extends StatefulWidget {
  final price;
  final String callingScreenName;

  const AddressPortrait(this.price, this.callingScreenName, {super.key});

  @override
  State<AddressPortrait> createState() => _AddressPortraitState();
}

class _AddressPortraitState extends State<AddressPortrait>
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
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/loginBgPortrait.jpg"))),
          ),
          Positioned(
              bottom: 70,
              right: -50,
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
              bottom: 10,
              right: 0,
              child: Image.asset(
                "assets/images/homeCart.png",
                width: 100,
                height: 100,
              )),
          Positioned(
            top: 35,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/SignupPortraitContainer.png"),
              )),
              child: GetBuilder<AddressController>(
                builder: (controller) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 185,
                        height: 140,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/otpballoons.png"))),
                      ),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            controller: controller.homeAddress,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            onTap: () async {
                              await DatabaseHelper().playTapAudio();
                            },
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "Address",
                              filled: true,
                              hintStyle: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              fillColor: const Color(0xffD90F4E),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60),
                                borderSide: const BorderSide(
                                    color: Colors.yellow,
                                    width:
                                        2.0), // Change the color and width here
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.yellow, width: 2.0),
                                //<-- SEE HERE
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.yellow, width: 2.0),
                                //<-- SEE HERE
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
                            controller: controller.city,
                            textAlign: TextAlign.center,
                            onTap: () async {
                              await DatabaseHelper().playTapAudio();
                            },
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'City',
                              filled: true,
                              hintStyle: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              fillColor: const Color(0xffD90F4E),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60),
                                borderSide: const BorderSide(
                                    color: Colors.yellow,
                                    width:
                                        2.0), // Change the color and width here
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.yellow, width: 2.0),
                                //<-- SEE HERE
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.yellow, width: 2.0),
                                //<-- SEE HERE
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              contentPadding: const EdgeInsets.only(
                                  left: 3.5, top: 2.5, bottom: 2.5),
                            ),
                          ),
                        ),
                      ).marginOnly(top: 10),
                      Material(
                        borderRadius: BorderRadius.circular(60),
                        elevation: 10,
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            controller: controller.state,
                            keyboardType: TextInputType.text,
                            onTap: () async {
                              await DatabaseHelper().playTapAudio();
                            },
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'State',
                              filled: true,
                              hintStyle: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              fillColor: const Color(0xffD90F4E),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60),
                                borderSide: const BorderSide(
                                    color: Colors.yellow,
                                    width:
                                        2.0), // Change the color and width here
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.yellow, width: 2.0),
                                //<-- SEE HERE
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.yellow, width: 2.0),
                                //<-- SEE HERE
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              contentPadding: const EdgeInsets.only(
                                  left: 3.5, top: 2.5, bottom: 2.5),
                            ),
                          ),
                        ),
                      ).marginOnly(top: 10),
                      Material(
                        borderRadius: BorderRadius.circular(60),
                        elevation: 10,
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            controller: controller.country,
                            onTap: () async {
                              await DatabaseHelper().playTapAudio();
                            },
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Country',
                              filled: true,
                              hintStyle: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              fillColor: const Color(0xffD90F4E),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60),
                                borderSide: const BorderSide(
                                    color: Colors.yellow,
                                    width:
                                        2.0), // Change the color and width here
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.yellow, width: 2.0),
                                //<-- SEE HERE
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.yellow, width: 2.0),
                                //<-- SEE HERE
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              contentPadding: const EdgeInsets.only(
                                  left: 3.5, top: 2.5, bottom: 2.5),
                            ),
                          ),
                        ),
                      ).marginOnly(top: 10),
                      Material(
                        borderRadius: BorderRadius.circular(60),
                        elevation: 10,
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            textAlign: TextAlign.center,
                            onTap: () async {
                              await DatabaseHelper().playTapAudio();
                            },
                            keyboardType: TextInputType.number,
                            controller: controller.postalCode,
                            decoration: InputDecoration(
                              hintText: "Postal Code",
                              filled: true,
                              hintStyle: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              fillColor: const Color(0xffD90F4E),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60),
                                borderSide: const BorderSide(
                                    color: Colors.yellow,
                                    width:
                                        2.0), // Change the color and width here
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.yellow, width: 2.0),
                                //<-- SEE HERE
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.yellow, width: 2.0),
                                //<-- SEE HERE
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
                              if (controller.homeAddress.text.isEmpty ||
                                  controller.city.text.isEmpty ||
                                  controller.state.text.isEmpty ||
                                  controller.country.text.isEmpty ||
                                  controller.postalCode.text.isEmpty) {
                                CustomSnackbar.show("All fields are required", kRed);
                                return;
                              }else{
                                await DatabaseHelper().makeStripePayment(widget.price,widget.callingScreenName);
                                // Get.to(BuyPackage(widget.price, "BuyPackage"),
                                //     transition: Transition.upToDown);
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
                                  // Define your gradient colors
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: const Text(
                                "Make Payment",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )).marginOnly(top: 20),
                      SizedBox(
                        height: 120,
                      )
                    ],
                  ).marginSymmetric(horizontal: 30).marginOnly(top: 40);
                },
              ),
            ),
          ),
          Back(),
        ],
      ),
    );
  }
}

class AddressLandscape extends StatefulWidget {
  final price;
  final String callingScreenName;

  const AddressLandscape(this.price, this.callingScreenName, {super.key});

  @override
  State<AddressLandscape> createState() => _AddressLandscapeState();
}

class _AddressLandscapeState extends State<AddressLandscape> with SingleTickerProviderStateMixin{

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
            width: MediaQuery.of(context).size.width*0.75,
            height: MediaQuery.of(context).size.height*0.85,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/signupLandscapeContainer.png"),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GetBuilder<AddressController>(
                  builder: (controller) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
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
                                  controller: controller.homeAddress,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.text,
                                  onTap: () async {
                                    await DatabaseHelper().playTapAudio();
                                  },
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  decoration: InputDecoration(
                                    hintText: "Address",
                                    filled: true,
                                    hintStyle: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    fillColor: const Color(0xffD90F4E),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide: const BorderSide(
                                          color: Colors.yellow,
                                          width:
                                          2.0), // Change the color and width here
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.yellow, width: 2.0),
                                      //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.yellow, width: 2.0),
                                      //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 3.5, top: 2.5, bottom: 2.5),
                                  ),
                                ),
                              ),
                            ).marginOnly(top: 10),
                            SizedBox(
                              width: 10,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(60),
                              elevation: 10,
                              color: Colors.transparent,
                              child: SizedBox(
                                width: 150,
                                height: 40,
                                child: TextFormField(
                                  controller: controller.city,
                                  onTap: () async {
                                    await DatabaseHelper().playTapAudio();
                                  },
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: 'City',
                                    filled: true,
                                    hintStyle: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    fillColor: const Color(0xffD90F4E),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide: const BorderSide(
                                          color: Colors.yellow,
                                          width:
                                          2.0), // Change the color and width here
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.yellow, width: 2.0),
                                      //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.yellow, width: 2.0),
                                      //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 3.5, top: 2.5, bottom: 2.5),
                                  ),
                                ),
                              ),
                            ).marginOnly(top: 10),
                          ],
                        ),
                        Row(
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
                                  controller: controller.state,
                                  textAlign: TextAlign.center,
                                  onTap: () async {
                                    await DatabaseHelper().playTapAudio();
                                  },
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  decoration: InputDecoration(
                                    hintText: 'State',
                                    filled: true,
                                    hintStyle: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    fillColor: const Color(0xffD90F4E),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide: const BorderSide(
                                          color: Colors.yellow,
                                          width:
                                          2.0), // Change the color and width here
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.yellow, width: 2.0),
                                      //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.yellow, width: 2.0),
                                      //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 3.5, top: 2.5, bottom: 2.5),
                                  ),
                                ),
                              ),
                            ).marginOnly(top: 10),
                            SizedBox(
                              width: 10,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(60),
                              elevation: 10,
                              color: Colors.transparent,
                              child: SizedBox(
                                width: 150,
                                height: 40,
                                child: TextFormField(
                                  controller: controller.country,
                                  onTap: () async {
                                    await DatabaseHelper().playTapAudio();
                                  },
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: 'Country',
                                    filled: true,
                                    hintStyle: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    fillColor: const Color(0xffD90F4E),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide: const BorderSide(
                                          color: Colors.yellow,
                                          width:
                                          2.0), // Change the color and width here
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.yellow, width: 2.0),
                                      //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.yellow, width: 2.0),
                                      //<-- SEE HERE
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 3.5, top: 2.5, bottom: 2.5),
                                  ),
                                ),
                              ),
                            ).marginOnly(top: 10),
                          ],
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(60),
                          elevation: 10,
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              keyboardType: TextInputType.number,
                              controller: controller.postalCode,
                              decoration: InputDecoration(
                                hintText: "Postal Code",
                                filled: true,
                                hintStyle: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow,
                                      width:
                                      2.0), // Change the color and width here
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.yellow, width: 2.0),
                                  //<-- SEE HERE
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
                                if (controller.homeAddress.text.isEmpty ||
                                    controller.city.text.isEmpty ||
                                    controller.state.text.isEmpty ||
                                    controller.country.text.isEmpty ||
                                    controller.postalCode.text.isEmpty) {
                                  CustomSnackbar.show("All fields are required", kRed);
                                  return;
                                }else{
                                  await DatabaseHelper().makeStripePayment(widget.price,widget.callingScreenName);
                                  // Get.to(BuyPackage(widget.price, "BuyPackage"),
                                  //     transition: Transition.upToDown);
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
                                    // Define your gradient colors
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                child: const Text(
                                  "Make Payment",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            )).marginOnly(top: 10),
                      ],
                    );
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/lock.png"))),
                    ).marginOnly(top: 10),

                  ],
                )
              ],
            ).marginSymmetric(horizontal: 12),
          ).marginOnly(left: 35)
        ],
      ),
    );
  }
}
