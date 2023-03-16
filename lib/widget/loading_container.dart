import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingContainer extends StatelessWidget {
  final bool isLoading;
  // 加载动画是否覆盖在原来的界面之上:
  final bool cover;
  final Widget child;
  const LoadingContainer(
      {Key? key,
      this.isLoading = false,
      this.cover = false,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [
          child,
          isLoading ? _loadView() : Container(),
        ],
      );
    }

    return isLoading ? _loadView() : child;
  }

  /// lottie动画:
  _loadView() {
    return Center(
      child: Lottie.asset('assets/loading.json'),
    );
  }
}
