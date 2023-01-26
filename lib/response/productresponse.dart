import 'dart:convert';

import '../models/product.dart';

class ProductResponse {
  bool? success;

  Map<String, dynamic>? productResponse;

  ProductResponse({this.success, this.productResponse});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'],
      productResponse: json['createdProduct'],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'createdProduct': productResponse,
      };
}

List<Product> listProductFromJson(List<dynamic> data) =>
    List<Product>.from(data.map((x) => Product.fromJson(x)));

String listProductToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

SingleProductResponse singleProductFromJson(String str) =>
    SingleProductResponse.fromJson(json.decode(str));

String singleProductToJson(SingleProductResponse data) =>
    json.encode(data.toJson());

class SingleProductResponse {
  SingleProductResponse({
    required this.data,
  });

  Product data;

  factory SingleProductResponse.fromJson(Map<String, dynamic> json) =>
      SingleProductResponse(
        data: Product.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}


class SingleCategoryResponse {
  SingleCategoryResponse({
    required this.data,
  });

  List<Product> data;

  factory SingleCategoryResponse.fromJson(Map<String, dynamic> json) =>
      SingleCategoryResponse(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}


class MyProductResponse {
  MyProductResponse({
    required this.data,
  });

  List<Product> data;

  factory MyProductResponse.fromJson(Map<String, dynamic> json) =>
      MyProductResponse(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}


