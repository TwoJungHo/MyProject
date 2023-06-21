import 'package:flutter/material.dart';

class PC extends StatelessWidget {
  const PC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation= MediaQuery.of(context).orientation;
    print(orientation);

    double height = 300;

    if(orientation == Orientation.landscape){
      height = MediaQuery.of(context).size.height/2;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("PC"),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    height: height,
                    color: Colors.yellow[300],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Container(
                              color: Colors.orange[300],
                              height: 120,
                            ),
                          );
                        }
                    )
                )
              ],
            ),
          ),
          Container(
            width: 300,
            child: Expanded(
              child: ListView.builder(
                itemCount: 10, itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  color: Colors.red,
                ),
              );
            }),)
          ),
        ],
      ),
    );
  }
}
