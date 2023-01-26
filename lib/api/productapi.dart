import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/httpservices.dart';

import 'package:mime/mime.dart';
import '../models/product.dart';
import '../response/productresponse.dart';
import '../utils/url.dart';
import 'package:http_parser/http_parser.dart';

class ProductAPI {
  Future<bool> addProduct(File? file, Product product) async {
    try {
      var url = baseUrl + addProductURL;
      var dio = HttpServices().getInstance();
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);

        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split("/").last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        ); // image/jpeg -> jpeg
      }
      print(image);
      final prefs = await SharedPreferences.getInstance();
      final user = await prefs.get("LOGGED_IN_USER");
      String token = json.decode(user.toString())["token"];
      // brandName ||
      //     !productName ||
      //     !productDescription ||
      //     !productPrice ||
      //     !rentPrice ||
      //     !color ||
      //     !size ||
      //     !rentCategory
      var formData = FormData.fromMap({
        "brandName": product.brandName,
        "productName": product.productName,
        "productDescription": product.productDescription,
        "productPrice": product.productPrice,
        "rentCategory": product.rentCategory,
        "rentPrice": product.rentPrice,
        "color": product.color,
        "size": product.size,
        "img": image,
      });

      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.post(url, data: formData, );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return false;
  }


  Future<bool> editProduct(Product product) async {
    try {
      var url = baseUrl + updateProduct + product.id!;
      var dio = HttpServices().getInstance();
      MultipartFile? image;
      final prefs = await SharedPreferences.getInstance();
      final user = await prefs.get("LOGGED_IN_USER");
      String token = json.decode(user.toString())["token"];
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.put(
        url,
        data: product.toJson(),
      );
      // var response = await dio.post(url, data: formData, );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return false;
  }

  Future<List<Product>?> getProducts() async {
    print("getting products");
    Future.delayed(const Duration(seconds: 2), () {});
    List<Product>? productResponse;
    try {
      var url = baseUrl + getProduct;
      var dio = HttpServices().getInstance();
      Response response = await dio.getUri(Uri.parse(url));
      if (response.statusCode == 200) {
        productResponse = listProductFromJson(response.data );
      } else {
        productResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return productResponse;
  }


  Future<List<Product>?> getUserProduct() async {
    print("getting products");
    Future.delayed(const Duration(seconds: 2), () {});

    List<Product>? productResponse;
    try {
      var url = baseUrl + getUserProductURL;
      var dio = HttpServices().getInstance();

      final prefs = await SharedPreferences.getInstance();
      final user = await prefs.get("LOGGED_IN_USER");
      String token = json.decode(user.toString())["token"];
      print(token);
      dio.options.headers["Authorization"] = "Bearer ${token}";

      Response response = await dio.getUri(Uri.parse(url));
      print(response.data);
      if (response.statusCode == 200) {
        productResponse = MyProductResponse.fromJson(response.data).data;
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

  Future<bool> deleteProduct(Product product)  async{
    bool productResponse= false;
    try {
      var url = baseUrl + removeProduct + product.id!;
      var dio = HttpServices().getInstance();

      final prefs = await SharedPreferences.getInstance();
      final user = await prefs.get("LOGGED_IN_USER");
      String token = json.decode(user.toString())["token"];
      dio.options.headers["Authorization"] = "Bearer ${token}";

      Response response = await dio.deleteUri(Uri.parse(url));
      print(response.data);
      if (response.statusCode == 200) {
        productResponse = true;
      } else {
        productResponse = false;
      }
    } catch (e) {
      throw Exception(e);
    }
    return productResponse;
  }
}
