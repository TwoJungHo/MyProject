import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "containerex",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: Colors.blue,
            width: 100,
            height: 100,
            //margin: EdgeInsets.fromLTRB(20.0, 50.0, 50.0, 100.0),
            margin: EdgeInsets.symmetric(
              vertical: 50.0, horizontal: 50.0
            ),
            padding: EdgeInsets.all(20),
            child: Text("1111111111111")),
      ),
    );
  }
}
