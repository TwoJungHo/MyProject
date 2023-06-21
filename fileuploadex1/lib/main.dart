import 'package:flutter/material.dart';
import 'file_upload.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "파일업로드",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("파일 업로드"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: FileUPload.uploadFile
              ,
              child: Text("파일업로드"))
        ],
      ),
    );
  }
}



































