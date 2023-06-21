import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blue
      ),
      home: INEx(),
    );
  }
}

class INEx extends StatefulWidget {
  const INEx({Key? key}) : super(key: key);

  @override
  State<INEx> createState() => _INExState();
}

class _INExState extends State<INEx> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("image.network(url)"),
      ),
      body: SizedBox(
        height: 150,
        width: double.infinity,
        child: Card(
          child: Image.network(
            "https://picsum.photos/250?image=12",
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
