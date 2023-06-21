import 'package:flutter/material.dart';
import 'package:navigatorex1/SecondPage2.dart';

class MyHomePage extends StatelessWidget {
  final String title_name;
  const MyHomePage(this.title_name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title_name),
        ),
        body: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage2()));
          },
          child: Text("세컨드 페이지로 이동"),
        )
    );
  }
}
