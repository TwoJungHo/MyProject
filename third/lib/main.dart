import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "third App",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Page"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("1111111111111",
              style: TextStyle(backgroundColor: Colors.black,
              color: Colors.blue,
              fontSize: 45),
            ),
            Text("555555555555",
              style: TextStyle(backgroundColor: Colors.black,
                  color: Colors.blue,
                  fontSize: 45),
            ),
            Text("2222222222222"),
            Text("3333333333333"),
          ],
        ),
      ),
    );
  }
}
