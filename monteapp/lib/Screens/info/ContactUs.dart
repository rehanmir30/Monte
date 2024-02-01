import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:monteapp/Controllers/ContactUsController.dart';
import 'package:monteapp/Widgets/CustomSnackbar.dart';
import '../../Constants/colors.dart';
import '../../Database/databasehelper.dart';
import '../../Widgets/BackButton.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const ContactUsPortrait();
        } else {
          return const ContactUsLandscape();
        }
      },
    );
  }
}

class ContactUsPortrait extends StatefulWidget {
  const ContactUsPortrait({super.key});

  @override
  State<ContactUsPortrait> createState() => _ContactUsPortraitState();
}

class _ContactUsPortraitState extends State<ContactUsPortrait> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/gameBgPortrait.png"))),
          ),
          Back(),
          Positioned(
              top: 60,
              child: Text(
                "Contact us",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          Positioned(
            top: 95,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  // fit: BoxFit.fitHeight,
                  image: AssetImage("assets/images/loginPotraitContainer.png"),
                )),
                child: GetBuilder<ContactUsController>(builder: (controller) {
                  return Column(
                    children: [
                      Container(
                        width: 65,
                        height: 75,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/LoginPortraitMonte.png"))),
                      ).marginOnly(right: 10, top: 30),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.center,
                            controller: controller.nameController,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Name',
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
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            controller: controller.emailController,
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
                      ).marginOnly(top: 12),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.center,
                            controller: controller.phoneController,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Phone',
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
                      ).marginOnly(top: 12),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            controller: controller.messageController,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Message',
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
                      ).marginOnly(top: 12),
                      Material(
                          elevation: 10,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(60),
                          child: InkWell(
                            onTap: () async {
                              if (controller.nameController.text.isEmpty ||
                                  controller.emailController.text.isEmpty ||
                                  controller.phoneController.text.isEmpty ||
                                  controller.messageController.text.isEmpty) {
                                CustomSnackbar.show(
                                    "All fields are required", kRed);
                                return;
                              } else {
                                await DatabaseHelper().sendContactUs(
                                    controller.nameController.text,
                                    controller.emailController.text,
                                    controller.phoneController.text,
                                    controller.messageController.text);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 130,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                border: Border.all(color: Colors.yellow),
                                gradient: const LinearGradient(
                                  colors: [Color(0xff104e99), Color(0xff8dabc9)],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: const Text(
                                "Send",
                                style:
                                TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )).marginOnly(top: 12),
                    ],
                  ).marginSymmetric(horizontal: 30).marginOnly(top: 40);
                },)
                ),
          ),
          Positioned(
              right: 20,
              top: 60,
              child: InkWell(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.scaleDown,
                                  image:
                                  AssetImage("assets/images/loginLandscapeContainer.png"),
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    "assets/images/balloons.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Text(
                                  "Are you sure!",
                                  style: const TextStyle(color: Colors.white, fontSize: 18),
                                  textAlign: TextAlign.left,
                                ).marginOnly(
                                  top: 12,
                                ),
                                Text(
                                  "You want to delete your account?",
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                          elevation: 10,
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(60),
                                          child: InkWell(
                                            onTap: () async {
                                              await DatabaseHelper().playTapAudio();
                                              CustomSnackbar.show("Request to delete account has been sent to admin. Your account will be disabled within 24 hours", kRed);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 30,
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
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 12),
                                              ),
                                            ),
                                          )).marginOnly(top: 20),
                                      SizedBox(width: 12,),
                                      Material(
                                          elevation: 10,
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(60),
                                          child: InkWell(
                                            onTap: () async {
                                              await DatabaseHelper().playTapAudio();
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(60),
                                                border: Border.all(color: Colors.yellow),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xffc10946),
                                                    Color(0xff834457)
                                                  ],
                                                  // Define your gradient colors
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                              child: const Text(
                                                "No",
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 12),
                                              ),
                                            ),
                                          )).marginOnly(top: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ).marginSymmetric(vertical: 20, horizontal: 30),
                          ),
                        );
                      },
                    );
                  },
                  child: Text("Delete account?",style: TextStyle(color: kRed,fontSize: 18,fontWeight: FontWeight.bold),))),
        ],
      ),
    );
  }
}

class ContactUsLandscape extends StatefulWidget {
  const ContactUsLandscape({super.key});

