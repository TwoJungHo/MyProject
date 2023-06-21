import 'package:flutter/material.dart';
import 'package:navigatorex1/MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Navigator1",
      home: MyHomePage("main page"),
      debugShowCheckedModeBanner: false,
    );
  }
}



