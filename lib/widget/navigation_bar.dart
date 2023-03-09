import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

// 创建枚举支持明亮和阴冷颜色的情况:
enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class Navigation_Bar extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;
  const Navigation_Bar(
      {Key? key,
      this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = Colors.white,
      this.height = 44,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _statusBarInit();
    // 状态栏高度:
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + height,
      decoration: BoxDecoration(color: color),
      padding: EdgeInsets.only(top: top),
      child: child,
    );
  }

  /// 初始化状态栏:
  void _statusBarInit() {
    // 沉浸式状态栏:
    FlutterStatusbarManager.setColor(color, animated: true);
    FlutterStatusbarManager.setStyle(statusStyle == StatusStyle.DARK_CONTENT
        ? StatusBarStyle.DARK_CONTENT
        : StatusBarStyle.LIGHT_CONTENT);
  }
}
