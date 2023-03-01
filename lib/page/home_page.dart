import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/video_model.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel>? onJumpToDetail;

  const HomePage({Key? key, this.onJumpToDetail}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            const Text("首页"),
            // 点击跳转详情页:
            MaterialButton(
              child: const Text("详情按钮"),
              onPressed: () => widget.onJumpToDetail!(VideoModel(111)),
            ),
          ],
        ),
      ),
    );
  }
}
