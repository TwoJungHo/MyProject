// To parse this JSON data, do
//
//     final friend = friendFromJson(jsonString);

import 'dart:convert';

Friend friendFromJson(String str) => Friend.fromJson(json.decode(str));

String friendToJson(Friend data) => json.encode(data.toJson());

class Friend {
  List<Result> result;

  Friend({
    required this.result,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  String username;
  String friendname;

  Result({
    required this.username,
    required this.friendname,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    username: json["username"],
    friendname: json["friendname"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "friendname": friendname,
  };
}
