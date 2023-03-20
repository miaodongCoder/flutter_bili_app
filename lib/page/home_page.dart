// ignore_for_file: avoid_print, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/core/hi_state.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/dao/home_dao.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/page/home_tab_page.dart';
import 'package:flutter_bili_app/page/profile_page.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/loading_container.dart';
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
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  var listener;
  late TabController _controller;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  bool _isShowLoading = true;
  Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (cur, pre) {
      print('home:current:${cur.page}');
      print('home:pre:${pre.page}');
      _currentPage = cur.page;
      if (widget == cur.page || cur.page is HomePage) {
        print('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页:onPause');
      }

      // 当页面返回到首页的时候回复首页的状态栏样式:
      if (pre?.page is VideoDetailPage && cur.page is! ProfilePage) {
        var statusStyle = StatusStyle.DARK_CONTENT;
        changeStatusBar(color: Colors.white, statusStyle: statusStyle);
      }
    });

    loadData();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// 监听生命周期的变化:
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    print('生命周期状态: $state');
    switch (state) {
      // 处于这种状态的应用程序应该假设它们可能在任何时候暂停:
      case AppLifecycleState.inactive:
        {
          break;
        }
      // 从后台切换前台，界面可见:
      case AppLifecycleState.resumed:
        {
          // 解决 Android 压后台首页状态栏字体颜色变白，详情页状态栏字体变黑问题:
          // 不是详情页状态栏改成白色:
          if (_currentPage is! VideoDetailPage) {
            changeStatusBar(
                color: Colors.white, statusStyle: StatusStyle.DARK_CONTENT);
          }
          break;
        }
      // 界面不可见，后台:
      case AppLifecycleState.paused:
        {
          break;
        }
      // APP结束时调用:
      case AppLifecycleState.detached:
        {
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
          cover: true,
          isLoading: _isShowLoading,
          child: Column(
            children: [
              Navigation_Bar(
                child: _appBar(),
                height: 44,
                color: Colors.white,
                statusStyle: StatusStyle.DARK_CONTENT,
              ),
              Container(
                color: Colors.white,
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
          )),
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
      }
      setState(() {
        if (result.categoryList != null) {
          categoryList = result.categoryList!;
        }
        if (result.bannerList != null) {
          bannerList = result.bannerList!;
        }
        _isShowLoading = false;
      });
    } on NeedAuthor catch (e) {
      print(e);
      showWarnToast(e.message);
      setState(() {
        _isShowLoading = false;
      });
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
      setState(() {
        _isShowLoading = false;
      });
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
