import 'dart:convert';

import 'package:get/get.dart';
import 'package:getex1/product.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController{
  var productList = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadingData();
  }

  void loadingData() async{
   var products = await Controller.getNetwork();
   if(products != null){
     productList.value = products;
   }
  }

  static Future<List<Product>?> getNetwork() async{
    String url = "http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline";
    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      var jsonData = utf8.decode(response.bodyBytes);
      return productFromJson(jsonData);
    }else{
      return null;
    }
  }
}