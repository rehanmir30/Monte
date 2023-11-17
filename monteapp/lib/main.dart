import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:monteapp/Screens/auth/Login/LoginScreen.dart';
import 'package:video_player/video_player.dart';

import 'Controllers/InitControllers/InitController.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  disableScreenshotsAndScreenRecording();
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
        // OrientationBuilder(
        //   builder: (context, orientation) {
        //     if(orientation==Orientation.portrait){
        //       return const SplashScreenPortrait();
        //     }else{
        //       return const SplashScreenLandscape();
        //     }
        //   },
        // )

        );
  }
}

class SplashScreenPortrait extends StatefulWidget {
  const SplashScreenPortrait({super.key});

  @override
  State<SplashScreenPortrait> createState() => _SplashScreenPortraitState();
}

class _SplashScreenPortraitState extends State<SplashScreenPortrait> {
  bool _isVisible = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _isVisible = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 4000), () async {
      Get.offAll(const LoginScreen(), transition: Transition.downToUp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/splashBgPortrait.jpg"))),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Where fun meets learning!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 36),
              ).marginSymmetric(horizontal: 20),
              AnimatedContainer(
                width: _isVisible ? 0 : 200,
                height: _isVisible ? 0 : 200,
                curve: Curves.bounceIn,
                duration: const Duration(seconds: 2),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/splashKidPortrait.png"),
                  ),
                ),
              ).marginOnly(top: 40)
            ],
          ),
        ),
      ),
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
    Future.delayed(Duration(seconds: 4),(){
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
              // UserModel? _user=await SharedPref.getUser();
              // if(_user==null){
              //   Get.offAll(const LoginScreen(), transition: Transition.downToUp);
              // }else{
              //   Get.find<UserController>().setUser(_user);
              //   await DatabaseHelper().getMainCategories();
              //   Get.offAll(const Home(), transition: Transition.circularReveal);
              // }
              Get.offAll(const LoginScreen(), transition: Transition.downToUp);

            }
          });
        });
      });

    // Set the preferred orientation to landscape when this screen is created
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
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
                    // UserModel? _user=await SharedPref.getUser();
                    // if(_user==null){
                    //   Get.offAll(const LoginScreen(), transition: Transition.downToUp);
                    // }else{
                    //   Get.find<UserController>().setUser(_user);
                    //   await DatabaseHelper().getMainCategories();
                    //   Get.offAll(const Home(), transition: Transition.circularReveal);
                    // }
                    Get.offAll(const LoginScreen(), transition: Transition.downToUp);
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
// class _SplashScreenLandscapeState extends State<SplashScreenLandscape> {
//
//   bool _isVisible = false;
//   @override
//   void initState() {
//     Future.delayed(const Duration(milliseconds: 2000), () {
//       setState(() {
//         _isVisible = true;
//       });
//     });
//
//     Future.delayed(const Duration(milliseconds: 4000), () async {
//       Get.offAll(const LoginScreen(),transition: Transition.downToUp);
//       // getSharedPrefs();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.cover,
//                 image: AssetImage("assets/images/splashBgLandscape.jpg")
//             )
//         ),
//         child: Align(
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text("Where fun meets learning!",textAlign: TextAlign.center,style: TextStyle(color: Colors.red,fontSize: 36),).marginSymmetric(horizontal: 20),
//               AnimatedContainer(
//                 width: _isVisible ? 0 : 150,
//                 height: _isVisible ? 0 : 150,
//                 curve: Curves.bounceIn,
//                 duration: const Duration(seconds: 2),
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/splashKidLandscape.png"),
//                   ),
//                 ),
//               ).marginOnly(top: 40)
//             ],
//           ),
//         ),
//       ),
//     );;
//   }
// }
