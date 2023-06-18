import 'package:flutter/material.dart';
import 'package:kakaomessage/project.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "project",
      debugShowCheckedModeBanner: false,
      home: Project(),
    );
  }
}
