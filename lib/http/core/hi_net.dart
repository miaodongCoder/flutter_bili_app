import 'package:flutter_bili_app/http/core/dio_adapter.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';
import 'hi_adapter.dart';

class HiNet {
  HiNet._();
  static HiNet _instance = HiNet._();
  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = error.data;
    } catch (e) {
      error = e;
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;

    var statusCode = response?.statusCode;
    switch (statusCode) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuthor(result.toString(), data: result);
      default:
        throw HiNetError(statusCode, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    DioAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('hi_net: ${log.toString()}');
  }
}
