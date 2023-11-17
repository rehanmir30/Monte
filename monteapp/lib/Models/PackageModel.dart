import 'dart:convert';

PackageModel packageModelFromMap(String str) => PackageModel.fromMap(json.decode(str));

String packageModelToMap(PackageModel data) => json.encode(data.toMap());

class PackageModel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? levelId;
  DateTime? createdAt;
  DateTime? updatedAt;

  PackageModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.levelId,
    this.createdAt,
    this.updatedAt,
  });

  factory PackageModel.fromMap(Map<String, dynamic> json) => PackageModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    levelId: json["level_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "level_id": levelId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
