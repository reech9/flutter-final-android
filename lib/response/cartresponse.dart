// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';
import 'package:clothingrental/models/cart.dart';

List<Cart> cartResponseFromJson(List<dynamic> json) =>
    List<Cart>.from(json.map((x) => Cart.fromJson(x)));
String cartResponseToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

SingleCartResponse singleCartResponseFromJson(String str) =>
    SingleCartResponse.fromJson(json.decode(str));
String singleCartResponseToJson(SingleCartResponse data) =>
    json.encode(data.toJson());

class SingleCartResponse {
  SingleCartResponse({
    required this.data,
  });

  Cart data;

  factory SingleCartResponse.fromJson(Map<String, dynamic> json) =>
      SingleCartResponse(
        data: Cart.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}
