import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

// 创建枚举支持明亮和阴冷颜色的情况:
enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class Navigation_Bar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;
  const Navigation_Bar({
    Key? key,
    this.statusStyle = StatusStyle.DARK_CONTENT,
    this.color = Colors.white,
    this.height = 44,
    this.child,
  }) : super(key: key);

  @override
  State<Navigation_Bar> createState() => _Navigation_BarState();
}

class _Navigation_BarState extends State<Navigation_Bar> {
  @override
  void initState() {
    super.initState();

    _statusBarInit();
  }

  @override
  Widget build(BuildContext context) {
    // 状态栏高度:
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      decoration: BoxDecoration(color: widget.color),
      padding: EdgeInsets.only(top: top),
      child: widget.child,
    );
  }

  /// 初始化状态栏:
  void _statusBarInit() {
    // 沉浸式状态栏:
    changeStatusBar(
      color: widget.color,
      statusStyle: widget.statusStyle,
    );
  }
}
