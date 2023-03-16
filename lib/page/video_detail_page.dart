// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/video_model.dart';
import 'package:flutter_bili_app/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel? videoModel;
  const VideoDetailPage(this.videoModel, {super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("视频vid = ${widget.videoModel?.vid}"),
            Text("视频名称 = ${widget.videoModel?.title}"),
            _videoView(),
          ],
        ),
      ),
    );
  }

  _videoView() {
    return VideoView(widget.videoModel!.url!, cover: widget.videoModel!.cover);
  }
}
