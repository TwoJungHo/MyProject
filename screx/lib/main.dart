import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

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

  bool isLoading = false;
  double lat = 0.0;
  double lon = 0.0;


  void loadingData() async{
    setState(() {
      isLoading = true;
    });
    try{
      Position pos = await _determinePosition();

      lat = pos.latitude;
      lon = pos.longitude;
    }catch(e){
      print(e.toString());
      print("데이터 로딩 실패");
    }finally{
      setState(() {
        isLoading = false;
      });
    }


  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.msg),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed:
            loadingData
          , child: Text("눌러보세요~")),
          isLoading? CircularProgressIndicator():Text(lon.toString()),
          isLoading? CircularProgressIndicator():Text(lat.toString()),
        ],
      ),
    );
  }
}

