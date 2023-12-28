import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Constants/colors.dart';
import 'package:monteapp/Controllers/CountryCodeController.dart';
import 'package:monteapp/Controllers/LoginController.dart';
import 'package:monteapp/Database/databasehelper.dart';
import 'package:monteapp/Screens/auth/OTP/OTPScreen.dart';
import 'package:monteapp/Widgets/CustomSnackbar.dart';

import '../../../Models/CountryCode.dart';
import '../Signup/SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const LoginPortrait();
        } else {
          return const LoginLandscape();
        }
      },
    );
  }

  @override
  void initState() {
    getCountryCode();
  }
  getCountryCode()async{
    await DatabaseHelper().getCountryCodes();
  }
}

class LoginPortrait extends StatefulWidget {
  const LoginPortrait({super.key});

  @override
  State<LoginPortrait> createState() => _LoginPortraitState();
}

class _LoginPortraitState extends State<LoginPortrait>with SingleTickerProviderStateMixin {
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
                  child: Image.asset("assets/images/balloons.png",width: 250,height: 250,), // Replace with your balloon image
                );
              },
            )),
        Positioned(
            bottom: 10,
            child: Image.asset("assets/images/homeCart.png",width: 100,height: 100,)),
        Positioned(
          top: 55,
          child: Container(
              width: 265,
              height: 450,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage("assets/images/loginPotraitContainer.png"),
                  )),
              child: GetBuilder<LoginController>(
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
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            color: kRed,
                            borderRadius: BorderRadius.circular(60),
                            border:Border.all(color: kYellow,width: 2)
                          ),
                          child: GetBuilder<CountryCodeController>(builder: (controller2) {
                            return  Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width:50,
                                  child: DropdownButton<CountryCode>(
                                    value: controller2.selectedCountryCode,
                                    dropdownColor: kRed,
                                    onChanged: (CountryCode? newValue) {
                                      controller2.setSelectedCountry(newValue!);
                                    },
                                    items: controller2.countryCodeList.map<DropdownMenuItem<CountryCode>>((CountryCode value) {
                                      return DropdownMenuItem<CountryCode>(
                                        value: value,
                                        child: Text("${value.code}"??"",style: TextStyle(color: Colors.white),),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    onTap: () async {
                                      await DatabaseHelper().playTapAudio();
                                    },
                                    controller: controller.phone,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.phone,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    decoration: InputDecoration(
                                      hintText: 'Phone',
                                      // filled: true,
                                      hintStyle: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                      // fillColor: const Color(0xffD90F4E),
                                      border: OutlineInputBorder(
                                        // borderRadius: BorderRadius.circular(60),
                                        borderSide: const BorderSide(
                                            color: Colors.transparent, width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.transparent, width: 0.0),
                                        // borderRadius: BorderRadius.circular(50.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.transparent, width: 0.0),
                                        // borderRadius: BorderRadius.circular(50.0),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 3.5, top: 2.5, bottom: 2.5),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },),
                        ),
                      ),
                      Material(
                          elevation: 10,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(60),
                          child: InkWell(
                            onTap: () async{
                              await DatabaseHelper().playTapAudio();
                              Get.focusScope?.unfocus();
                              if(controller.phone.text.isEmpty){
                                CustomSnackbar.show("Phone field is required", kRed);
                              }else{
                                if(controller.phone.text.startsWith("0")){
                                  controller.phone.text.replaceFirst("0", '');
                                }
                                await DatabaseHelper().login();
                              }

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
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/lock.png"))),
                      ).marginOnly(top: 10),
                      Material(
                          elevation: 10,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(60),
                          child: InkWell(
                            onTap: () async{
                              await DatabaseHelper().playTapAudio();
                              Get.to(const SignupScreen(),
                                  transition: Transition.zoom);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 130,
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
                                "Create new account",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )).marginOnly(top: 10),
                    ],
                  ).marginSymmetric(horizontal: 30).marginOnly(top: 40);
                },
              )),
        ),

      ],
    ));
  }
}

class LoginLandscape extends StatefulWidget {
  const LoginLandscape({super.key});

  @override
  State<LoginLandscape> createState() => _LoginLandscapeState();
}

class _LoginLandscapeState extends State<LoginLandscape> with SingleTickerProviderStateMixin{
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
                            child: Image.asset("assets/images/balloons.png",width: 200,height: 200,), // Replace with your balloon image
                          );
                        },
                      )),
                  Positioned(
                      right: 20,
                      bottom: 15,
                      child: Image.asset("assets/images/homeCart.png",width: 100,height: 100,)),
                ],
              ),

            ),
          ),
          Container(
            width: 440,
            height: 450,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/loginLandscapeContainer.png"),
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
                          width: 55,
                          height: 65,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/LoginPortraitMonte.png"))),
                        ).marginOnly(right: 10),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                                color: kRed,
                                borderRadius: BorderRadius.circular(60),
                                border:Border.all(color: kYellow,width: 2)
                            ),
                            child: GetBuilder<CountryCodeController>(builder: (controller2) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width:50,
                                    child: DropdownButton<CountryCode>(
                                      value: controller2.selectedCountryCode,
                                      dropdownColor: kRed,
                                      onChanged: (CountryCode? newValue) {
                                       controller2.setSelectedCountry(newValue!);
                                      },
                                      items: controller2.countryCodeList.map<DropdownMenuItem<CountryCode>>((CountryCode value) {
                                        return DropdownMenuItem<CountryCode>(
                                          value: value,
                                          child: Text("${value.code}",style: TextStyle(color: Colors.white),),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      onTap: () async {
                                        await DatabaseHelper().playTapAudio();
                                      },
                                      keyboardType: TextInputType.phone,
                                      textAlign: TextAlign.center,
                                      controller: controller.phone,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                      decoration: InputDecoration(
                                        hintText: 'Phone',
                                        // filled: true,
                                        hintStyle: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                        fillColor: const Color(0xffD90F4E),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(60),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent, width: 0.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent, width: 0.0),
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent, width: 0.0),
                                          borderRadius: BorderRadius.circular(50.0),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: 3.5, top: 2.5, bottom: 2.5),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },),
                          ),
                        ),

                        Material(
                            elevation: 10,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(60),
                            child: InkWell(
                              onTap: () async{
                                await DatabaseHelper().playTapAudio();
                                Get.focusScope?.unfocus();
                                if(controller.phone.text.isEmpty){
                                  CustomSnackbar.show("Phone field is required", kRed);
                                }else{
                                  if(controller.phone.text.startsWith("0")){
                                    controller.phone.text.replaceFirst("0", '');
                                  }
                                  await DatabaseHelper().login();
                                }

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
                      ],
                    );
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/lock.png"))),
                    ).marginOnly(top: 10),
                    Material(
                        elevation: 10,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(60),
                        child: InkWell(
                          onTap: () async{
                            await DatabaseHelper().playTapAudio();
                            Get.to(const SignupScreen(),
                                transition: Transition.zoom);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 150,
                            height: 40,
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
                              "Create new account",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        )).marginOnly(top: 10, bottom: 50),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                )
              ],
            ),
          ).marginOnly(left: 75)
        ],
      ),
    );
  }
}
