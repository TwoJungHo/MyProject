import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ko","KR"),
        Locale("en","US"),
      ],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectDate = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("datepicker test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${selectDate.year}.${selectDate.month}.${selectDate.day}",
            style: TextStyle(
              fontSize: 40
            ),
            ),
            ElevatedButton(onPressed: () async {
             DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: selectDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2500)
             );
             if(dateTime != null){
               setState(() {
                 selectDate = dateTime;
               });
             }
            }, child: Text("날짜를 선택"))
          ],
        ),
      ),
    );
  }
}
