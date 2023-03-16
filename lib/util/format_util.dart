/// 数字转万:
String countFormat(int count) {
  if (count > 9999) {
    return "${(count / 10000).toStringAsFixed(2)}万";
  }

  return count.toString();
}

/// 时间转换: 将秒转换为 XX 分: XX 秒:
String durationTransform(int second) {
  // 分钟数:
  int minutes = (second / 60).truncate();
  // 剩余的秒数:
  int leftSecond = second - minutes * 60;
  // 小于 10 秒补充十位:
  if (leftSecond < 10) {
    return "$minutes:0$leftSecond";
  }
  return "$minutes:$leftSecond";
}
