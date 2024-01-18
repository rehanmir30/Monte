import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Screens/Videos/VideosScreen.dart';
import 'package:monteapp/Widgets/CustomSnackbar.dart';

import '../../Constants/colors.dart';
import '../../Controllers/LoadingController.dart';
import '../../Controllers/UserController.dart';
import '../../Database/databasehelper.dart';
import '../../Models/SubCategoryModel.dart';
import '../../Models/VideoModel.dart';
import '../../Widgets/BackButton.dart';
import '../../Widgets/LoadingAnimation.dart';

class CategoryDetailScreen extends StatefulWidget {
  final List<SubCategoryModel> _subCategoryList;

  const CategoryDetailScreen(this._subCategoryList, {super.key});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return CategoryDetailPortrait(widget._subCategoryList);
        } else {
          return CategoryDetailLandscape(widget._subCategoryList);
        }
      },
    );
  }
}

class CategoryDetailPortrait extends StatefulWidget {
  final List<SubCategoryModel> _subCategoryList;

  const CategoryDetailPortrait(this._subCategoryList, {super.key});

  @override
  State<CategoryDetailPortrait> createState() => _CategoryDetailPortraitState();
}

class _CategoryDetailPortraitState extends State<CategoryDetailPortrait>
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
    _animation = Tween(begin: -0.1, end: 0.1).animate(
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
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/gameBgPortrait.png"))),
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.8),
            itemCount: widget._subCategoryList.length,
            itemBuilder: (context, index) {
              double yOffset = index.isEven ? -20.0 : 20.0;
              Random random = Random();
              int randomNumber = random.nextInt(6) + 1;

              return AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return InkWell(
                      onTap: () async {
                        Get.find<LoadingController>().setLoading(true);
                        List<VideoModel> videoList = await DatabaseHelper()
                            .getVideos(widget._subCategoryList[index]);

                        if (videoList.isEmpty) {
                          Get.find<LoadingController>().setLoading(false);
                          CustomSnackbar.show("No Videos found", kRed);
                        } else {
                          Get.find<LoadingController>().setLoading(false);
                          Get.to(VideosScreen(videoList),
                              transition: Transition.fade);
                        }
                      },
                      child: Transform.translate(
                        offset: Offset(0, yOffset),
                        child: Transform.rotate(
                            // offset: Offset(0, yOffset),
                            angle: _animation.value,
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          "assets/images/baloon${randomNumber}.png"))),
                              child: Text(
                                widget._subCategoryList[index].name ?? "",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            )).marginAll(10),
                      ),
                    );
                  });
            },
          ).marginOnly(top: 60),
          Back(),
          LoadingAnimation()
        ],
      ),
    );
  }
}

class CategoryDetailLandscape extends StatefulWidget {
  final List<SubCategoryModel> _subCategoryList;

  const CategoryDetailLandscape(this._subCategoryList, {super.key});

  @override
  State<CategoryDetailLandscape> createState() =>
      _CategoryDetailLandscapeState();
}

class _CategoryDetailLandscapeState extends State<CategoryDetailLandscape>
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
    _animation = Tween(begin: -0.1, end: 0.1).animate(
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
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/gameBgLandscape.png"))),
          ),
          Positioned(
              left: 20,
              top: 80,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget._subCategoryList.length,
                  itemBuilder: (context, index) {
                    double xOffset = index.isEven ? 30.0 : 0.0;
                    Random random = Random();
                    int randomNumber = random.nextInt(6) + 1;
                    return AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return InkWell(
                          onTap: ()async{
                            Get.find<LoadingController>().setLoading(true);
                            List<VideoModel> videoList = await DatabaseHelper()
                                .getVideos(widget._subCategoryList[index]);
                            await DatabaseHelper().playTapAudio();
                            if (videoList.isEmpty) {
                              Get.find<LoadingController>().setLoading(false);
                              CustomSnackbar.show("No Videos found", kRed);
                            } else {
                              Get.find<LoadingController>().setLoading(false);
                              Get.to(VideosScreen(videoList), transition: Transition.fade);
                            }
                          },
                          child: Transform.translate(
                            offset: Offset(0, xOffset),
                            child: Transform.rotate(
                              angle: _animation.value,
                              child: Container(
                                width: 120,
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/images/baloon$randomNumber.png"),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget._subCategoryList[index].name ?? "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )),
          Back(),
          LoadingAnimation()
        ],
      ),
    );
  }
}
