import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("bottom menus"),
      ),
      body: _selectedIndex ==0?
      tabContainer(context, Colors.red, "red") :
      _selectedIndex == 1?
      tabContainer(context, Colors.green, "green"):
      tabContainer(context, Colors.blue, "blue"),
      bottomNavigationBar: SizedBox(
        height: 90,
        child:
            TabBar(controller: _tabController, labelColor: Colors.black, tabs: const [
          Tab(
            icon: Icon(Icons.settings),
            text: "설정",
          ),
          Tab(
            icon: Icon(Icons.person),
            text: "친구",
          ),
          Tab(
            icon: Icon(Icons.add),
            text: "추가",
          ),
        ]),
      ),
    );
  }

  Widget tabContainer(BuildContext context, Color tabcolor, String tabText){
    return Container(
      color: tabcolor,
      child: Center(
        child: Text(
            tabText
        ),
      ),
    );
  }
}
