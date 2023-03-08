// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter_bili_app/http/core/hi_adapter.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

class DioAdapter extends HiNetAdapter {
  Future<HiNetResponse<T>> buildRes<T>(
      Response? response, BaseRequest request) {
    return Future.value(HiNetResponse(
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }

  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response;
    var options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), options: options, data: request.params);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), options: options, data: request.params);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      // 抛出 HiNetError 异常:
      throw (HiNetError(response.statusCode, error.toString(),
          data: await buildRes(response, request)));
    }
    return await buildRes(response, request);
  }
}
