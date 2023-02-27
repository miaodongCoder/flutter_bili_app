import 'package:flutter/material.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/login_effect.dart';
import 'package:flutter_bili_app/widget/login_widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        print("右侧按钮的点击");
      }),
      body: Container(child: ListView(
        children: [
          LoginEffect(protect: protect),
          LoginInput(
            "用户名",
            "请输入用户名",
            onChange: (String text) {
              print("用户名: $text");
            },
            focusChange: (bool focus) {
              print("用户名聚焦了!");
            },
          ),
          LoginInput(
            "密码",
            "请输入用密码",
            obscureText: true,
            lineStretch: false,
            onChange: (String text) {
              print("密码: $text");
            },
            focusChange: (bool focus) {
              print("密码聚焦了!");
              setState(() {
                protect = focus;
              });
            },
          )
        ],
      ),),
    );
  }
}
