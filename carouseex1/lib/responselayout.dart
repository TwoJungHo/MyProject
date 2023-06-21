import 'package:flutter/material.dart';

class ResponseLayout extends StatelessWidget {
  const ResponseLayout({required this.mobile, required this.pc, Key? key}) : super(key: key);

  final Widget mobile;
  final Widget pc;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth <800){
            return mobile;
          }else{
            return pc;
          }
        });
  }
}
