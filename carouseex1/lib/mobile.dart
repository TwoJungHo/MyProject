import 'package:flutter/material.dart';

class Mobile extends StatelessWidget {
  const Mobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("모바일"),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 300,
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
    );
  }
}
