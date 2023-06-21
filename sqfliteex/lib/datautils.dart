import 'dart:math';

import 'package:uuid/uuid.dart';

class DataUtils{
  static int randomValue(){
    return Random().nextInt(100);
  }

  static String makeUUID(){
    return Uuid().v1();
  }
}