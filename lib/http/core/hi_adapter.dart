import 'dart:convert';

import 'package:flutter_bili_app/http/request/base_request.dart';

/// 网络请求抽象类:
abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

/// 异常的网络返回格式处理:
class HiNetResponse<T> {
  T data;
  BaseRequest request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  HiNetResponse({required this.data, required this.request, this.statusCode, this.statusMessage, this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
