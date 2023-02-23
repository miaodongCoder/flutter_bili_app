import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String> onChange;
  final ValueChanged<bool> focusChange;
  final bool lineStretch;
  final bool obscureText; // 密码输入(模糊文字)
  final TextInputType keyboardType;

  const LoginInput({
    Key? key,
    this.title = "",
    required this.hint,
    required this.onChange,
    required this.focusChange,
    this.lineStretch = false,
    this.obscureText = false,
    required this.keyboardType,
  }) : super(key: key);

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
