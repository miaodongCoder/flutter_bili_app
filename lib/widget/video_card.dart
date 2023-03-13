import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/video_model.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/util/format_util.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoCard extends StatelessWidget {
  final VideoModel videoModel;
  const VideoCard({Key? key, required this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(videoModel.url);
        HiNavigator.getInstance()
            .onJumpTo(RouteStatus.detail, args: {"videoModel": videoModel});
      },
      child: SizedBox(
        height: 200,
        // Card组件有阴影效果:
        child: Card(
          margin: const EdgeInsets.only(left: 4, right: 4, bottom: 4, top: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemImage(context),
                _infoText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 卡片图片:
  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        FadeInImage.memoryNetwork(
          height: 120,
          width: (size.width - 20),
          fit: BoxFit.cover,
          placeholder: kTransparentImage,
          image: videoModel.cover,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                // 54到透明色:
                colors: <Color>[Colors.black54, Colors.transparent],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconText(Icons.ondemand_video, videoModel.view),
                _iconText(Icons.favorite_border, videoModel.favorite),
                _iconText(null, videoModel.duration),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 获取底部的 icon 和文字组合的视图:
  Widget _iconText(IconData? iconData, int count) {
    String views = "";
    if (iconData != null) {
      views = countFormat(count);
    } else {
      views = durationTransform(videoModel.duration);
    }

    return Row(
      children: [
        if (iconData != null)
          Icon(
            iconData,
            color: Colors.white,
            size: 12,
          ),
        Padding(
          padding: const EdgeInsets.only(
            left: 3,
          ),
          child: Text(
            views,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  /// 卡片底部的标题信息:
  _infoText(BuildContext context) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoModel.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
          _owner(),
        ],
      ),
    ));
  }

  _owner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                videoModel.owner.face,
                width: 24,
                height: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: Text(
                videoModel.owner.name,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const Icon(
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        ),
      ],
    );
  }
}
