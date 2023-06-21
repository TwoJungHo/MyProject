import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final int type = 0;
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == 0) {
      return MaterialApp(
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
    }

    return MaterialApp(
      home: OnBoardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => OnBoardingPage())
            );
          }, icon: Icon(Icons.arrow_back_ios_new)
          ),

          IconButton(onPressed: () {

          }, icon: Icon(Icons.add)
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text("Main Page Here", style: TextStyle(fontSize: 40),)
          ],
        ),
      ),
    );
  }
}


class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      dotsDecorator: DotsDecorator(
        size: Size(20, 20),
        color: Colors.black,
        activeColor: Colors.grey,
        activeSize: Size(30, 20),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
      ),
      done: Text("그만보기"),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=> MyHomePage())
        );
      },
      next: Icon(Icons.arrow_forward),
      showSkipButton: true,
      skip: Text("skip"),
      pages: [
        PageViewModel(
          image: Image.asset("image/test1.jpg"),
          title: "1 page",
          body: "1 page의 body",
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "2 page",
          body: "2 page의 body",
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "3 page",
          body: "3 page의 body",
          decoration: getPageDecoration(),
        )
      ],
    );
  }

  PageDecoration getPageDecoration(){
    return PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),
      bodyTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.green
      ),
      pageColor: Colors.amber[200],
      imagePadding: EdgeInsets.only(top: 40)
    );
  }
}

