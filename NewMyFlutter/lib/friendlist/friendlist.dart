import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newmyflutter/friendlist/friendlistprovider.dart';
import 'package:newmyflutter/quicktype/friendlist.dart';
import 'package:provider/provider.dart';

class FriendListPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final friendListProvider = Provider.of<FriendListProvider>(context);
    final friendList = friendListProvider.friendList;

    return Scaffold(
      appBar: AppBar(
        title: Text("친구목록"),
      ),
      body: ListView.builder(
          itemCount: friendList.length,
          itemBuilder: (context, index){
            final friendId = friendList[index];
            return ListTile(
              title: Text(friendId),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  print("하이");
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("추가하까");
        },
        child: Icon(Icons.add),
      ),
    );
  }



}


//   static Future<Friend?> _fetchFriendList(String username) async {
//     String url = "http://10.0.0.2:9000/friend/list/$username";
//     final response = await http.get(Uri.parse(url));
//     print(response);
//     if(response.statusCode == 200){
//       var jsonData = utf8.decode(response.bodyBytes);
//       return friendFromJson(jsonData);
//     }else{
//       return null;
//     }
//   }
// }
//
