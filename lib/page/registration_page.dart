import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/util/string_util.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/login_button.dart';
import 'package:flutter_bili_app/widget/login_effect.dart';
import 'package:flutter_bili_app/widget/login_widget.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback? onJumpLogin;
  const RegistrationPage({Key? key, this.onJumpLogin})
      : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;
  String? imoocId;
  String? orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        print("右侧按钮的点击");
        if (widget.onJumpLogin != null) {
          widget.onJumpLogin!();
        }
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChange: (String userName) {
                this.userName = userName;
                checkInput();
              },
              focusChange: (bool focus) {
                print("用户名聚焦了!");
              },
            ),
            LoginInput(
              "密码",
              "请输入用密码",
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
            LoginInput(
              "确认密码",
              "请再次输入用密码",
              obscureText: true,
              onChange: (String rePassword) {
                this.rePassword = rePassword;
                checkInput();
              },
              focusChange: (bool focus) {
                print("再次输入密码 - 聚焦了!");
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              "慕课网ID",
              "请输入您的慕课网ID",
              keyboardType: TextInputType.number,
              onChange: (String imoocId) {
                this.imoocId = imoocId;
                checkInput();
              },
              focusChange: (bool focus) {
                print("慕课网ID - 聚焦了!");
              },
            ),
            LoginInput(
              "订单号",
              "请输入您的订单号后四位",
              keyboardType: TextInputType.number,
              onChange: (String orderId) {
                this.orderId = orderId;
                checkInput();
              },
              focusChange: (bool focus) {
                print("订单号 - 聚焦了!");
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(
                "注册",
                enable: loginEnable,
                onPress: () {
                  if (loginEnable) {
                    checkParams();
                  } else {
                    showWarnToast("无法点击登陆 因为: loginEnable = $loginEnable");
                  }
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
    if (userName == null ||
        password == null ||
        rePassword == null ||
        imoocId == null ||
        orderId == null) return;

    if (isNotEmpty(userName!) &&
        isNotEmpty(password!) &&
        isNotEmpty(rePassword!) &&
        isNotEmpty(imoocId!) &&
        isNotEmpty(orderId!)) {
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
      var result =
          await LoginDao.registration(userName!, password!, imoocId!, orderId!);
      print('result = $result');
      if (result['code'] == 0) {
        showToast('注册成功!');
        if (widget.onJumpLogin != null) {
          widget.onJumpLogin!();
        }
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedAuthor catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致!';
    } else if (orderId!.length != 4) {
      tips = '请输入订单号后四位!';
    }
    if (tips != null) {
      showWarnToast(tips);
      return;
    }
    // 发送登录请求:
    send();
  }
}
