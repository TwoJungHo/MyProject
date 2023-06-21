import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "stateful App",
      home: MyHomePage("ssss"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage(this.title, {Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _msg = "hello world";
  int _cnt = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _changeMsg();
          },
        ),
        body: Column(
          children: [
            Text(
              _msg,
              style: TextStyle(fontSize: 40),
            ),
            Text(
              "$_cnt",
              style: TextStyle(fontSize: 40),
            ),
            ElevatedButton(
                onPressed: _changecnt,
                child: Text("cnt증가"))
          ],
        ));
  }

  void _changeMsg() {
    if(_msg == "hello"){
      setState(() {
        _msg = "hi";
      });
    }
    else setState(() {
      _msg = "hello";
    });

  }

  void _changecnt(){
    setState(() {
      _cnt++;
    });
  }
}