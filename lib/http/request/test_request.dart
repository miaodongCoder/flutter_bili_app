import 'package:flutter_bili_app/http/request/base_request.dart';

class TestRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "uapi/test/test";
  }

  // 请求配置完成后 , 想发送请求要借助hi_net框架来发送请求:
}