  @override
  State<ContactUsLandscape> createState() => _ContactUsLandscapeState();
}

class _ContactUsLandscapeState extends State<ContactUsLandscape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/loginBgLandscape.jpg"))),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/signupLandscapeContainer.png"),
            )),
            child: GetBuilder<ContactUsController>(builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment:Alignment.centerLeft,
                    child: Text(
                      "Contact us",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
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
                              controller: controller.nameController,
                              textAlign: TextAlign.center,
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "Name",
                                filled: true,
                                hintStyle:
                                const TextStyle(color: Colors.white, fontSize: 12),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow,
                                      width: 2.0), // Change the color and width here
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
                          width: 12,
                        ),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              controller: controller.emailController,
                              textAlign: TextAlign.center,
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "Email",
                                filled: true,
                                hintStyle:
                                const TextStyle(color: Colors.white, fontSize: 12),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow,
                                      width: 2.0), // Change the color and width here
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
                  ),
                  Align(
                    alignment:Alignment.centerLeft,
                    child: Row(
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
                              controller: controller.phoneController,
                              textAlign: TextAlign.center,
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "Phone",
                                filled: true,
                                hintStyle:
                                const TextStyle(color: Colors.white, fontSize: 12),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow,
                                      width: 2.0), // Change the color and width here
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
                          width: 12,
                        ),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.transparent,
                          child: SizedBox(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              controller: controller.messageController,
                              textAlign: TextAlign.center,
                              onTap: () async {
                                await DatabaseHelper().playTapAudio();
                              },
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "Message",
                                filled: true,
                                hintStyle:
                                const TextStyle(color: Colors.white, fontSize: 12),
                                fillColor: const Color(0xffD90F4E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide(
                                      color: Colors.yellow,
                                      width: 2.0), // Change the color and width here
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
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Material(
                        elevation: 10,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(60),
                        child: InkWell(
                          onTap: () async {
                            if (controller.nameController.text.isEmpty ||
                                controller.emailController.text.isEmpty ||
                                controller.phoneController.text.isEmpty ||
                                controller.messageController.text.isEmpty) {
                              CustomSnackbar.show(
                                  "All fields are required", kRed);
                              return;
                            } else {
                              await DatabaseHelper().sendContactUs(
                                  controller.nameController.text,
                                  controller.emailController.text,
                                  controller.phoneController.text,
                                  controller.messageController.text);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 130,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(color: Colors.yellow),
                              gradient: const LinearGradient(
                                colors: [Color(0xff104e99), Color(0xff8dabc9)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: const Text(
                              "Send",
                              style:
                              TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        )).marginOnly(top: 12),
                  ),
                ],
              ).marginOnly(left: 50);
            },),
          ),
          Positioned(
              right: 20,
              top: 60,
              child: InkWell(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.scaleDown,
                                  image:
                                  AssetImage("assets/images/loginLandscapeContainer.png"),
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    "assets/images/balloons.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Text(
                                  "Are you sure!",
                                  style: const TextStyle(color: Colors.white, fontSize: 18),
                                  textAlign: TextAlign.left,
                                ).marginOnly(
                                  top: 12,
                                ),
                                Text(
                                  "You want to delete your account?",
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                          elevation: 10,
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(60),
                                          child: InkWell(
                                            onTap: () async {
                                              await DatabaseHelper().playTapAudio();
                                              CustomSnackbar.show("Request to delete account has been sent to admin. Your account will be disabled within 24 hours", kRed);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 30,
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
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 12),
                                              ),
                                            ),
                                          )).marginOnly(top: 20),
                                      SizedBox(width: 12,),
                                      Material(
                                          elevation: 10,
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(60),
                                          child: InkWell(
                                            onTap: () async {
                                              await DatabaseHelper().playTapAudio();
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(60),
                                                border: Border.all(color: Colors.yellow),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xffc10946),
                                                    Color(0xff834457)
                                                  ],
                                                  // Define your gradient colors
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                              child: const Text(
                                                "No",
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 12),
                                              ),
                                            ),
                                          )).marginOnly(top: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ).marginSymmetric(vertical: 20, horizontal: 30),
                          ),
                        );
                      },
                    );
                    },
                  child: Text("Delete account?",style: TextStyle(color: kRed,fontSize: 18,fontWeight: FontWeight.bold),))),
          Back(),
        ],
      ),
    );
  }
}
