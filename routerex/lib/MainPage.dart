import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("메인 페이지"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, "/home");
            }, child: Text("To home")),
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, "/settings");
            }, child: Text("To Settings"))
          ],
        ),
      ),
    );
  }
}