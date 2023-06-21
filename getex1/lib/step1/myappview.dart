import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getex1/step1/controller.dart';

class MyAppView extends StatelessWidget {
  MyAppView({Key? key}) : super(key: key);
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              width: double.maxFinite,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                child: Text("이름 : 홍길동"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(40)),
              child: Center(
                child: GetX<Controller>(builder: (_) {
                  return Text("나이1 : ${controller.person().age}");
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                child: Obx(() => Text("나이2 : ${controller.person().age}")),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                child: GetX<Controller>(
                    init: Controller(),
                    builder: (controller2) {
                      return Text("나이3 : ${controller2.person().age}");
                    }),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                child: GetX<Controller>(builder: (_) {
                  return Text("나이4 : ${Get.find<Controller>().person().age}");
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                child: Text("전화 : 112"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.updateInfo();
                },
                child: Text("Age Update")),
          ],
        ),
      ),
    );
  }
}
