import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart' as vp;
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/colors.dart';

class VideoPlayer extends StatefulWidget {
  final List<String> videoUrls;
  final String videotitle;

  const VideoPlayer(this.videoUrls,this.videotitle, {Key? key}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late vp.VideoPlayerController _controller;
  bool _isPlaying = false;
  bool mediaVisibility = true;
  bool isFast = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _initializeController();
    _checkInternetStrength();
  }

  Future<void> _initializeController() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPosition = prefs.getInt('${widget.videotitle}_video_position') ?? 0;
    final currentIndex = prefs.getInt('${widget.videotitle}_video_index') ?? 0;

    _controller =
        vp.VideoPlayerController.network(widget.videoUrls[currentIndex])
          ..initialize().then((_) {
            setState(() {
              _isPlaying = true;
              _controller.seekTo(Duration(seconds: savedPosition));
              _controller.play();
            });
          });

    _controller.addListener(() async {
      final position = _controller.value.position;
      final currentIndex = widget.videoUrls.indexOf(_controller.dataSource);

      await prefs.setInt('${widget.videotitle}_video_position', position.inSeconds);
      await prefs.setInt('${widget.videotitle}_video_index', currentIndex);
      if (_controller!.value.position >= _controller!.value.duration) {
        await prefs.setInt("${widget.videotitle}_video_position", 0);
        await prefs.setInt("${widget.videotitle}_video_index", 0);
      }
    });
  }

  Future<void> _checkInternetStrength() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi) {
      // Play 1080p video
      _controller.pause();
      _controller.dispose();
      setState(() {
        _isPlaying = false;
      });
      _controller = vp.VideoPlayerController.network(widget.videoUrls[0]);
      _initializeController();
    } else if (connectivityResult == ConnectivityResult.mobile) {
      // Play 720p video
      _controller.pause();
      _controller.dispose();
      setState(() {
        _isPlaying = false;
      });
      _controller = vp.VideoPlayerController.network(widget.videoUrls[1]);
      _initializeController();
    } else {
      // Play 480p video
      _controller.pause();
      _controller.dispose();
      setState(() {
        _isPlaying = false;
      });
      _controller = vp.VideoPlayerController.network(widget.videoUrls[2]);
      _initializeController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                mediaVisibility = !mediaVisibility;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _controller.value.isInitialized
                  ? vp.VideoPlayer(_controller)
                  : Center(
                      child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator()),
                    ),
            ),
          ),
          Visibility(
              visible: mediaVisibility,
              child: Positioned(
                  bottom: 10,
                  child: Container(
                    height: 100,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Image.asset("assets/images/monte.png",width: 60,height: 60,)),
                        Container(
                          decoration: BoxDecoration(
                              color: kPink.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                    _isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    if (_isPlaying) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                    _isPlaying = !_isPlaying;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 200,
                                height: 10,
                                child: vp.VideoProgressIndicator(
                                  _controller,
                                  colors: vp.VideoProgressColors(
                                      playedColor: kPink,
                                      bufferedColor: kYellow.withOpacity(0.2)),
                                  allowScrubbing: false,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.replay, color: Colors.white),
                                onPressed: () {
                                  _controller.seekTo(Duration(seconds: 0));
                                  _controller.play();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.speed,
                                    color: isFast ? Colors.white : kPink),
                                onPressed: () {
                                  setState(() {
                                    isFast = false;
                                  });
                                  _controller.setPlaybackSpeed(1.0);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.speed,
                                    color: isFast ? kPink : Colors.white),
                                onPressed: () {
                                  setState(() {
                                    isFast = true;
                                  });
                                  _controller.setPlaybackSpeed(2.0);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],

                    ),
                  )))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }
}
