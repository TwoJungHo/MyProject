// To parse this JSON data, do
//
//     final chatMessageList = chatMessageListFromJson(jsonString);

import 'dart:convert';

ChatMessageList chatMessageListFromJson(String str) => ChatMessageList.fromJson(json.decode(str));

String chatMessageListToJson(ChatMessageList data) => json.encode(data.toJson());

class ChatMessageList {
  List<dynamic> messageList;
  bool isExist;
  RoomInfo roomInfo;

  ChatMessageList({
    required this.messageList,
    required this.isExist,
    required this.roomInfo,
  });

  factory ChatMessageList.fromJson(Map<String, dynamic> json) => ChatMessageList(
    messageList: List<dynamic>.from(json["messageList"].map((x) => x)),
    isExist: json["isExist"],
    roomInfo: RoomInfo.fromJson(json["roomInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "messageList": List<dynamic>.from(messageList.map((x) => x)),
    "isExist": isExist,
    "roomInfo": roomInfo.toJson(),
  };
}

class RoomInfo {
  int id;
  String title;
  String username1;
  String username2;

  RoomInfo({
    required this.id,
    required this.title,
    required this.username1,
    required this.username2,
  });

  factory RoomInfo.fromJson(Map<String, dynamic> json) => RoomInfo(
    id: json["id"],
    title: json["title"],
    username1: json["username1"],
    username2: json["username2"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "username1": username1,
    "username2": username2,
  };
}
