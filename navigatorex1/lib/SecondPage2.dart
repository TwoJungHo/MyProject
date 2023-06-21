import 'package:flutter/material.dart';

class SecondPage2 extends StatelessWidget {
  const SecondPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("second page"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("이전페이지로가기"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}