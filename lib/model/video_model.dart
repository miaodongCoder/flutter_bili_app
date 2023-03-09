// ignore_for_file: unnecessary_null_comparison

class VideoModel {
  late String id;
  late String vid;
  late String title;
  late String tname;
  String? url;
  late String cover;
  late int pubdate;
  late String desc;
  late int view;
  late int duration;
  late Owner owner;
  late int reply;
  late int favorite;
  late int like;
  late int coin;
  late int share;
  late String createTime;
  late int size;

  VideoModel({required this.vid});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vid = json['vid'];
    title = json['title'];
    tname = json['tname'];
    url = json['url'];
    cover = json['cover'];
    pubdate = json['pubdate'];
    desc = json['desc'];
    view = json['view'];
    duration = json['duration'];
    owner = Owner.fromJson(json['owner']);
    reply = json['reply'];
    favorite = json['favorite'];
    like = json['like'];
    coin = json['coin'];
    share = json['share'];
    createTime = json['createTime'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vid'] = vid;
    data['title'] = title;
    data['tname'] = tname;
    data['url'] = url;
    data['cover'] = cover;
    data['pubdate'] = pubdate;
    data['desc'] = desc;
    data['view'] = view;
    data['duration'] = duration;
    if (owner != null) {
      data['owner'] = owner.toJson();
    }
    data['reply'] = reply;
    data['favorite'] = favorite;
    data['like'] = like;
    data['coin'] = coin;
    data['share'] = share;
    data['createTime'] = createTime;
    data['size'] = size;
    return data;
  }
}

class Owner {
  late String name;
  late String face;
  late int fans;

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['face'] = face;
    data['fans'] = fans;
    return data;
  }
}
