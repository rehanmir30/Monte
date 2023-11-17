import 'dart:convert';

LevelModel levelFromMap(String str) => LevelModel.fromMap(json.decode(str));

String levelToMap(LevelModel data) => json.encode(data.toMap());

class LevelModel {
  int? id;
  String? name;

  LevelModel({
    this.id,
    this.name,
  });

  factory LevelModel.fromMap(Map<String, dynamic> json) => LevelModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}