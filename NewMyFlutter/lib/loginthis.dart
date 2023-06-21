// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:newmyflutter/loginmodel.dart';
// import 'package:provider/provider.dart';
// class LoginThis extends StatelessWidget {
//   final String phoneNumber;
//   final String nickname;
//
//   const LoginThis({Key? key, required this.phoneNumber, required this.nickname})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _idController = TextEditingController();
//     final TextEditingController _passController = TextEditingController();
//
//     return Consumer<LoginModel>(
//       builder: (context, model, child) {
//         return Scaffold(
//           backgroundColor: Colors.amber[400],
//           appBar: AppBar(
//             backgroundColor: Colors.amber[400],
//             elevation: 0,
//             title: Text(''),
//             actions: [
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(Icons.minimize),
//               ),
//               IconButton(
//                 onPressed: () {
//                   SystemNavigator.pop();
//                 },
//                 icon: Icon(Icons.close),
//               ),
//             ],
//           ),
//           body: Padding(
//             padding: EdgeInsets.all(20),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 20,
//                   ),
//                   // Image.asset(
//                   //   'assets/캡처.png',
//                   //   height: 200,
//                   //   width: 200,
//                   //   fit: BoxFit.cover,
//                   // ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: _idController,
//                     decoration: InputDecoration(
//                       labelText: "아이디",
//                       labelStyle: TextStyle(
//                         color: Colors.grey,
//                       ),
//                       border: OutlineInputBorder(),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   TextField(
//                     controller: _passController,
//                     decoration: InputDecoration(
//                       labelText: "비밀번호",
//                       labelStyle: TextStyle(
//                         color: Colors.grey,
//                       ),
//                       border: OutlineInputBorder(),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   ElevatedButton(
//                     onPressed: model.isLoading
//                         ? null
//                         : () {
//                       model.login(
//                         context,
//                         _idController.text,
//                         _passController.text,
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(7),
//                       ),
//                       primary: Colors.brown,
//                     ),
//                     child: Container(
//                       alignment: Alignment.center,
//                       child: model.isLoading
//                           ? CircularProgressIndicator()
//                           : Text(
//                         "로그인",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 240,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       // TODO: 회원가입 페이지로 이동하는 로직 추가
//                     },
//                     child: Text(
//                       "회원가입 페이지로",
//                       style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Colors.grey[600],
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
