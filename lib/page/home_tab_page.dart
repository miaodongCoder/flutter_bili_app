// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/widget/hi_banner.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  final List<BannerMo>? bannerList;

  const HomeTabPage({Key? key, required this.name, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          // 这个叫 if collection 语法:
          if (widget.bannerList != null) _banner()
        ],
      ),
    );
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(
        widget.bannerList!,
        bannerHeight: 160,
        padding: const EdgeInsets.all(4),
      ),
    );
  }
}
