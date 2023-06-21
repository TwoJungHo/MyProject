import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InsertPage extends StatefulWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  bool _isLoading = false;

  TextEditingController _IdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String _id = "";
  String _password = "";
  String _password2 = "";
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입페이지"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: "Name", border: OutlineInputBorder()),
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _IdController,
                decoration: InputDecoration(
                    labelText: "Id", border: OutlineInputBorder()),
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: "Pw", border: OutlineInputBorder()),
                obscureText: true,
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _passwordController2,
                decoration: InputDecoration(
                    labelText: "Pw2", border: OutlineInputBorder()),
                obscureText: true,
                style: TextStyle(fontSize: 20),
              ),
              Text("Name : " + "$_name"),
              Text("Id : " + "$_id"),
              Text("PW : " + "$_password"),
              Text("PW : " + "$_password2"),
              ElevatedButton(
                  onPressed: _isLoading ? null : _insert,
                  child:  _isLoading ? CircularProgressIndicator() : Text("회원가입"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _insert() async {
    setState(() {
      _isLoading = true;
    });

    _id = _IdController.text;
    _password = _passwordController.text;
    _password2 = _passwordController2.text;
    _name = _nameController.text;

    String url = "http://10.0.2.2:8000/user-service/users";
    Map<String, String> body = {
      "username": _id!,
      "name": _name!,
      "password": _password!,
      "password2": _password2!
    };

    final res = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));

    try {
      Map<String, dynamic> data = jsonDecode(utf8.decode(res.bodyBytes));

      print(data);
      print("가입성공");

      _nameController.text = "";
      _IdController.text = "";
      _passwordController.text = "";
      _passwordController2.text = "";
    } catch (e) {
      print("가입실패");
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
