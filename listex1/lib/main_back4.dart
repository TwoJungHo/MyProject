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
  List<String> ids = [];
  List<int> stocks = [];
  List<String> createAt = [];
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
          // ids.add(catalog["productId"]);
          stocks.add(catalog.stock);
          // createAt.add(catalog["createAt"]);
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
              showDialog(
                  context: context,
                  builder: (context){
                    return Dialog(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        height: MediaQuery.of(context).size.height*0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: Column(children: [
                          Text("품목, ${values[index].productname}"),
                          Text("품목id, ${values[index].productId}"),
                          Text("수량, ${stocks[index]}"),
                          Text("hello, $index"),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context)=> _UpdatePage("${values[index].productId}")
                                    ));
                              },
                              child: Text("수정화면으로 이동"))
                        ]),
                      ),
                    );
                  });
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

class _UpdatePage extends StatefulWidget {
  const _UpdatePage(this.productId, {Key? key}) : super(key: key);
  final String productId;

  @override
  State<_UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<_UpdatePage> {

  late Future<Catalog> futureCatalog;
  bool _isLoading = false;



  @override
  void initState() {
    futureCatalog = loadData();
  }

  Future<Catalog> loadData() async{
      _isLoading = true;
      String url = "http://10.0.2.2:7000/catalog-service/catalogs/${widget.productId}";

      final response = await http.get(Uri.parse(url),
      headers: {
        "Content-Type" : "application/json"
        //"Athorization" : "bearer ${token}"
      }
      );
      _isLoading = false;
      return Catalog.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("수정화면 : ${widget.productId}"),
      ),
      body: Center(
        child: Column(
          children: [
            // Future 타입의 데이터를 넣으려면, FutureBuilder 위젯을 사용함
            FutureBuilder<Catalog>(
              future: futureCatalog,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Text("물건번호 : ${snapshot.data!.productId}");
                  }else if(snapshot.hasError){
                   return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
            FutureBuilder<Catalog>(
                future: futureCatalog,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Text("물건이름 : ${snapshot.data!.productname}");
                  }else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
            FutureBuilder<Catalog>(
                future: futureCatalog,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Text("수량 : ${snapshot.data!.stock.toString()}");
                  }else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
            FutureBuilder<Catalog>(
                future: futureCatalog,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Text("가격 : ${snapshot.data!.unitPrice}");
                  }else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
