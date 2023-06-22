import 'package:flutter/material.dart';
import 'package:myflutterproject/Login.dart';
import 'package:myflutterproject/MyAppMenu.dart';
import 'package:myflutterproject/UserProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My flutter project",
      home: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoggedIn) {
            final user = userProvider.user;
            return user != null ? MyAppMenu() : CircularProgressIndicator();
          } else {
            return Login();
          }
        },
      ),
      color: Colors.amber,
      debugShowCheckedModeBanner: false,
    );
  }
}
