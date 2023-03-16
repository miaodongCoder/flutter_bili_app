import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/model/video_model.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;
  const HiBanner(this.bannerList,
      {Key? key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: const DotSwiperPaginationBuilder(
              color: Colors.white54,
              size: 5.0,
              activeSize: 6.0,
              activeColor: Colors.white)),
    );
  }

  // 创建图片:
  _image(BannerMo bannerMo) {
    return InkWell(
      onTap: () {
        // print(bannerMo.title);
        _handleClicked(bannerMo);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Image.network(
            bannerMo.cover,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// 轮播图点击事件:
  void _handleClicked(BannerMo bannerMo) {
    // 跳转影片详情:
    if (bannerMo.type == 'video') {
      HiNavigator.getInstance().onJumpTo(
        RouteStatus.detail,
        args: {
          'videoModel': VideoModel(vid: bannerMo.url),
        },
      );
      return;
    }
    // 跳转 H5 页面:
    _jumpToHtml5Page(bannerMo.url);
  }

  Future<bool> _jumpToHtml5Page(String url) async {
    return await launchUrl(Uri.parse(url));
  }
}
