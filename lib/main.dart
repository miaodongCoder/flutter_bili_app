import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/core/hi_net.dart';
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

  void _incrementCounter() async {
    TestRequest request = TestRequest();
    request
        .add("keyaaa", "aaa")
        .add("keybbb", "bbb")
        .add("requestPrams", "kkk");
    try {
      var response = await HiNet.getInstance().fire(request);
      print('main: $response');
    } on NeedAuthor catch (e) {
      print(e);
    } on NeedLogin catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }

    setState(() {
      _counter++;
      test();
    });
  }

  void test() {
    // const jsonString = "{ \"name\": \"flutter\", \"url\": \"https://coding.imooc.com/class/487.html\" }";
    // // JSON 转 Map:
    // Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    // print('name: ${jsonMap["name"]}');
    // print('url: ${jsonMap["url"]}');
    // // Map 转 JSON:
    // String json = jsonEncode(jsonMap);
    // print("json: $json");

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
}
