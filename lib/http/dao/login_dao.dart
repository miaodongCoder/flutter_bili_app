// ignore_for_file: constant_identifier_names, avoid_print

import 'package:flutter_bili_app/db/hi_cache.dart';
import 'package:flutter_bili_app/http/core/hi_net.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';
import 'package:flutter_bili_app/http/request/login_request.dart';
import 'package:flutter_bili_app/http/request/registration_request.dart';

/// 与服务端通信 , 数据交互和持久化的操作都放在 DAO 层:
class LoginDao {
  static const BOARDING_PASS = "boarding-pass";

  static login(String userName, String password) async {
    return await _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) async {
    return await _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password,
      {dynamic imoocId, dynamic orderId}) async {
    BaseRequest request;
    // 保存登录令牌到本地:
    var cache = HiCache.getInstance();
    // 注册:
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
      request.add("imoocId", imoocId).add("orderId", orderId);
    }
    // 登录:
    else {
      request = LoginRequest();
    }
    // 为 request 添加参数:
    request.add("userName", userName).add("password", password);
    var result = await HiNet.getInstance().fire(request);
    print("login_dao: $result");
    // 登录成功:
    if (result['code'] == 0 && result['data'] != null) {
      if (cache?.prefs == null) {
        HiCache.preInit();
      }
      cache?.setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  static String? getBoardingPass() {
    var cache = HiCache.getInstance();
    String? pass = cache.get(BOARDING_PASS);
    return pass;
  }
}
