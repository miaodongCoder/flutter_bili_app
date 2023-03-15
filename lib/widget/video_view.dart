import 'package:flutter/material.dart';

class VideoView extends StatefulWidget {
  // 视频URL:
  final String url;
  // 视频封面:
  final String cover;
  // 是否自动播放:
  final bool isAutoPlaying;
  // 是否循环播放:
  final bool looping;
  // 视频缩放比例:
  final double aspectRatio;

  const VideoView(this.url, {Key? key, required this.cover, this.isAutoPlaying = false, this.looping = false, this.aspectRatio = 16 / 9}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
