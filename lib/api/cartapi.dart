import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/httpservices.dart';

import 'package:mime/mime.dart';
import '../models/cart.dart';
import '../models/product.dart';
import '../response/cartresponse.dart';
import '../response/productresponse.dart';
import '../utils/url.dart';
import 'package:http_parser/http_parser.dart';

class CartApi {
  Future<bool> addToCart( String productId, String quantity, DateTime deliveryDate) async {
    try {
      var url = baseUrl + addToCartURL;
      var dio = HttpServices().getInstance();
      print(url);
      final prefs = await SharedPreferences.getInstance();
      final user = await prefs.get("LOGGED_IN_USER");
      print(user);
      String token = json.decode(user.toString())["token"];
      print(token);
      dio.options.headers["Authorization"] = "Bearer $token";
      print(productId);
      final data = {
        "productId": productId,
        "quantity": quantity,
        "deliveryDate": deliveryDate.toIso8601String()
      };
      print(data);
      var response = await dio.post(url, data: data);
      print(response);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return false;
  }

  Future<List<Cart>?> getCartProducts() async {
    print("getting cart products");
    Future.delayed(const Duration(seconds: 2), () {});
    List<Cart>? productResponse;
    try {
      var url = baseUrl + getCart;
      var dio = HttpServices().getInstance();

      final prefs = await SharedPreferences.getInstance();
      final user = await prefs.get("LOGGED_IN_USER");
      String token = json.decode(user.toString())["token"];
      dio.options.headers["Authorization"] = "Bearer ${token}";
      Response response = await dio.getUri(Uri.parse(url), );
      print(response);
      if (response.statusCode == 200) {
        productResponse = cartResponseFromJson(response.data );
      } else {
        productResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return productResponse;
  }


  Future<List<Product>?> getProductFromCategory(String categoryId) async {
    print("getting products");
    Future.delayed(const Duration(seconds: 2), () {});
    List<Product>? productResponse;
    try {
      var url = baseUrl + getProductWithCategory + categoryId;
      var dio = HttpServices().getInstance();
      Response response = await dio.getUri(Uri.parse(url));
      if (response.statusCode == 200) {
        productResponse = SingleCategoryResponse.fromJson(response.data ).data;
      } else {
        productResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return productResponse;
  }


  Future<Product?> getOneProduct(String id) async {
    Future.delayed(const Duration(seconds: 2), () {});
    Product? productResponse;
    try {
      var url = baseUrl + getOneProductURL + id;
      print(url);
      var dio = HttpServices().getInstance();
      Response response = await dio.getUri(Uri.parse(url));
      if (response.statusCode == 200) {
        productResponse = SingleProductResponse.fromJson(response.data).data;
      } else {
        productResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return productResponse;
  }

  Future<bool> removeFromCart(String cartId) async {
    try {
      var url = baseUrl + deleteCart + cartId;
      var dio = HttpServices().getInstance();

      final prefs = await SharedPreferences.getInstance();
      final user = await prefs.get("LOGGED_IN_USER");
      String token = json.decode(user.toString())["token"];
      dio.options.headers["Authorization"] = "Bearer $token";
      print(url);
      var response = await dio.delete(url);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return false;
  }
}
