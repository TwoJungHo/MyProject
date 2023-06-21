// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Result result;

  Login({
    required this.result,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      result: Result.fromJson(json["result"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
  };
}

class Result {
  String id;
  String loginId;
  String nickname;
  String phoneNumber;
  String password;
  String statusMsg;

  Result({
    required this.id,
    required this.loginId,
    required this.nickname,
    required this.phoneNumber,
    required this.password,
    required this.statusMsg,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json["id"],
      loginId: json["loginId"],
      nickname: json["nickname"],
      phoneNumber: json["phoneNumber"],
      password: json["password"],
      statusMsg: json["statusMSG"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "loginId": loginId,
    "nickname": nickname,
    "phoneNumber": phoneNumber,
    "password": password,
    "statusMSG": statusMsg,
  };
}
