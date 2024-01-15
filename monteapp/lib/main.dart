import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:monteapp/Screens/auth/Login/LoginScreen.dart';
import 'package:video_player/video_player.dart';

import 'Constants/SharedPref/shared_pref_services.dart';
import 'Controllers/InitControllers/InitController.dart';
import 'Controllers/UserController.dart';
import 'Database/databasehelper.dart';
import 'Models/UserModel.dart';
import 'Screens/home/Home.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  disableScreenshotsAndScreenRecording();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

}
void disableScreenshotsAndScreenRecording() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: InitController(),
        title: "Monte App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "forte",
        ),
        home: const SplashScreenLandscape()
        );
  }
}

class SplashScreenLandscape extends StatefulWidget {
  const SplashScreenLandscape({super.key});

  @override
  State<SplashScreenLandscape> createState() => _SplashScreenLandscapeState();
}

class _SplashScreenLandscapeState extends State<SplashScreenLandscape> {
  VideoPlayerController? _controller;
bool skipVisibility=false;
  @override
  void initState() {
    super.initState();
    // Set the preferred orientation to landscape when this screen is created
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Future.delayed(Duration(seconds: 5),(){
      setState(() {
        skipVisibility=true;
      });
    });
    _controller = VideoPlayerController.asset('assets/videos/titleVideo.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller?.play();
          _controller!.addListener(() async {
            if (_controller!.value.position >= _controller!.value.duration) {
              // Video has finished playing
              UserModel? _user=await SharedPref.getUser();
              if(_user==null){
                SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                Get.offAll(const LoginScreen(), transition: Transition.downToUp);
              }else{
                Get.find<UserController>().setUser(_user);
                await DatabaseHelper().getMainCategories();
                // _controller?.dispose();
                SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                Get.offAll(const Home(), transition: Transition.circularReveal);
              }
              // Get.offAll(const LoginScreen(), transition: Transition.downToUp);
            }
          });
        });
      });


  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: _controller!.value.isInitialized
                    ? VideoPlayer(_controller!)
                    : CircularProgressIndicator(),
              ),
            ],
          ),
          Visibility(
            visible: skipVisibility,
            child: Positioned(
                top: 20,
                right: 20,
                child: TextButton(
                  onPressed: () async {
                    UserModel? _user=await SharedPref.getUser();
                    if(_user==null){
                      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                      Get.offAll(const LoginScreen(), transition: Transition.downToUp);
                    }else{
                      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                      Get.find<UserController>().setUser(_user);
                      await DatabaseHelper().getMainCategories();
                      _controller?.dispose();
                      Get.offAll(const Home(), transition: Transition.circularReveal);
                    }
                    // Get.offAll(const LoginScreen(), transition: Transition.downToUp);
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
