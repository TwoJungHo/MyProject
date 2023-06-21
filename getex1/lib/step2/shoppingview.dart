import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getex1/step2/cartcontroller.dart';
import 'package:getex1/step2/shoppingcontroller.dart';


class ShoppingView extends StatelessWidget {
  ShoppingView({Key? key}) : super(key: key);
  final shoppingController = Get.put(ShoppingController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[200],
        body: Column(
          children: [
            Expanded(
              child: GetX<ShoppingController>(builder: (controller) {
                return ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controller.products[index].name}",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      Text(
                                          "${controller.products[index].description}"),
                                    ],
                                  ),
                                  Text(
                                    "${controller.products[index].price}",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: (
                                      ) {
                                    cartController.addToCart(controller.products[index]);
                                    //cartController.addToCart(shoppingController.products()[index]);
                                  }, child: Text("장바구니에 추가"))
                            ],
                          ),
                        ),
                      );
                    });
              }),
            ),
            SizedBox(
              height: 30,
            ),
            GetX<CartController>(
              builder: (controller) {
                return Text("총금액 : ${controller.totalPrice}", style: TextStyle(
                  fontSize: 30,
                ),);
              }
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: GetX<CartController>(
            builder: (controller){
              return Text(controller.count.toString(),
                style: TextStyle(
                fontSize: 20,
              ),);
            },
          ),
          icon: Icon(Icons.add_shopping_cart_rounded),
        ));
  }
}
