import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

void flutterToast(String msg){
  Fluttertoast.showToast(
     msg: msg,
     gravity: ToastGravity.CENTER,
     backgroundColor: Colors.red,
    fontSize: 16,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_LONG
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Simple App 3",
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[400],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Simple App 3_ 1page"),
        elevation: 5.0,
        backgroundColor: Colors.amber[700],
        actions: [
          IconButton(onPressed: (){
            debugPrint("검색 클릭");
            log("검색합니다.", name: "search");
            flutterToast("검색하기");
          }, icon: const Icon(Icons.search)
          ),
          IconButton(
              onPressed: (){
                debugPrint("장바구니 보기");
                log("장바구니", name: "cart");
                flutterToast("장바구니보기");
              },
              icon: const Icon(Icons.shopping_cart)
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: const Text("개썐 도지"),
                accountEmail: const Text("qwer4667@naver.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: const AssetImage("assets/test2.png"),
                backgroundColor: Colors.amber[50],
              ),
              otherAccountsPictures: const [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/test1.gif"),
                  backgroundColor: Colors.transparent,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/test2.png"),
                  backgroundColor: Colors.transparent,
                )
              ],
              onDetailsPressed: () {
                debugPrint("자세히 보기가 클릭됨");
                log("자세히 보기가 클릭", name: "test");
              },
              decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(30.0),
                )
                )
              ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text("Home"),
              onTap: () {
                debugPrint("come back home");
                log("집으로가기", name: "home");
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text("설정"),
              onTap: () {
                debugPrint("환경설정");
                log("환경설정입니다", name: "settings");
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.question_answer,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text("Q&A"),
              onTap: () {
                debugPrint("질문하기");
                log("질문하러가기", name: "qna");
              },
              trailing: const Icon(
                Icons.add,
                color: Colors.blue,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
