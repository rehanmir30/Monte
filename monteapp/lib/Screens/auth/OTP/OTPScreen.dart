import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Controllers/LoginController.dart';
import 'package:monteapp/Widgets/CustomSnackbar.dart';

import '../../../Constants/colors.dart';
import '../../../Database/databasehelper.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const OTPPortrait();
        } else {
          return const OTPLandscape();
        }
      },
    );
  }
}

class OTPPortrait extends StatefulWidget {
  const OTPPortrait({super.key});

  @override
  State<OTPPortrait> createState() => _OTPPortraitState();
}

class _OTPPortraitState extends State<OTPPortrait>
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
                    ),
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
              top: 35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 215,
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/blankContainer.png"),
                        )),
                    child: GetBuilder<LoginController>(
                      builder: (controller) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
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
                                width: 110,
                                height: 25,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: controller.otp,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  decoration: InputDecoration(
                                    hintText: 'Enter OTP',
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
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(60),
                                child: InkWell(
                                  onTap: () async {
                                    await DatabaseHelper().playTapAudio();
                                    if(controller.otp.text.isNotEmpty){
                                      await DatabaseHelper().loginVerifyOTP(context);
                                    }else{
                                      CustomSnackbar.show("OTP field should not be empty", kRed);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 70,
                                    height: 20,
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
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                )).marginOnly(top: 10),
                            Visibility(
                              visible: controller.isButtonDisabled,
                              child: Text(controller.formattedTimer()),
                            ).marginOnly(top: 8),
                            Material(
                                elevation: 10,
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(60),
                                child: InkWell(
                                  onTap: () async {
                                    if(!controller.isButtonDisabled){
                                      await DatabaseHelper().playTapAudio();
                                      await DatabaseHelper().login();
                                      controller.startTimer();
                                    }else{
                                      CustomSnackbar.show("Wait few minutes to get OTP again", kRed);
                                    }


                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    height: 20,
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
                                    child: Text(
                                      "Resend OTP",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                )).marginOnly(top: 10),
                          ],
                        );
                      },
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      child: Image.asset("assets/images/monte.png",width: 100,height: 100,))
                ],
              )),

        ],
      ),
    );
  }
}

class OTPLandscape extends StatefulWidget {
  const OTPLandscape({super.key});

  @override
  State<OTPLandscape> createState() => _OTPLandscapeState();
}

class _OTPLandscapeState extends State<OTPLandscape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/otpBgLandscape.jpg"))),
          ),
          Container(
            width: 555,
            height: 555,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/otpLandscapeContainer.png"),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GetBuilder<LoginController>(
                  builder: (controller) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 120,
                          height: 145,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/otpballoons.png"))),
                        ).marginOnly(right: 10),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 110,
                            height: 25,
                            child: TextFormField(
                              controller: controller.otp,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Enter OTP',
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
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(60),
                            child: InkWell(
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                                if(controller.otp.text.isNotEmpty){
                                  if(controller.timerSeconds!=120){
                                    CustomSnackbar.show("Please wait few seconds to resend OTP", kRed);
                                  }else{
                                    controller.startTimer();
                                    await DatabaseHelper().loginVerifyOTP(context);
                                  }
                                }else{
                                  CustomSnackbar.show("OTP field should not be empty", kRed);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 70,
                                height: 20,
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
                                child: Text(
                                  controller.timerSeconds ==120
                                      ? "Next"
                                      : "Resend",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            )).marginOnly(top: 10),
                        Visibility(
                          visible: controller.isButtonDisabled,
                          child: Text(controller.formattedTimer()),
                        ).marginOnly(top: 8)
                      ],
                    );
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      width: 10,
                      height: 10,
                    )
                  ],
                )
              ],
            ),
          ).marginOnly(left: 35)
        ],
      ),
    );
  }
}
