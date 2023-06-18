import 'dart:convert';

List<Map<String, ChatRoomList>> chatRoomListFromJson(String str) => List<Map<String, ChatRoomList>>.from(json.decode(str).map((x) => Map.from(x).map((k, v) => MapEntry<String, ChatRoomList>(k, ChatRoomList.fromJson(v)))));

String chatRoomListToJson(List<Map<String, ChatRoomList>> data) => json.encode(List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))));

class ChatRoomList {
  dynamic id;
  String title;
  Username1 username1;
  String username2;

  ChatRoomList({
    this.id,
    required this.title,
    required this.username1,
    required this.username2,
  });

  factory ChatRoomList.fromJson(Map<String, dynamic> json) => ChatRoomList(
    id: json["id"],
    title: json["title"],
    username1: username1Values.map[json["username1"]]!,
    username2: json["username2"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "username1": username1Values.reverse[username1],
    "username2": username2,
  };
}

enum Username1 { EMPTY, THE_1 }

final username1Values = EnumValues({
  "나 자신": Username1.EMPTY,
  "친구1": Username1.THE_1
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
