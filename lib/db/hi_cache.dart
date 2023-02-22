import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  SharedPreferences? prefs;
  static HiCache? _instance;

  HiCache._() {
    init();
  }

  static HiCache? getInstance() {
    _instance ??= HiCache._();
    return _instance;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  // 预处理:
  static Future<HiCache> preInit() async {
    // 如果当前缓存对象为空就重新初始化拿到第三方缓存对象并赋值给当前对象的属性后再去返回当前对象:
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return Future.value(_instance);
  }

  HiCache._pre(SharedPreferences preferences) {
    prefs = preferences;
    // prefs.setString(key, value)
  }

  // 那些同名的赋值方法:
  Future<bool>? setString(String key, String value) =>
      prefs?.setString(key, value);
  Future<bool>? setDouble(String key, double value) =>
      prefs?.setDouble(key, value);
  Future<bool>? setInt(String key, int value) => prefs?.setInt(key, value);
  Future<bool>? setBool(String key, bool value) => prefs?.setBool(key, value);
  Future<bool>? setStringList(String key, List<String> value) =>
      prefs?.setStringList(key, value);
  Future<bool>? remove(String key) => prefs?.remove(key);
  T? get<T>(String key) {
    var result = prefs?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }
}
