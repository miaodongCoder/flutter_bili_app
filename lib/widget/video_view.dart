import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';
import 'hi_video_controls.dart';

class VideoView extends StatefulWidget {
  // 视频URL:
  final String url;
  // 视频封面:
  final String cover;
  // 是否自动播放:
  final bool autoPlay;
  // 是否循环播放:
  final bool looping;
  // 视频缩放比例:
  final double aspectRatio;
  final Widget? overLayUI;

  const VideoView(
    this.url, {
    Key? key,
    required this.cover,
    this.autoPlay = false,
    this.looping = false,
    this.aspectRatio = 16 / 9,
    this.overLayUI,
  }) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  // video_player 播放器的控制器:
  late VideoPlayerController _videoPlayerController;
  // chewie 播放器的控制器:
  late ChewieController _chewieController;

  //进度条颜色配置
  get _progressColors => ChewieProgressColors(
        playedColor: primary,
        handleColor: primary,
        backgroundColor: Colors.grey,
        bufferedColor: primary[50]!,
      );

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      customControls: MaterialControls(
        showLoadingOnInitialize: false,
        showBigPlayIcon: false,
        bottomGradient: blackLinearGradient(),
        overlayUI: widget.overLayUI,
      ),
      materialProgressColors: _progressColors,
    );
    _chewieController.addListener(_fullScreenListener);
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(controller: _chewieController),
    );
  }

  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}
