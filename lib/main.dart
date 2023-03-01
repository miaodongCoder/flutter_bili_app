import 'package:flutter/material.dart';
import 'package:flutter_bili_app/db/hi_cache.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/page/home_page.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';

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
    return FutureBuilder<HiCache>(
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            widget = Router(routerDelegate: _routerDelegate);
          } else {
            widget = const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return MaterialApp(
            theme: ThemeData(primaryColor: Colors.white),
            home: widget,
          );
        });
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
  RouteStatus _routeStatus = RouteStatus.home;
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  BiliRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  // 存放所有的页面:
  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    // 管理路由堆栈:
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      // 要打开的页面在栈中已存在, 则将该页面和它上面的所有页面进行出栈处理:
      // tips: 具体规则可以根据需求调整, 这里要求栈中只允许有一个同样的页面实例!
      tempPages = tempPages.sublist(0, index);
    }

    MaterialPage page;
    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrapper(
        HomePage(
          onJumpToDetail: (VideoModel videoModel) {
            this.videoModel = videoModel;
            notifyListeners();
          },
        ),
      );
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrapper(
        VideoDetailPage(videoModel),
      );
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrapper(
        RegistrationPage(
          onJumpLogin: () {
            _routeStatus = RouteStatus.login;
            notifyListeners();
          },
        ),
      );
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrapper(
        const LoginPage(),
      );
    }
    // 未知:
    else {
      page = pageWrapper(
        HomePage(
          onJumpToDetail: (VideoModel videoModel) {
            this.videoModel = videoModel;
            notifyListeners();
          },
        ),
      );
    }

    // 重新创建一个新的数组 , 否则 pages 因为引用没有改变路由不会生效:
    tempPages = [... tempPages, page];
    pages = tempPages;

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

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    }
    return _routeStatus;
  }

  bool get hasLogin {
    String? boardingPass = LoginDao.getBoardingPass();
    return boardingPass != null;
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
  Future<void> setNewRoutePath(BiliRouterPath configuration) async {}
}
