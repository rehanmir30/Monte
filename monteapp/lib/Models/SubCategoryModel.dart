// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromMap(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromMap(String str) => SubCategoryModel.fromMap(json.decode(str));

String subCategoryModelToMap(SubCategoryModel data) => json.encode(data.toMap());

class SubCategoryModel {
  var id;
  var name;
  var mainCategoryId;
  var description;

  SubCategoryModel({
    this.id,
    this.name,
    this.mainCategoryId,
    this.description,
  });

  factory SubCategoryModel.fromMap(Map<String, dynamic> json) => SubCategoryModel(
    id: json["id"],
    name: json["name"],
    mainCategoryId: json["main_category_id"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "main_category_id": mainCategoryId,
    "description": description,
  };
}
