// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/video_model.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/navigation_bar.dart';
import 'package:flutter_bili_app/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel? videoModel;
  const VideoDetailPage(this.videoModel, {super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();
    // 黑色状态栏:
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        removeTop: Platform.isIOS,
        context: context,
        child: Column(
          children: [
            Navigation_Bar(
              color: Colors.black,
              statusStyle: StatusStyle.LIGHT_CONTENT,
              height: Platform.isAndroid ? 0 : 46,
            ),
            _videoView(),
            Text("视频vid = ${widget.videoModel?.vid}"),
            Text("视频名称 = ${widget.videoModel?.title}"),
          ],
        ),
      ),
    );
  }

  _videoView() {
    return VideoView(
      widget.videoModel!.url!,
      cover: widget.videoModel!.cover,
      overlayUI: videoAppBar(),
    );
  }
}
