// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    required this.brandName,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.rentPrice,
    required this.color,
    required this.size,
    required this.rentCategory,
    this.userId,
    this.imageUrl,
    this.v,
  });

  String? id;
  String brandName;
  String productName;
  String productDescription;
  num productPrice;
  num rentPrice;
  String color;
  String size;
  String rentCategory;
  String? userId;
  String? imageUrl;
  int? v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        brandName: json["brandName"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        productPrice: json["productPrice"],
        rentPrice: json["rentPrice"],
        color: json["color"],
        size: json["size"],
        rentCategory: json["rentCategory"],
        userId: json["userId"],
        imageUrl: json["imageUrl"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "brandName": brandName,
        "productName": productName,
        "productDescription": productDescription,
        "productPrice": productPrice,
        "rentPrice": rentPrice,
        "color": color,
        "size": size,
        "rentCategory": rentCategory,
        "userId": userId,
        "imageUrl": imageUrl,
        "__v": v,
      };
}
