import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SCR ex",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: MyHomePage(msg: "값을 넣을수 있음"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.msg}) : super(key: key);
  final String msg;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1";
  bool _isLoading = false;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    loadingData();
  }

  void loadingData() async{

    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    var response = await dio.get(url);

    if(response.statusCode == 200){
      print(response.data);
      data = response.data;
      print(data["coord"]["lon"]);
      print(data["coord"]["lat"]);
      print(data["weather"][0]);
    }else{
      print("통신실패");
    }

    setState(() {
      _isLoading = false;
    });

  }

  void loadData2() async{
    setState(() {
      _isLoading = true;
    });

      var response = await http.get(Uri.parse(url),
          // headers:{
          //   "Content-Type" : "application/json"
          // }
          );

      if(response.statusCode == 200){
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        print(data);
        setState(() {


          _isLoading = false;
        });

      }else{
        print("통신실패");
      }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.msg),
      ),
      body: Column(
        children: [
          _isLoading? CircularProgressIndicator()
              : Text(data["coord"]["lon"].toString()),
          _isLoading? CircularProgressIndicator()
              : Text(data["coord"]["lat"].toString())
        ],
      ),
    );
  }
}

