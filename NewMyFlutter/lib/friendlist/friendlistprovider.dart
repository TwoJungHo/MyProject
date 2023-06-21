import 'package:flutter/foundation.dart';

class FriendListProvider extends ChangeNotifier{
  List<String> friendList = [];

  void FriendList(String username){
    friendList.add(username);
    notifyListeners();
  }

}