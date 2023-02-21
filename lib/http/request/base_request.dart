enum HttpMethod { GET, POST, DELETE }

/// 基础请求:
abstract class BaseRequest {
  // curl -X GET "https://api.devio.org/uapi/test/test?requestPrams=ddd" -H "accept: */*" -H "course-flag: ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa"

  var pathParams;
  var useHttps = true;
  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    // http和https切换:
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    if (needLogin()) {
      // 给需要登录页的接口携带登录令牌:
    }

    print('url: ${uri.toString()}');

    return uri.toString();
  }

  bool needLogin();

  // 拼接的参数:
  Map<String, String> params = {};

  BaseRequest add(String key, Object value) {
    params[key] = value.toString();
    return this;
  }

  // 鉴权:
  Map<String, dynamic> header = {'course-flag': 'ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa', 'auth-token': '课程首页获取的auth-token', 'boarding-pass': '登录成功返回的boarding-pass'};

  BaseRequest addHeader(String key, dynamic value) {
    params[key] = value.toString();
    return this;
  }
}
