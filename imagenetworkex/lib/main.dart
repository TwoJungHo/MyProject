import 'package:flutter/material.dart';
import 'package:imagenetworkex/image_widget.dart';

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
        title: Text("슬리버와 그리드뷰"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("슬리버"),
            backgroundColor: Colors.amber[300],
            expandedHeight: 200,
            leading: Icon(Icons.arrow_back),
            actions: [
              Icon(Icons.settings),
              SizedBox(
                width: 15,
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/test2.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3
                ),
                itemCount: 20,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return ImageWidget(
                  index: index,
                  );
                }),
          )
        ],
      ),
    );
  }
}