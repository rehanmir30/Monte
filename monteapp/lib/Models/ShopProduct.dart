// To parse this JSON data, do
//
//     final shopProduct = shopProductFromMap(jsonString);

import 'dart:convert';

ShopProduct shopProductFromMap(String str) => ShopProduct.fromMap(json.decode(str));

String shopProductToMap(ShopProduct data) => json.encode(data.toMap());

class ShopProduct {
  var id;
  var name;
  var file;
  var type;
  var status;
  var description;
  var price;
  var quantity;
  var isFeature;
  var shopId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ShopProduct({
    this.id,
    this.name,
    this.file,
    this.type,
    this.status,
    this.description,
    this.price,
    this.quantity,
    this.isFeature,
    this.shopId,
    this.createdAt,
    this.updatedAt,
  });

  factory ShopProduct.fromMap(Map<String, dynamic> json) => ShopProduct(
    id: json["id"],
    name: json["name"],
    file: json["file"],
    type: json["type"],
    status: json["status"],
    description: json["description"],
    price: json["price"],
    quantity: json["quantity"],
    isFeature: json["is_feature"],
    shopId: json["shop_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "file": file,
    "type": type,
    "status": status,
    "description": description,
    "price": price,
    "quantity": quantity,
    "is_feature": isFeature,
    "shop_id": shopId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
