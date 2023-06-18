import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakaomessage/chatroomlist.dart';
import 'package:kakaomessage/chatserver.dart';
import 'package:http/http.dart' as http;

class Project extends StatefulWidget {
  const Project({Key? key}) : super(key: key);


  @override
  State<Project> createState() => _ProjectState();
}

// 채팅 목록
class _ProjectState extends State<Project> {
  String username = "친구1";
  List<dynamic> responseBody = [];
  List<Map<String, dynamic>> filteredList = []; // 빈리스트로 통신후 값을 list에 넣을 준비

  Future<void> FindChatMessage() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:9000/chat-service/findchatrooms/${username}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
      filteredList = responseBody.map<Map<String, dynamic>>((item) {
        final Map<String, dynamic> filteredItem = {
          'id': item.values.first['id'].toString(),
          'title': item.values.first['title'],
          'username1': item.values.first['username1'],
          'username2': item.values.first['username2'],
        };
        return filteredItem;
      }).toList(); // responseBody가 업데이트된 시점에서 filteredList 초기화

      setState(() {
        filteredList;
      });
    } else {
      print("에러");
      throw Exception("채팅목록이 없습니다.");
    }
  }


  @override
  void initState() {
    super.initState();
    FindChatMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("채팅"),
        actions: [
          IconButton(onPressed: () {
            print("=================================================");
            print(filteredList[1]);
          }, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.chat_bubble))
        ],
        backgroundColor: Colors.black,
      ),
      body: ListView.separated(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {

          return InkWell(
            onTap: () async{
              final titleName = await IntoChatRoom.InsertChatRoom(username, filteredList[index]['username2']);

              print("=================================================");
              print(titleName);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=> Chat(
                        username1: username,
                        username2: filteredList[index]['username2'],
                        title: titleName[0], Chatmessage: titleName[1],
                ),
              ),
              );
            },
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 16.0, right: 10.0),
              horizontalTitleGap: 10,
              leading: const Icon(CupertinoIcons.person),
              title: Text(filteredList[index]['username2']),
              trailing: Container(
                width: 230,
                child: Text(
                  "${filteredList[index]['title']}의 대화방",
                  style: const TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black,
            thickness: 1,
            height: 1,
          );
        },
      ),
    );


  }
}

class IntoChatRoom {
  static Future<List<dynamic>> InsertChatRoom(String username1, String username2) async {
    final url = Uri.parse('http://10.0.2.2:9000/chat-service/enter');
    final dto = {
      "username1": username1,
      "username2": username2,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto),
      );

      if (response.statusCode == 200) {
        print("채팅방 입장/생성이 완료되었습니다.");
        final responseBody = jsonDecode(response.body);
        final title = responseBody['roomInfo']['title'];
        final messageList = responseBody['messageList'] as List<dynamic>;
        print("채팅방제목 : $title");
        print("채팅내용목록 : $messageList");
        return [title, messageList];
      } else {
        print("채팅방 입장/생성에 실패하였습니다.");
        return [];
      }
    } catch (e) {
      print("에러발생 : $e");
      return [];
    }
  }
}


// class IntoChatRoom{
//   static Future<String> InsertChatRoom(String username1, String username2) async{
//   final url = Uri.parse('http://10.0.2.2:9000/chat-service/enter');
//   final dto = {
//     "username1" : username1,
//     "username2" : username2,
//   };
//
//   try{
//     final response = await http.post(url,
//     headers: {'Content-Type' : 'application/json'},
//       body: jsonEncode(dto),
//     );
//
//     if(response.statusCode == 200){
//       print("채팅방 입장/생성이 완료되었습니다.");
//       final responseBody = jsonDecode(response.body);
//       final title = responseBody['roomInfo']['title'];
//       final messageList = responseBody['messageList'] as List<dynamic>;
//       print("채팅방제목 : $title");
//       print("채팅내용목록 : $messageList");
//       return title;
//     } else{
//       print("채팅방 입장/생성에 실패하였습니다.");
//       return "";
//     }
//   }catch(e){
//     print("에러발생 : $e");
//     return "";
//   }
//
//   }
// }
































