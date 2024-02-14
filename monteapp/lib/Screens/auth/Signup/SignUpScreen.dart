import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:monteapp/Constants/colors.dart';
import 'package:monteapp/Controllers/CountryCodeController.dart';
import 'package:monteapp/Controllers/LevelsController.dart';
import 'package:monteapp/Controllers/LoadingController.dart';
import 'package:monteapp/Controllers/SignupController.dart';
import 'package:monteapp/Models/LevelModel.dart';
import 'package:intl/intl.dart';
import 'package:monteapp/Widgets/CustomSnackbar.dart';
import 'package:monteapp/Widgets/LoadingAnimation.dart';
import '../../../Database/databasehelper.dart';
import '../../../Models/CountryCode.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const SignupPortrait();
        } else {
          return const SignupLandscape();
        }
      },
    );
  }

  final LevelsController _levelController = Get.find<LevelsController>();
  final SignupController _signupController = Get.find<SignupController>();

  @override
  void initState() {
    super.initState();
    _signupController.setSelectedLevel(_levelController.levelList[0]);
  }
}

class SignupPortrait extends StatefulWidget {
  const SignupPortrait({super.key});

  @override
  State<SignupPortrait> createState() => _SignupPortraitState();
}

class _SignupPortraitState extends State<SignupPortrait>
    with SingleTickerProviderStateMixin {
  final LevelsController _levelController = Get.find<LevelsController>();

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
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.8,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/SignupPortraitContainer.png"),
              )),
              child: GetBuilder<SignupController>(
                builder: (controller) {
                  return Column(
                    children: [
                      Container(
                        width: 150,
                        height: 40,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/Register.png"))),
                      ),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            controller: controller.name,
                            textAlign: TextAlign.center,
                            onTap: () async {
                              await DatabaseHelper().playTapAudio();
                            },
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "Kid's  Name",
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
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            controller: controller.email,
                            textAlign: TextAlign.center,
                            onTap: () async {
                              await DatabaseHelper().playTapAudio();
                            },
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Email',
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
                            controller: controller.age,
                            onTap: () async {
                              await DatabaseHelper().playTapAudio();
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2025),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: const Color(0xffD90F4E),
                                      // accentColor: const Color(0xffD90F4E),
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
                                    DateFormat('yyyy-MM-dd').format(picked);
                                controller.age.text = formattedDate;
                              }
                            },
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            textAlign: TextAlign.center,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'DOB',
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
                        child: Container(
                          width: 150,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 8),
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
                                        child: Text(
                                            "${value.code}",style: TextStyle(color: Colors.white),),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.phone,
                                    onTap: () async {
                                      await DatabaseHelper().playTapAudio();
                                    },
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: 'Phone Number',
                                      // filled: true,
                                      hintStyle: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                      // fillColor: const Color(0xffD90F4E),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(60),
                                        borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width:
                                            2.0), // Change the color and width here
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.transparent, width: 2.0),
                                        //<-- SEE HERE
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.transparent, width: 2.0),
                                        //<-- SEE HERE
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
                            readOnly: true,
                            onTap: () async {
                              await DatabaseHelper().playTapAudio();
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: kRed,
                                    child: Wrap(
                                      children: _levelController.levelList
                                          .map((LevelModel model) {
                                        return ListTile(
                                          title: Text(
                                            model.name ?? "",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          onTap: () async{
                                            await controller.setSelectedLevel(model);
                                            Navigator.pop(context);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              );
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: controller.selectedLevel?.name ?? "",
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
                              if(controller.phone.text.startsWith("0")){
                                controller.phone.text.replaceFirst("0", '');
                              }else if (!RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(controller.email.text))
                              {
                                CustomSnackbar.show(
                                    "Email format is not correct", kRed);
                                return;
                              }
                              await DatabaseHelper().playTapAudio();
                              Get.find<LoadingController>().setLoading(true);
                                await DatabaseHelper().signUp(context);
                              Get.find<LoadingController>().setLoading(false);
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
                                "Next",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )).marginOnly(top: 20),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/lock.png"))),
                      ).marginOnly(top: 10),
                      Material(
                          elevation: 10,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(60),
                          child: InkWell(
                            onTap: () async {
                              await DatabaseHelper().playTapAudio();
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 170,
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
                                "Login with existing number",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )).marginOnly(top: 10),
                    ],
                  ).marginSymmetric(horizontal: 30).marginOnly(top: 40);
                },
              ),
            ),
          ),
          LoadingAnimation()
        ],
      ),
    );
  }
}

