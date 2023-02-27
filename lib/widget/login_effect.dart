import 'package:flutter/material.dart';

/// 顶部卡通人物睁眼蒙眼的登录动效:
class LoginEffect extends StatefulWidget {
  final bool protect;
  const LoginEffect({Key? key, required this.protect}) : super(key: key);

  @override
  State<LoginEffect> createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧图片:
          _image(true),
          // 中间图片:
          const Image(
            width: 90,
            height: 90,
            image: AssetImage('images/logo.png'),
          ),
          // 右侧图片:
          _image(false),
        ],
      ),
    );
  }

  _image(bool left) {
    var headLeft = widget.protect ? 'images/head_left_protect.png' : 'images/head_left.png';
    var headRight = widget.protect ? 'images/head_right_protect.png' : 'images/head_right.png';
    return Image(
      height: 90,
      image: AssetImage(left ? headLeft : headRight),
    );
  }
}
