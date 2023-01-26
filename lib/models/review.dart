// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

class Review {
  Review({
    this.id,
    this.userId,
    this.productId,
    this.authorName,
    required this.reviewText,
    required this.reviewDate,
    this.v,
  });

  String? id;
  String? userId;
  String? productId;
  String? authorName;
  String reviewText;
  DateTime reviewDate;
  int? v;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["_id"],
    userId: json["userId"],
    productId: json["productId"],
    authorName: json["authorName"],
    reviewText: json["reviewText"],
    reviewDate: DateTime.parse(json["reviewDate"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "productId": productId,
    "authorName": authorName,
    "reviewText": reviewText,
    "reviewDate": reviewDate.toIso8601String(),
    "__v": v,
  };
}
