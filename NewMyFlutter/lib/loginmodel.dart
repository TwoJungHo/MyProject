// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:newmyflutter/friendlist/friendlist.dart';
// import 'package:newmyflutter/quicktype/login.dart';
//
// class LoginModel extends ChangeNotifier {
//   bool _isLoading = false;
//   String _id = "";
//   String _pass = "";
//   String _phoneNumber = "";
//   String _nickname = "";
//   String _statusMSG = "";
//
//   bool get isLoading => _isLoading;
//
//   String get id => _id;
//   String get pass => _pass;
//   String get phoneNumber => _phoneNumber;
//   String get nickname => _nickname;
//   String get statusMSG => _statusMSG;
//
//   Future<void> login(BuildContext context, String id, String pass) async {
//     _isLoading = true;
//     notifyListeners();
//
//     String url = "http://10.0.2.2:9000/user/login"; // 로그인 엔드포인트
//
//     Map<String, String> body = {"loginId": id, "password": pass};
//
//     final response = await http.post(Uri.parse(url),
//         headers: {
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode(body));
//     try {
//       if (response.statusCode ~/ 100 != 2) { // 200번대가 아니면 예외처리
//         throw Exception();
//       }
//
//       var jsonData = utf8.decode(response.bodyBytes);
//       Login login = Login.fromJson(jsonDecode(jsonData));
//       print("로그인 성공");
//
//       Navigator.push(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => FrinedList(
//             username: login.result.loginId,
//           ),
//         ),
//       );
//
//     } catch (e) {
//       print("로그인 실패");
//       print(e.toString());
//     } finally {
//       _isLoading = false; // 로딩 상태 해제
//       notifyListeners();
//     }
//   }
// }
