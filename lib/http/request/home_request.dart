import 'package:flutter_bili_app/http/request/base_request.dart';

class HomeRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() => HttpMethod.GET;

  @override
  bool needLogin() => true;

  @override
  String path() => 'uapi/fa/home';
}
