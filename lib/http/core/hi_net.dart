import 'package:flutter_bili_app/http/request/base_request.dart';

class HiNet {
  HiNet._();
  static HiNet _instance = HiNet._();
  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance;
  }

  Future fire(BaseRequest request) async {
    var response = await send(request);
    var result = response['data'];
    printLog(result);
    return result;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url: ${request.url()}');
    printLog('method: ${request.httpMethod()}');
    request.addHeader("token", "abc");
    printLog('header: ${request.header}');
    return Future.value({
      "statusCode": 200,
      "data": {"code": 0, "msg": "SUCCESS"}
    });
  }

  void printLog(log) {
    print('hi_net: ${log.toString()}');
  }
}
