import 'package:flutter_bili_app/http/core/hi_adapter.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

/// 测试适配器 , mock数据:
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return HiNetResponse(data: {"code": 0, "data": "MockAdapter => Success!!!"} as T, request: request, statusCode: 200);
    });
  }
}
