import 'package:flutter/material.dart';
import 'package:getex1/controller.dart';
import 'package:get/get.dart';
import 'package:getex1/producttile.dart';

class MyshoppingView extends StatelessWidget {
  MyshoppingView({Key? key}) : super(key: key);
  
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.green[200],
        width: 250,
      ),
      appBar: AppBar(
        title: Text("쇼핑몰"),
        actions: [
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Container(
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Obx(()=> GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: controller.productList.length,
            itemBuilder: (context, index){
              return ProductTile(product: controller.productList[index]);
            },
          )),
        ),
      ),
    );
  }
}
