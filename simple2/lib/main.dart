import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "simple App 2",
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
      backgroundColor: Colors.amber[700],
      appBar: AppBar(
        title: const Text("Simple App 2 Page"),
        backgroundColor: Colors.amber[700],
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: const AssetImage("asset/test1.gif"),
                backgroundColor: Colors.amber[100],
              ),
                accountName: const Text("홍길동"), accountEmail: const Text("a@a.com"),
              otherAccountsPictures: const [
                CircleAvatar(
                  backgroundImage: AssetImage("asset/test1.gif"),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("asset/test2.png"),
                )
              ],
              onDetailsPressed: () {
                print("클릭 되었음");
              },
              decoration: BoxDecoration(
                color: Colors.red[300],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
                )
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue,),
              title: Text("Home"),
              onTap: (){
                print("페페가 눌러짐");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,color: Colors.grey,),
              title: Text("설정"),
              onTap: (){
                print("설정이 눌러졌음");
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer, color: Colors.blue,),
              title: Text("Q&A"),
              onTap: (){
                print("Q&A등록");
              },
              trailing: Icon(Icons.add, color: Colors.blue,),
            ),


          ],
        ),
      ),
      body: SingleChildScrollView(
    child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("asset/test1.gif"),
                backgroundColor: Colors.transparent,
                radius: 40.0,
              ),
            ),
            const Divider(
              height: 60.0,
              color: Colors.teal,
              thickness: 5.5,
            ),
            const Text(
              "test1.gif 파일",
              style: TextStyle(
                  color: Colors.white, fontSize: 25, letterSpacing: 2.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "아이엠...............PEPE",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                Text(
                  "준비운동하기",
                  style: TextStyle(
                      color: Colors.green, fontSize: 25, letterSpacing: 5.0),
                )
              ],
            ),
            const Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                Text(
                  "수영하기",
                  style: TextStyle(
                      color: Colors.green, fontSize: 25, letterSpacing: 5.0),
                )
              ],
            ),
            const Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                Text(
                  "뒷정리하기",
                  style: TextStyle(
                      color: Colors.green, fontSize: 25, letterSpacing: 5.0),
                )
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("asset/test2.png"),
                backgroundColor: Colors.transparent,
                radius: 40.0,
              ),
            ),
            const Image(
              image: AssetImage("asset/test1.gif"),
              width: 100,
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
               padding: EdgeInsets.all(50)
              ),
                onPressed: () {
                  print("pepepepepepepepepepe");
                },
                child: const Image(
                  image: AssetImage("asset/test1.gif"),
                  width: 200,
                  height: 200,
                ))
          ],
        ),
      ),
    ),
    );
  }
}
