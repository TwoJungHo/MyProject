import 'package:flutter/material.dart';
import 'package:myflutterproject/AddFriend.dart';
import 'package:myflutterproject/FriendListBody.dart';
import 'package:myflutterproject/FriendListProvider.dart';
import 'package:provider/provider.dart';

class FriendListScreen extends StatelessWidget {
  final String loginId;
  FriendListScreen(this.loginId);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Consumer<FriendListProvider>(
          builder: (context, friendListProvider, _) {
            return friendListProvider.showSearchBar
                ? TextField(
                    controller: friendListProvider.nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: '아이디로 검색',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      friendListProvider.setSearchKeyword(value);
                    },
                  )
                : Text(
                    "친구",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  );
          },
        ),
        actions: [
          Consumer<FriendListProvider>(
            builder: (context, friendListProvider, _) {
              return Row(
                children: [
                  if (friendListProvider.showSearchBar &&
                      friendListProvider.searchKeyword.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        friendListProvider.clearSearch();
                      },
                      icon: Icon(Icons.close),
                    ),
                  IconButton(
                    onPressed: friendListProvider.toggleSearchBar,
                    icon: Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFriend(username: loginId,),
                        ),
                      );

                      if (result != null) {
                        String friendname = result['name'];
                        friendListProvider.addFriend(friendname);
                      } else {
                        print("친구 추가가 취소되었습니다.");
                      }
                    },
                    icon: Icon(Icons.person_add_alt_1),
                  ),
                  IconButton(
                    onPressed: friendListProvider.toggleCheckboxes,
                    icon: Icon(Icons.checklist_rtl),
                  ),
                  if (friendListProvider.showCheckBox)
                    IconButton(
                      onPressed: friendListProvider.deleteSelectedFriends,
                      icon: Icon(Icons.delete),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<FriendListProvider>(
        builder: (context, friendListProvider, _) {
          return FriendListBody();
        },
      ),
    );
  }
}
