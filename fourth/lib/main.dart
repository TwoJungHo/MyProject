import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "fourth App",
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const MyhomePage(),
    );
  }
}

class MyhomePage extends StatelessWidget {
  const MyhomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      appBar: AppBar(
        title: const Text("이게 세번째 만듬"),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.lightBlueAccent[50],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "첫번째줄",
              style: TextStyle(fontSize: 50),
            ),
            Text(
              "두번째 안녕",
              style: TextStyle(color: Colors.orange, fontSize: 50),
            ),
            Text(
              "세번째 안녕",
              style: TextStyle(color: Colors.amber, fontSize: 50),
            )
          ],
        ),
      ),
    );
  }
}
