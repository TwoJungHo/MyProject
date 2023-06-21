import 'package:flutter/material.dart';
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
      home: ListViewPage(),
    );
  }
}

List<Catalog> catalogFromJson(String str) => List<Catalog>.from(json.decode(str).map((x) => Catalog.fromJson(x)));

String catalogToJson(List<Catalog> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Catalog {
  String productId;
  String productname;
  int stock;
  int unitPrice;
  DateTime createAt;

  Catalog({
    required this.productId,
    required this.productname,
    required this.stock,
    required this.unitPrice,
    required this.createAt,
  });

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
    productId: json["productId"],
    productname: json["productname"],
    stock: json["stock"],
    unitPrice: json["unitPrice"],
    createAt: DateTime.parse(json["createAt"]),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productname": productname,
    "stock": stock,
    "unitPrice": unitPrice,
    "createAt": createAt.toIso8601String(),
  };
}


class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  int page = 0;
  List<Catalog> values = [];
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();



  Future<void> loadData() async { //async 비동기로 하겠다고함 await있음
    if (!isLoading) {
      isLoading = true;
      String url = 'http://10.0.2.2:7000/catalog-service/catalogs/paging/${page}';
      final response = await http.get( //await : 통신이 끝날때까지 대기
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      List<dynamic> list = jsonDecode(utf8.decode(response.bodyBytes));

      List<Catalog> c_list = catalogFromJson(utf8.decode(response.bodyBytes));

      setState(() {
        c_list.forEach((catalog) {
          values.add(catalog);
        });
      });

      page++;

      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("main"),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: values.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(values[index].productname),
                  duration: Duration(seconds: 3),
                    backgroundColor: Colors.blue,
                  ));
            },
            child: ListTile(
              key: ValueKey(values[index]),
              title: Text(values[index].productname),
              subtitle: Text(values[index].productId),
            ),
          );
        },
      ),
    );
  }
}