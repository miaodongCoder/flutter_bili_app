import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StatusBarStyle { LIGHT_CONTENT, DARK_CONTENT }

/// 带缓存的image的公共方法:
Widget cachedImage(String imageUrl, {double? width, double? height}) {
  return CachedNetworkImage(
    width: width,
    height: height,
    fit: BoxFit.cover,
    placeholder: (BuildContext context, String url) =>
        Container(color: Colors.grey[200]),
    errorWidget: (BuildContext context, String url, dynamic error) =>
        const Icon(Icons.error),
    imageUrl: imageUrl,
  );
}

blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
    begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
    end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
    colors: const [
      Colors.black54,
      Colors.black45,
      Colors.black38,
      Colors.black26,
      Colors.black12,
      Colors.transparent,
    ],
  );
}

void changeStatusBar(
    {color = Colors.white,
    StatusBarStyle statusBarStyle = StatusBarStyle.DARK_CONTENT,
    BuildContext? context}) {
  // 沉浸式的状态栏:
  Brightness brightness = Brightness.dark;
  if (Platform.isIOS) {
    brightness = (statusBarStyle == StatusBarStyle.LIGHT_CONTENT)
        ? Brightness.dark
        : Brightness.light;
  } else {
    brightness = (statusBarStyle == StatusBarStyle.LIGHT_CONTENT)
        ? Brightness.light
        : Brightness.dark;
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ),
  );
}