class SignupLandscape extends StatefulWidget {
  const SignupLandscape({super.key});

  @override
  State<SignupLandscape> createState() => _SignupLandscapeState();
}

class _SignupLandscapeState extends State<SignupLandscape>
    with SingleTickerProviderStateMixin {
  final LevelsController _levelController = Get.find<LevelsController>();
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
                GetBuilder<SignupController>(
                  builder: (controller) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 150,
                          height: 40,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/Register.png"))),
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
                                  controller: controller.name,
                                  textAlign: TextAlign.center,
                                  onTap: () async {
                                    await DatabaseHelper().playTapAudio();
                                  },
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  decoration: InputDecoration(
                                    hintText: "Kid's  Name",
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
                                  controller: controller.age,
                                  onTap: () async {
                                    await DatabaseHelper().playTapAudio();
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2010),
                                      lastDate: DateTime(2025),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            primaryColor:
                                                const Color(0xffD90F4E),
                                            // accentColor:
                                            //     const Color(0xffD90F4E),
                                            colorScheme:
                                                const ColorScheme.light(
                                                    primary: Colors.pink),
                                            buttonTheme: const ButtonThemeData(
                                                textTheme:
                                                    ButtonTextTheme.primary),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (picked != null) {
                                      final formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(picked);
                                      controller.age.text = formattedDate;
                                    }
                                  },
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: 'DOB',
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
                                  controller: controller.email,
                                  textAlign: TextAlign.center,
                                  onTap: () async {
                                    await DatabaseHelper().playTapAudio();
                                  },
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  decoration: InputDecoration(
                                    hintText: 'Email',
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
                                          controller: controller.phone,
                                          onTap: () async {
                                            await DatabaseHelper().playTapAudio();
                                          },
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 14),
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            hintText: 'Phone Number',
                                            // filled: true,
                                            hintStyle: const TextStyle(
                                                color: Colors.white, fontSize: 12),
                                            // fillColor: const Color(0xffD90F4E),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width:
                                                  2.0), // Change the color and width here
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent, width: 2.0),
                                              //<-- SEE HERE
                                              borderRadius: BorderRadius.circular(50.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent, width: 2.0),
                                              //<-- SEE HERE
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
                              readOnly: true,
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();

                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      color: kRed,
                                      child: Wrap(
                                        children: _levelController.levelList
                                            .map((LevelModel model) {
                                          return ListTile(
                                            title: Text(
                                              model.name ?? "",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              controller
                                                  .setSelectedLevel(model);
                                              Navigator.pop(context);
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                );
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: controller.selectedLevel?.name ?? "",
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
                                if(controller.phone.text.startsWith("0")){
                                  controller.phone.text.replaceFirst("0", '');
                                }
                                else if (!RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(controller.email.text))
                                {
                                  CustomSnackbar.show(
                                      "Email format is not correct", kRed);
                                  return;
                                }
                                Get.find<LoadingController>().setLoading(true);
                                await DatabaseHelper().signUp(context);
                                Get.find<LoadingController>().setLoading(false);
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
                                  "Next",
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
                    Material(
                        elevation: 10,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(60),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.23,
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
                              "Login with existing number",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        )).marginOnly(top: 10, bottom: 50),
                  ],
                )
              ],
            ).marginSymmetric(horizontal: 12),
          ).marginOnly(left: 35),
          LoadingAnimation()
        ],
      ),
    );
  }
}
