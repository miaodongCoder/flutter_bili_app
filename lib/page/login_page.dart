import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/navigator/hi_navigator.dart';
import 'package:flutter_bili_app/util/string_util.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/login_button.dart';
import 'package:flutter_bili_app/widget/login_effect.dart';
import 'package:flutter_bili_app/widget/login_widget.dart';

/// 登录页面:
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key})
      : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        "密码登录",
        "注册",
        () {
          HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
        },
      ),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(
              protect: protect,
            ),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChange: (String userName) {
                this.userName = userName;
                checkInput();
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              obscureText: true,
              onChange: (String password) {
                this.password = password;
                checkInput();
              },
              focusChange: (bool focus) {
                print("密码 - 聚焦了!");
                setState(() {
                  // 卡通人物闭眼:
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: LoginButton(
                "登录",
                enable: loginEnable,
                onPress: () {
                  send();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (userName == null || password == null) return;

    if (isNotEmpty(userName!) && isNotEmpty(password!)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result = await LoginDao.login(userName!, password!);
      print('result = $result');
      if (result['code'] == 0) {
        showToast("登录成功!");
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedAuthor catch (e) {
      print('NeedAuthor: $e');
    } on HiNetError catch (e) {
      print('HiNetError: $e');
    }
  }
}
