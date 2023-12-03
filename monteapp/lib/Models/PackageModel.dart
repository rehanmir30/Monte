// To parse this JSON data, do
//
//     final packageModel = packageModelFromMap(jsonString);

import 'dart:convert';

PackageModel packageModelFromMap(String str) => PackageModel.fromMap(json.decode(str));

String packageModelToMap(PackageModel data) => json.encode(data.toMap());

class PackageModel {
  Data? data;

  PackageModel({
    this.data,
  });

  factory PackageModel.fromMap(Map<String, dynamic> json) => PackageModel(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
  };
}

class Data {
  Package? package;
  Bundle? bundle;

  Data({
    this.package,
    this.bundle,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    package: json["package"] == null ? null : Package.fromMap(json["package"]),
    bundle: json["bundle"] == null ? null : Bundle.fromMap(json["bundle"]),
  );

  Map<String, dynamic> toMap() => {
    "package": package?.toMap(),
    "bundle": bundle?.toMap(),
  };
}

class Bundle {
  var id;
  var name;
  var thumbnail;
  var status;
  var description;
  var price;
  var isFeature;
  var totalProduct;
  var levelId;
  var createdAt;
  var updatedAt;
  List<Product>? products;

  Bundle({
    this.id,
    this.name,
    this.thumbnail,
    this.status,
    this.description,
    this.price,
    this.isFeature,
    this.totalProduct,
    this.levelId,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory Bundle.fromMap(Map<String, dynamic> json) => Bundle(
    id: json["id"],
    name: json["name"],
    thumbnail: json["thumbnail"],
    status: json["status"],
    description: json["description"],
    price: json["price"],
    isFeature: json["is_feature"],
    totalProduct: json["total_product"],
    levelId: json["level_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "thumbnail": thumbnail,
    "status": status,
    "description": description,
    "price": price,
    "is_feature": isFeature,
    "total_product": totalProduct,
    "level_id": levelId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toMap())),
  };
}

class Product {
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
  var createdAt;
  var updatedAt;
  Pivot? pivot;

  Product({
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
    this.pivot,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
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
    pivot: json["pivot"] == null ? null : Pivot.fromMap(json["pivot"]),
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
    "pivot": pivot?.toMap(),
  };
}

class Pivot {
  var bundleId;
  var productId;

  Pivot({
    this.bundleId,
    this.productId,
  });

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
    bundleId: json["bundle_id"],
    productId: json["product_id"],
  );

  Map<String, dynamic> toMap() => {
    "bundle_id": bundleId,
    "product_id": productId,
  };
}

class Package {
  var id;
  var name;
  var description;
  var price;
  var levelId;
  var createdAt;
  var updatedAt;

  Package({
    this.id,
    this.name,
    this.description,
    this.price,
    this.levelId,
    this.createdAt,
    this.updatedAt,
  });

  factory Package.fromMap(Map<String, dynamic> json) => Package(
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
