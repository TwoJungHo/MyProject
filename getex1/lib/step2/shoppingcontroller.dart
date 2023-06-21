import 'package:get/get.dart';
import 'package:getex1/step2/product.dart';


class ShoppingController extends GetxController{
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadingData();
  }

  void loadingData() async{

    await Future.delayed(Duration(seconds: 1));

    var productList = [
      Product(id: 1, name: "양말1", description: "빨간 양말1", price: 1000.5),
      Product(id: 2, name: "양말2", description: "빨간 양말2", price: 2000),
      Product(id: 3, name: "양말3", description: "빨간 양말3", price: 3000),
      Product(id: 4, name: "양말4", description: "빨간 양말4", price: 4000),
      Product(id: 5, name: "양말5", description: "빨간 양말5", price: 5000),
      Product(id: 6, name: "양말6", description: "빨간 양말6", price: 6000),
      Product(id: 7, name: "양말7", description: "빨간 양말7", price: 7000),
      Product(id: 8, name: "양말8", description: "빨간 양말8", price: 8000),
    ];

    products.assignAll(productList);
  }
}