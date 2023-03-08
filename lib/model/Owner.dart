// 手写的方式 JSON 转模型:
// ignore_for_file: file_names

class Owner {
  String? name;
  String? face;
  int? fans;

  Owner({this.name, this.face, this.fans});

  // 命名构造方法:
  // json 转模型:
  Owner.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    face = json["face"];
    fans = json["fans"];
  }

  // 模型转 JSON:
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json["name"] = name;
    json["face"] = face;
    json["fans"] = fans;
    return json;
  }
}
