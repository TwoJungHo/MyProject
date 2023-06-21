import 'dart:convert';

List<Sample> sampleFromJson(String str) =>
    List<Sample>.from(json.decode(str).map((x) => Sample.fromJson(x)));

String sampleToJson(List<Sample> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sample {
  static String tableName = "sample";

  final int? id;
  final String name;
  final bool yn;
  final int value;
  final DateTime createAt;

  Sample({
    this.id,
    required this.name,
    required this.yn,
    required this.value,
    required this.createAt,
  });

  factory Sample.fromJson(Map<String, dynamic> json) => Sample(
      id: json["id"],
      name: json["name"] ?? '',
      yn: json["yn"] == null ? false : json["yn"] == 1,
      value: json["value"] ?? 0,
      createAt: json["createAt"] == null
          ? DateTime.now()
          : DateTime.parse(json["createAt"] as String));

  Sample updateSample(
      {int? id, String? name, bool? yn, int? value, DateTime? createAt}) {
    return Sample(
        id: id ?? this.id,
        name: name ?? this.name,
        yn: yn ?? this.yn,
        value: value ?? this.value,
        createAt: createAt ?? this.createAt
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "yn": yn ? 1 : 0,
        "value": value,
        "createAt": createAt.toIso8601String()
      };
}
