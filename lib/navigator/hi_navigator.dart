import 'package:flutter/material.dart';
import 'package:flutter_bili_app/page/home_page.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';

MaterialPage pageWrapper(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

// 获取当前页面在我的路由堆栈里的索引位置:
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    // 如果在当前路由导航栈里:
    if (getRouteStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

/// 自定义路由封装:
enum RouteStatus { login, registration, home, detail, unknown }

/// 获取路由状态:
RouteStatus getRouteStatus (MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  }
  return RouteStatus.unknown;
}

/// 封装路由信息:
class StatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  StatusInfo(this.routeStatus, this.page);
}
