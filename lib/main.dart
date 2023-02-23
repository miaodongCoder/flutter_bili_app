import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/db/hi_cache.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/core/hi_net.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/http/request/login_request.dart';
import 'package:flutter_bili_app/http/request/test_request.dart';
import 'package:flutter_bili_app/model/Owner.dart';
import 'package:flutter_bili_app/model/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() async {
    testLogin();
    setState(() {
      _counter++;
    });
  }

  void test() {
    var ownerMap = {
      "name": "名称!",
      "face": "https://coding.imooc.com/class/487.html",
      "fans": 0
    };

    Owner owner = Owner.fromJson(ownerMap);
    print('${owner.name} , ${owner.face} , ${owner.fans}');

    var resultJson = {
      "code": 0,
      "method": "GET",
      "requestPrams": "requestPrams"
    };
    Result result = Result.fromJson(resultJson);
    print("result = $result");
  }

  void testLogin() async {
    try {
      var register = await LoginDao.registration("222", "222", "3926757", "8902");
      print("main- 注册 $register");
      // var login = await LoginDao.login("111", "111");
      // print(login);
    } on NeedLogin catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }
}
