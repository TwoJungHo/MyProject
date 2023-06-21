import 'package:flutter/material.dart';
import 'package:sqfliteex/myhomepage.dart';
import 'package:sqfliteex/sqldatabase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "sqflite ex",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: MyHomePage(),
    );
  }
}