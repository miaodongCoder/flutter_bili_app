/// 网络异常统一格式类:
class HiNetError {
  final int? code;
  final String message;
  final dynamic data;
  HiNetError(this.code, this.message, {this.data});
}

/// 授权异常:
class NeedAuthor extends HiNetError {
  NeedAuthor(String message, {int code = 403, dynamic data}) : super(code, message, data: data);
}

/// 登录异常:
class NeedLogin extends HiNetError {
  NeedLogin({int code = 401, String message = "需要登录"}) : super(code, message);
}
