// To parse this JSON data, do
//
//     final shopModel = shopModelFromMap(jsonString);

import 'dart:convert';

import 'ShopProduct.dart';

ShopModel shopModelFromMap(String str) => ShopModel.fromMap(json.decode(str));

String shopModelToMap(ShopModel data) => json.encode(data.toMap());

class ShopModel {
  int? id;
  String? name;
  int? levelId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ShopProduct>? products=[];

  ShopModel({
    this.id,
    this.name,
    this.levelId,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory ShopModel.fromMap(Map<String, dynamic> json) => ShopModel(
    id: json["id"],
    name: json["name"],
    levelId: json["level_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "level_id": levelId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    };
}
