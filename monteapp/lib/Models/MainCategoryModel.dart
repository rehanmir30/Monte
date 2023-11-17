import 'dart:convert';

MainCategoryModel mainCategoryModelFromMap(String str) => MainCategoryModel.fromMap(json.decode(str));

String mainCategoryModelToMap(MainCategoryModel data) => json.encode(data.toMap());

class MainCategoryModel {
  int? id;
  String? name;
  String? levelId;
  String? isGame;
  dynamic description;

  MainCategoryModel({
    this.id,
    this.name,
    this.levelId,
    this.isGame,
    this.description,
  });

  factory MainCategoryModel.fromMap(Map<String, dynamic> json) => MainCategoryModel(
    id: json["id"],
    name: json["name"],
    levelId: json["level_id"],
    isGame: json["isGame"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "level_id": levelId,
    "isGame": isGame,
    "description": description,
  };
}