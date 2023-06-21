import 'package:flutter/material.dart';

class ImageWidget  extends StatelessWidget {
  const ImageWidget ({required this.index,Key? key}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: double.infinity,
        child: Card(
          child: Image.network(
            "https://picsum.photos/250?image=$index",
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      );
  }
}
