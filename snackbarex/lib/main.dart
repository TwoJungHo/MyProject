import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Snack Bar",
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Snack Bar"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("여기에 스낵바 예정");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Snack Bar가 보이십니까?"),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
          ));
        },
        child: Icon(Icons.add),
      ),
      body: BodyPage(),
    );
  }
}

class BodyPage extends StatelessWidget {
  const BodyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("이게 보여?"),
              duration: Duration(seconds: 5),
              //backgroundColor: Colors.red,
              action: SnackBarAction(
                  onPressed: () {
                    debugPrint("취소되었습니다");
                  },
                  label: "취소"),
            ));
          },
          child: Text("TextButton을 클릭"),
          style: TextButton.styleFrom(
              backgroundColor: Colors.blue, elevation: 2.0),
        )
      ],
    );
  }
}
