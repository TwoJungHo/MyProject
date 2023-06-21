import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "layout",
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
    //        child: Center(
      child: Row(
    //    mainAxisSize: MainAxisSize.min,
    //    mainAxisAlignment: MainAxisAlignment.center,
    //    verticalDirection: VerticalDirection.up,
    //    verticalDirection: VerticalDirection.down,    //default값
    //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //    crossAxisAlignment: CrossAxisAlignment.end,
    //    crossAxisAlignment: CrossAxisAlignment.start,
    //    crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            width: 100,
            height: 100,
            color: Colors.red,
            child: Text("data"),
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.green,
            child: Text("data"),
          ),
          SizedBox(
            width: 20.0,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            child: Text("data"),
          ),
        ],
      ),
    //)
        )
    );
  }
}
