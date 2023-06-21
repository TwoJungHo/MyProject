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
      debugShowCheckedModeBanner: false,
    );
  }
}

List<Catalog> catalogFromJson(String str) =>
    List<Catalog>.from(json.decode(str).map((x) => Catalog.fromJson(x)));

String catalogToJson(List<Catalog> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  String deleteUrl = "http://10.0.2.2:7000/catalog-service/catalogs";

  int page = 0;
  List<Catalog> values = [];
  List<String> ids = [];
  List<int> stocks = [];
  List<String> createAt = [];
  bool isLoading = false;

  ScrollController _scrollController = ScrollController();

  Future<void> loadData() async {
    //async 비동기로 하겠다고함 await있음
    if (!isLoading) {
      isLoading = true;
      String url =
          'http://10.0.2.2:7000/catalog-service/catalogs/paging/${page}';
      final response = await http.get(
        //await : 통신이 끝날때까지 대기
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
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40)),
                          child: Column(children: [
                            Text("품목, ${values[index].productname}"),
                            Text("품목id, ${values[index].productId}"),
                            Text("수량, ${stocks[index]}"),
                            Text("hello, $index"),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => _UpdatePage(
                                              "${values[index].productId}")));
                                },
                                child: Text("수정화면으로 이동"))
                          ]),
                        ),
                      );
                    });
              },
              child: Dismissible(
                key: ValueKey(values[index]),
                background: Container(color: Colors.red),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  setState(() {
                    if(direction == DismissDirection.startToEnd){
                      Catalog deleteCatalog= values.removeAt(index);
                      String productId = deleteCatalog.productId;
                      Map<String, String> body={
                        "productId" : productId
                      };
                      http.delete(
                        Uri.parse(deleteUrl),
                        headers: {
                          "Content-Type" : "application/json"
                        },
                        body: jsonEncode(body)
                      );

                    }
                  });
                },

                child: ListTile(
                  key: ValueKey(values[index]),
                  title: Text(values[index].productname),
                  subtitle: Text(values[index].productId),
                ),
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
  late Catalog _catalog;
  bool _isLoading = false;
  bool _isDeleting = false;
  late TextEditingController _idController;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _stockController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String url =
          "http://10.0.2.2:7000/catalog-service/catalogs/${widget.productId}";
      final response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json"
        // "Athorization" : "bearer ${token}"
      });
      if (response.statusCode != 200) {
        throw Exception();
      }
      setState(() {
        _catalog =
            Catalog.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

        _idController = TextEditingController(text: _catalog.productId);
        _nameController.text = _catalog.productname;
        _priceController.text = _catalog.unitPrice.toString();
        _stockController.text = _catalog.stock.toString();
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: Text("수정화면 : ${widget.productId}"),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ListViewPage()));
                  },
                  icon: Icon(Icons.arrow_back_ios_new)),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.check)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${_idController.text}",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _nameController,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _priceController,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _stockController,
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(children: [
                      ElevatedButton(
                          onPressed: processUpdate, child: Text("수정완료")),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            deleteData(widget.productId);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text("삭제완료!")));
                          },
                          child: Text("삭제")),
                    ])
                  ],
                ),
              ),
            ),
          );
  }

  void deleteData(productId) async {
    setState(() {
      _isDeleting = true;
    });
    String url = "http://10.0.2.2:7000/catalog-service/catalogs";

    Map<String, String> body = {"productId": productId};

    try {
      final response = await http.delete(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));
      if (response.statusCode != 200) {
        throw Exception();
      }
      // Map<String, dynamic> responseData = jsonDecode(response.body);
      // print(responseData["status"]);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ListViewPage()));
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isDeleting = false;
      });
    }
  }

  void processUpdate() async {
    String productId = _idController.text;
    String productname = _nameController.text;
    int stock = int.parse(_stockController.text);
    int unitprice = int.parse(_priceController.text);

    setState(() {
      _isLoading = true;
    });

    String url = "http://10.0.2.2:7000/catalog-service/catalogs";

    try {
      Map<String, dynamic> body = {
        "productId": productId,
        "productname": productname,
        "stock": stock,
        "unitPrice": unitprice
      };
      final response = await http.put(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));
      if (response.statusCode != 200) {
        throw Exception();
      } else {
        Catalog catalog =
            Catalog.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ListViewPage()));
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
