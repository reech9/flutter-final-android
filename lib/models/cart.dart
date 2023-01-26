// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

import 'package:clothingrental/models/product.dart';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));
String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    required this.id,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.deliveryDate,
    required this.productData,
    required this.v,
  });

  String id;
  String productId;
  String userId;
  num quantity;
  num unitPrice;
  num totalPrice;
  DateTime deliveryDate;
  Product productData;
  int? v;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        productId: json["productId"],
        userId: json["userId"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
        totalPrice: json["totalPrice"],
        deliveryDate: DateTime.parse(json["deliveryDate"]),
        productData: Product.fromJson(json["productData"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productId": productId,
        "userId": userId,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "totalPrice": totalPrice,
        "deliveryDate": deliveryDate.toIso8601String(),
        "productData": productData.toJson(),
        "__v": v,
      };
}
