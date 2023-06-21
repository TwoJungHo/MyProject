import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newmyflutter/friendlist/friendlist.dart';
import 'package:newmyflutter/quicktype/login.dart';

enum LoginStatus { initial, loading, success, error }

class LoginProvider extends ChangeNotifier {
  final BuildContext context;
  LoginProvider(this.context);

  LoginStatus _status = LoginStatus.initial;
  String _loginId = '';

  List<dynamic> _friendList = [];
  List<dynamic> get friendList => _friendList;

  LoginStatus get status => _status;
  String get token => _loginId;

  Future<void> login(String id, String password) async {
    _status = LoginStatus.loading;
    notifyListeners();

    String url = "http://10.0.2.2:9000/user/login"; // 로그인 엔드포인트

    Map<String, String> body = {"loginId": id, "password": password};

    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body));
    try {
      if (response.statusCode ~/ 100 != 2) { // 200번대가 아니면 예외처리
        throw Exception();
      }

      var jsonData = utf8.decode(response.bodyBytes);
      print("로그인 성공");
      Login login = Login.fromJson(jsonDecode(jsonData));
      print(login.result.loginId);
      _loginId = login.result.loginId;

      await fetchFriendList();

      _status = LoginStatus.success;

      notifyListeners();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context)=>
                  FriendListPage()));

    } catch (e) {
      _status = LoginStatus.error;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> fetchFriendList() async {
   String url = 'http://10.0.2.2:9000/friend/list/${_loginId}';

   final response = await http.get(Uri.parse(url),
     headers:{
     'Content-Type':'application/json',
     });
   try{
     if(response.statusCode ~/ 100 !=2){
       throw Exception();
     }
     var jsonData = utf8.decode(response.bodyBytes);
     List<dynamic> friendsData = jsonDecode(jsonData);
     print(friendsData);
     _friendList = friendsData.map((friend) => friend['friendname']).toList();
     print(_friendList);
     notifyListeners();
   }catch(e){
     print("목록불러오기 실패");
   }


  }
}
