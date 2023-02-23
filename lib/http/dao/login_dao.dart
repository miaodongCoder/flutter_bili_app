import 'package:flutter_bili_app/http/core/hi_net.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';
import 'package:flutter_bili_app/http/request/login_request.dart';
import 'package:flutter_bili_app/http/request/registration_request.dart';

/// 与服务端通信 , 数据交互和持久化的操作都放在 DAO 层:
class LoginDao {
  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password,
      {dynamic imoocId, dynamic orderId}) async {
    BaseRequest request;
    // 注册:
    if (imoocId == null && orderId == null) {
      request = RegistrationRequest();
    }
    // 登录:
    else {
      request = LoginRequest();
    }
    // 为 request 添加参数:
    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId)
        .add("orderId", orderId);
    var result = await HiNet.getInstance().fire(request);
    print("login_dao: $result");
    return result;
  }
}
