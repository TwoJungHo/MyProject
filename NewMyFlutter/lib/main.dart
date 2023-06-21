import 'package:flutter/material.dart';
import 'package:newmyflutter/friendlist/friendlistprovider.dart';
import 'package:newmyflutter/loginpage.dart';
import 'package:newmyflutter/loginprovider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider(context)),
        ChangeNotifierProvider(create: (context) => FriendListProvider()),
      ],
      child: MyApp(navigatorKey: navigatorKey),
    ),

  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  MyApp({required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: LoginPage(),
    );
  }
}
