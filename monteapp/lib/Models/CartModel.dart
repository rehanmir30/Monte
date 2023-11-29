// To parse this JSON data, do
//
//     final cartModel = cartModelFromMap(jsonString);

import 'dart:convert';

CartModel cartModelFromMap(String str) => CartModel.fromMap(json.decode(str));

String cartModelToMap(CartModel data) => json.encode(data.toMap());

class CartModel {
  var id;
  var totalPrice;
  var totalProducts;
  List<CartItem>? cartItems;

  CartModel({
    this.id,
    this.totalPrice,
    this.totalProducts,
    this.cartItems,
  });

  factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    totalPrice: json["total_price"],
    totalProducts: json["total_products"],
    cartItems: json["cart_items"] == null ? [] : List<CartItem>.from(json["cart_items"]!.map((x) => CartItem.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "total_price": totalPrice,
    "total_products": totalProducts,
    "cart_items": cartItems == null ? [] : List<dynamic>.from(cartItems!.map((x) => x.toMap())),
  };
}

class CartItem {
  var id;
  var cartId;
  var productId;
  var totalPrice;
  var quantity;
  Product? product;

  CartItem({
    this.id,
    this.cartId,
    this.productId,
    this.totalPrice,
    this.quantity,
    this.product,
  });

  factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
    id:json["id"],
      cartId: json["cart_id"],
    productId: json["product_id"],
    totalPrice: json["total_price"],
    quantity: json["quantity"],
    product: json["product"] == null ? null : Product.fromMap(json["product"]),
  );

  Map<String, dynamic> toMap() => {
    "cart_id": cartId,
    "product_id": productId,
    "product": product?.toMap(),
  };
}

class Product {
  var id;
  var name;
  var price;
  var file;

  Product({
    this.id,
    this.name,
    this.price,
    this.file,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    file: json["file"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "price": price,
    "file": file,
  };
}
