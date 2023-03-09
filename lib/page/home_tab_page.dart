// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/dao/home_dao.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/model/video_model.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/widget/hi_banner.dart';
import 'package:flutter_bili_app/widget/video_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String category;
  final List<BannerMo>? bannerList;

  const HomeTabPage({Key? key, required this.category, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<VideoModel> videoList = [];
  int pageIndex = 1;
  bool _loading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(() {
      var dis = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      print('dis: $dis');
      if (dis < 300 && !_loading) {
        _loadData(loadMore: true);
      }
    });

    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _loadData,
        color: primary,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Container(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                // 列表滚动方向 默认向下:
                axisDirection: AxisDirection.down,
                // 主轴上 item 间距:
                mainAxisSpacing: 4,
                // 次轴上 item 间距:
                crossAxisSpacing: 4,
                children: <Widget>[
                  if (widget.bannerList != null)
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 2,
                      child: _banner(),
                    ),
                  ...videoList.map(
                    (VideoModel videoModel) {
                      return StaggeredGridTile.fit(
                        crossAxisCellCount: 1,
                        child: VideoCard(
                          videoModel: videoModel,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(
        widget.bannerList!,
        bannerHeight: 160,
        padding: const EdgeInsets.all(4),
      ),
    );
  }

  // 获取首页列表数据:
  Future<void> _loadData({bool loadMore = false}) async {
    _loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      HomeMo result = await HomeDao.get(widget.category,
          pageIndex: currentIndex, pageSize: 50);
      print('HomeTabPage => loadData: $result');
      setState(() {
        // 加载更多数据:
        if (loadMore) {
          if (result.videoList != null) {
            videoList = [...videoList, ...result.videoList];
            // videoList.addAll(result.videoList);
            pageIndex++;
          }
        }
        // 下拉刷新:
        else {
          videoList = result.videoList;
        }
      });

      Future.delayed(
        const Duration(
          milliseconds: 1000,
        ),
        () {
          _loading = false;
        },
      );
    } on NeedAuthor catch (e) {
      _loading = false;
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      _loading = false;
      print(e);
      showWarnToast(e.message);
    }
  }
}
