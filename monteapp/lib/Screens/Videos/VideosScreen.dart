import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Constants/colors.dart';
import 'package:monteapp/Database/databasehelper.dart';
import 'package:monteapp/Screens/Videos/VideoPlayer.dart';
import 'package:monteapp/Widgets/BackButton.dart';

import '../../Models/VideoModel.dart';

class VideosScreen extends StatefulWidget {
  final List<VideoModel> _videoList;

  const VideosScreen(this._videoList, {super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return VideoScreenPortrait(widget._videoList);
        } else {
          return VideoScreenLandscape(widget._videoList);
        }
      },
    );
  }
}

class VideoScreenPortrait extends StatefulWidget {
  final List<VideoModel> _videoList;

  const VideoScreenPortrait(this._videoList, {super.key});

  @override
  State<VideoScreenPortrait> createState() => _VideoScreenPortraitState();
}

class _VideoScreenPortraitState extends State<VideoScreenPortrait>
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
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/gameBgPortrait.png"))),
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.7),
            itemCount: widget._videoList.length,
            itemBuilder: (context, index) {
              double yOffset = index.isEven ? -20.0 : 20.0;
              Random random = Random();
              int randomNumber = random.nextInt(6) + 1;

              return AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return InkWell(
                      onTap: () async {
                        await DatabaseHelper().playTapAudio();
                        List<String> _videoList=[];
                        if(widget._videoList[index].the1080==null){
                          widget._videoList[index].the1080=widget._videoList[index].the480;
                        }
                        if(widget._videoList[index].the720==null){
                          widget._videoList[index].the720=widget._videoList[index].the480;
                        }
                        if(widget._videoList[index].the360==null){
                          widget._videoList[index].the360=widget._videoList[index].the480;
                        }
                        _videoList.add(widget._videoList[index].the1080!);
                        _videoList.add(widget._videoList[index].the720!);
                        _videoList.add(widget._videoList[index].the480!);
                        Get.to(VideoPlayer(_videoList,widget._videoList[index].title!),
                            transition: Transition.zoom);
                      },
                      child: Transform.translate(
                        offset: Offset(0, yOffset),
                        child: Transform.rotate(
                            angle: _animation.value,
                            child: Column(
                              children: [
                                Container(
                                  height: 130,
                                  width: 100,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "assets/images/baloon${randomNumber}.png"))),
                                  child: Container(width: 80,height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(widget._videoList[index].thumbnail!)
                                    )
                                  ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: kRed,
                                    border: Border.all(color: kYellow),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text(
                                    widget._videoList[index].title ?? "",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ).marginAll(10),
                                ),
                              ],
                            )).marginAll(10),
                      ),
                    );
                  });
            },
          ).marginOnly(top: 80),
          Back()
        ],
      ),
    );
  }
}

class VideoScreenLandscape extends StatefulWidget {
  final List<VideoModel> _videoList;

  const VideoScreenLandscape(this._videoList, {super.key});

  @override
  State<VideoScreenLandscape> createState() => _VideoScreenLandscapeState();
}

class _VideoScreenLandscapeState extends State<VideoScreenLandscape>
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
              child: Container(
                height: MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget._videoList.length,
                  itemBuilder: (context, index) {
                    double xOffset = index.isEven ? 30.0 : 0.0;
                    Random random = Random();
                    int randomNumber = random.nextInt(6) + 1;
                    return AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return InkWell(
                          onTap: () async {
                            await DatabaseHelper().playTapAudio();
                            List<String> _videoList=[];
                            if(widget._videoList[index].the1080==null){
                              widget._videoList[index].the1080=widget._videoList[index].the480;
                            }
                            if(widget._videoList[index].the720==null){
                              widget._videoList[index].the720=widget._videoList[index].the480;
                            }
                            if(widget._videoList[index].the360==null){
                              widget._videoList[index].the360=widget._videoList[index].the480;
                            }
                            _videoList.add(widget._videoList[index].the1080!);
                            _videoList.add(widget._videoList[index].the720!);
                            _videoList.add(widget._videoList[index].the480!);
                            Get.to(VideoPlayer(_videoList,widget._videoList[index].title!), transition: Transition.zoom);
                          },
                          child: Transform.translate(
                            offset: Offset(0, xOffset),
                            child: Transform.rotate(
                              angle: _animation.value,
                              child: Column(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 100,
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            "assets/images/baloon$randomNumber.png"),
                                      ),
                                    ),
                                    child: Container(width: 80,height: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(widget._videoList[index].thumbnail!)
                                        )
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    // height: 80,
                                    decoration: BoxDecoration(
                                        color: kRed,
                                        border: Border.all(color: kYellow),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(
                                      widget._videoList[index].title ?? "",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ).marginAll(10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )),
          Back()
        ],
      ),
    );
  }
}
