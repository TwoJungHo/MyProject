import 'package:flutter/material.dart';
import 'package:myflutterproject/FriendListProvider.dart';
import 'package:myflutterproject/FriendCard.dart';
import 'package:myflutterproject/MainProfile.dart';
import 'package:myflutterproject/UserDTO.dart';
import 'package:provider/provider.dart';

class FriendListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider를 사용하여 데이터 접근
    return Consumer<FriendListProvider>(
      builder: (context, friendListProvider, _) {
        final friendList = friendListProvider.friendList;

        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              InkWell(
                // 터치 이벤트 처리.onTap 감지
                onTap: () => friendListProvider.navigateToMyProfile(context),
                child: FutureBuilder<MemoryImage?>(
                  future: friendListProvider
                      .fetchFriendImage(friendListProvider.user.loginId),
                  builder: (BuildContext context,
                      AsyncSnapshot<MemoryImage?> imageSnapshot) {
                    if (imageSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return FriendCard(
                        user: friendListProvider.user,
                        imageProvider: imageSnapshot.data,
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                // 구분선
                color: Colors.grey[800],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: friendList.length,
                  itemBuilder: (context, index) {
                    if (friendListProvider.searchKeyword.isNotEmpty &&
                        !friendListProvider.friendList[index]["friendname"]
                            .contains(friendListProvider.searchKeyword)) {
                      return SizedBox();
                    }
                    return FutureBuilder<UserDto>(
                      future: friendListProvider.fetchUserDetail(
                          friendListProvider.friendList[index]["friendname"]),
                      builder: (BuildContext context,
                          AsyncSnapshot<UserDto> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          String friendName = snapshot.data!.loginId ?? '';
                          return FutureBuilder<MemoryImage?>(
                            future:
                                friendListProvider.fetchFriendImage(friendName),
                            builder: (BuildContext context,
                                AsyncSnapshot<MemoryImage?> imageSnapshot) {
                              if (imageSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (imageSnapshot.hasData) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainProfile(
                                            username:
                                                friendListProvider.username,
                                            id: friendListProvider
                                                    .friendList[index]
                                                ["friendname"],
                                            name: snapshot.data!.nickname ?? "",
                                            phoneNumber:
                                                snapshot.data!.phoneNumber ??
                                                    "",
                                            statusMSG:
                                                snapshot.data!.statusMSG ?? "",
                                            imageProvider: imageSnapshot.data,
                                          ),
                                        ),
                                      );
                                      if (result != null) {
                                        friendListProvider.updateFriend(
                                            index, result);
                                      }
                                    },
                                    child: FriendCard(
                                      user: snapshot.data!,
                                      imageProvider: imageSnapshot.data,
                                      onCheckChanged:
                                          friendListProvider.showCheckBox
                                              ? (value) {
                                                  friendListProvider
                                                      .updateCheckList(
                                                          index, value!);
                                                }
                                              : null,
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          );
                        } else {
                          return Text('데이터가 없습니다.');
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
