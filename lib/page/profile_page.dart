// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api

import 'package:flutter/material.dart';

///我的
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('我的'),
      ),
    );
  }
}
