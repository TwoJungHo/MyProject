import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myflutterproject/SignUp.dart';
import 'package:myflutterproject/User.dart';
import 'package:myflutterproject/UserDTO.dart';
import 'package:myflutterproject/UserProvider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false; // 로딩 상태를 나타냄

  String _id = ""; // _idController를 통해 아이디 입력 필드와 연결
  final TextEditingController _idController = TextEditingController();

  String _pass = "";
  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    // 위젯이 처음 생성될 때 호출
    super.initState();
    _idController.text = _id; // 입력 필드 초기값 설정
    _passController.text = _pass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[400],
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        elevation: 0,
        title: Text(''),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.minimize),
          ),
          IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:
        SingleChildScrollView(
          // 자식 위젯의 내용이 화면에 맞지 않을 때 스크롤을 추가하여 내용을 스크롤할 수 있게 해줌
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/캡처.png',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: "아이디",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _passController,
                decoration: InputDecoration(
                  labelText: "비밀번호",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  primary: Colors.brown,
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          "로그인",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 210,
              ),
              GestureDetector(
                // onTap 감지
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text(
                  "회원가입 페이지로",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true; // 로딩중임을 표시
    });

    _id = _idController.text; // 입력필드에서 입력된 값 변수에 할당
    _pass = _passController.text;

    String url = "http://10.0.2.2:9000/user/login"; // 로그인 엔드포인트

    Map<String, String> body = {"loginId": _id, "password": _pass};

    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body));

    try {
      if (response.statusCode / 100 == 2) {
        Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

        final user = User(
          loginId: data['result']['loginId'].toString(),
          username: data['result']['loginId'].toString(),
          phoneNumber: data['result']['phoneNumber'].toString(),
          nickname: data['result']['nickname'].toString(),
        );
        Provider.of<UserProvider>(context, listen: false).setUser(user);
      }
    } catch (e) {
      print("로그인 실패");
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false; // 로딩 상태 해제
      });
    }
  }
}
