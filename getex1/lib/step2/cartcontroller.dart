import 'package:get/get.dart';
import 'package:getex1/step2/product.dart';


class CartController extends GetxController{
  var cartItems = <Product>[].obs;
  num get totalPrice => cartItems.fold(0, (pv, e) => pv+e.price);
  int get count => cartItems.length;

  addToCart(Product product){
    cartItems.add(product);
  }
}