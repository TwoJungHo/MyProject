import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int current = 0;

  final CarouselController controller = CarouselController();

  List imageList = [
    "asset/test4.PNG",
    "asset/test5.PNG",
    "asset/test6.PNG",
  ];

  List textList = [
    "개냥이",
    "개강아지",
    "개코",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("carousel slider"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  sliderWidget(),
                  sliderIndicator(),
                  sliderText()
                ],
              ),
            ),
            Container(
              child: Text("hello world"),
            )
          ],
        ),
      ),
    );
  }

  Widget sliderText(){
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        textList[current],
        style: TextStyle(
          fontSize: 30,
          color: Colors.blue
        ),
      ),
    );
  }

  Widget sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageList
            .asMap()
            .entries
            .map((e) => GestureDetector(
                  onTap: () => controller.animateToPage(e.key),
                  child: Container(
                    width: 16,
                    height: 16,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange
                          .withOpacity(current == e.key ? 1.0 : 0.4),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget sliderWidget() {
    return CarouselSlider(
        carouselController: controller,
        items: imageList
            .map((filename) => Builder(builder: (context) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(filename),
                      ));
                }))
            .toList(),
        options: CarouselOptions(
            height: 300,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            }));
  }
}
