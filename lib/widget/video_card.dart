import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/video_model.dart';

class VideoCard extends StatelessWidget {
  final VideoModel videoModel;
  const VideoCard({Key? key, required this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(videoModel.url);
      },
      child: Image.network(
        videoModel.cover,
      ),
    );
  }
}
