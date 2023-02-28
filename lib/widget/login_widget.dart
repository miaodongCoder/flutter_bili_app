import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/color.dart';

/// 登录输入框 , 自定义 widget:
class LoginInput extends StatefulWidget {
  final String title;
  final String hint; // 提示文案
  final ValueChanged<String>? onChange; // 修改文字
  final ValueChanged<bool>? focusChange; // 聚焦
  final bool lineStretch; // 输入框类型 (`全屏输入框` 、`标题 + 输入框`)
  final bool obscureText; // 密码输入(模糊文字)
  final TextInputType? keyboardType; // 键盘类型

  const LoginInput(
    this.title,
    this.hint, {
    Key? key,
    this.onChange,
    this.focusChange,
    this.lineStretch = false,
    this.obscureText = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // 获取光标的监听:
    _focusNode.addListener(() {
      bool hasFocus = _focusNode.hasFocus;
      if (widget.focusChange != null) {
        widget.focusChange!(hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input(), // 输入框
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: (!widget.lineStretch ? 15 : 0)),
          child: const Divider(
            height: 1,
            thickness: .5,
          ),
        ),
      ],
    );
  }

  Widget _input() {
    // 输入框占据除了左边文字之外的所有位置:
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChange,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      cursorColor: primary,
      autofocus: !widget.obscureText,
      style: const TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
    ));
  }
}
