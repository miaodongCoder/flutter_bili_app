// ignore_for_file: avoid_print, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/core/hi_state.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/dao/home_dao.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/page/home_tab_page.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/widget/navigation_bar.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {
  // 创建点击的回调方法:<~索引~>
  final ValueChanged<int>? onJumpTo;

  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  late TabController _controller;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      print('home:current:${current.page}');
      print('home:pre:${pre.page}');
      if (widget == current.page || current.page is HomePage) {
        print('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页:onPause');
      }
    });

    loadData();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Navigation_Bar(
            child: _appBar(),
            height: 44,
            color: Colors.white,
            statusStyle: StatusStyle.DARK_CONTENT,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 4),
            child: _tabBar(),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: categoryList.map(
                (category) {
                  return HomeTabPage(
                    category: category.name,
                    bannerList: category.name == '推荐' ? bannerList : null,
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  ///自定义顶部tab
  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: const UnderlineIndicator(
            strokeCap: StrokeCap.round,
            borderSide: BorderSide(color: primary, width: 3),
            insets: EdgeInsets.only(left: 15, right: 15)),
        tabs: categoryList.map<Tab>((category) {
          return Tab(
              child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 16),
            ),
          ));
        }).toList());
  }

  // 请求首页列表数据:
  loadData() async {
    try {
      HomeMo result = await HomeDao.get('推荐');
      print('loadData: $result');
      if (result.categoryList != null) {
        _controller =
            TabController(length: result.categoryList!.length, vsync: this);
        setState(() {
          categoryList = result.categoryList!;
          if (result.bannerList != null) {
            bannerList = result.bannerList!;
          }
        });
      }
      setState(() {});
    } on NeedAuthor catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  //( 图片 + 搜索框 + 图标 + 图标 ) 样式的顶部AppBar:
  _appBar() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: const Image(
                height: 44,
                width: 44,
                image: AssetImage('images/avatar.png'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 12,
            ),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
