import 'package:flutter/material.dart';
import 'package:textfieldex/InsertPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "textField test",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _isLoading = false;

  String _id = "";
  String _password = "";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("첫 페이지"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Image.asset(
                "assets/test1.gif",
                height: 200.0,
                width: 100,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: "Id", border: OutlineInputBorder()),
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "PW", border: OutlineInputBorder()),
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child:
                      _isLoading ? CircularProgressIndicator() : Text("로그인")),
              Text("Id : " + _id),
              Text("PW : " + _password),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InsertPage(),
                        ));
                  },
                  child: Text("회원가입"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    _id = _nameController.text;
    _password = _passwordController.text;

    String url = "http://10.0.2.2:8000/user-service/login";
    Map<String, String> body = {"username": _id, "password": _password};

    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body));

    try {

      if(response.statusCode != 201 && response.statusCode != 200){
        throw Exception();
      }

      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      print("==================================================");

      print(data);
      print(data['result']);
      print(data['result']['username']);

      print("==================================================");

      _nameController.text = "";
      _passwordController.text = "";
      print("로그인성공");
    } catch (e) {
      print("로그인실패");
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
