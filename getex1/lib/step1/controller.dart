import 'package:get/get.dart';
import 'package:getex1/step1/person.dart';

class Controller extends GetxController{
  final person = Person("홍길동", 16).obs;

  void updateInfo(){
    person.update((val){
      val?.age++;
    });
  }
}