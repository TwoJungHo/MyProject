import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "layout Test",
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
            width: 100,
            height: 100,
            color: Colors.red,
            child: Text("data"),
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.green,
            padding: EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 10.0
            ),
            child: Text("data"),
          ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              padding: EdgeInsets.all(30),
              child: Text("data"),
            )
          ],
        ),
      )),
    );
  }
}
