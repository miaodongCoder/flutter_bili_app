import 'package:flutter/material.dart';
import 'package:flutter_bili_app/db/hi_cache.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/core/hi_net.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/http/request/notice_request.dart';
import 'package:flutter_bili_app/page/home_page.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';
import 'package:flutter_bili_app/util/color.dart';

import 'model/video_model.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  State<BiliApp> createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  final BiliRouterDelegate _routerDelegate = BiliRouterDelegate();
  @override
  Widget build(BuildContext context) {
    var widget = Router(routerDelegate: _routerDelegate);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: widget,
    );
  }
}

class BiliRouterPath {
  final String location;
  // 命名构造函数:
  BiliRouterPath.path() : location = "/";
  BiliRouterPath.detail() : location = "/detail";
}

class BiliRouterDelegate extends RouterDelegate<BiliRouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRouterPath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  BiliRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  // 存放所有的页面:
  List<MaterialPage> pages = [];
  VideoModel? videoModel;
  BiliRouterPath? path;

  @override
  Widget build(BuildContext context) {
    // 构建路由页面堆栈:
    pages = [
      pageWrapper(
        HomePage(
          onJumpToDetail: (VideoModel videoModel) {
            this.videoModel = videoModel;
            notifyListeners();
          },
        ),
      ),
      if (videoModel != null)
        pageWrapper(
          VideoDetailPage(videoModel),
        ),
    ];

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (route.didPop(result)) {
          return true;
        }
        return false;
      },
    );
  }

  @override
  Future<bool> popRoute() {
    return Future.value(false);
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(BiliRouterPath path) async {
    this.path = path;
  }
}

pageWrapper(Widget child) {
   return MaterialPage(key: ValueKey(child.hashCode), child: child);
}