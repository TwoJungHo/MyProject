import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getex1/product.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({required this.product, Key? key}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 75,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Image.network(product.imageLink, fit: BoxFit.contain,),
                ),
                Obx(
                        () => CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 15,
                          child: IconButton(onPressed: () {
                            product.like.toggle();
                          }, icon:
                              product.like.value?
                          Icon(Icons.favorite):
                              Icon(Icons.favorite_border),
                              iconSize: 18,
                              color: Colors.red),
                        )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(product.name,
            maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w700
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.rating==null?
                    "0":product.rating.toString(),
                    style: TextStyle(color: Colors.white),),
                  Icon(Icons.star,size: 16,color: Colors.white,)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("\$${product.price}",
            style: TextStyle(fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
