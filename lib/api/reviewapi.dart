import 'dart:convert';
import 'dart:io';

import 'package:clothingrental/models/review.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/httpservices.dart';

import 'package:mime/mime.dart';
import '../models/review.dart';
import '../response/reviewreponse.dart';
import '../utils/url.dart';
import 'package:http_parser/http_parser.dart';

class ReviewAPI {

  Future<List<Review>?> getReviewForProduct(String id) async {
    Future.delayed(const Duration(seconds: 2), () {});
    List<Review>? reviewResponse;
    try {
      var url = baseUrl + getProductReview + id;

      var dio = HttpServices().getInstance();
      Response response = await dio.getUri(Uri.parse(url));
      print(response);
      if (response.statusCode == 200) {
        reviewResponse = ReviewResopnse.fromJson(response.data).review;
      } else {
        reviewResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return reviewResponse;
  }

  Future<bool> createReview(Review review) async {
    Future.delayed(const Duration(seconds: 2), () {});
    try {
      var url = baseUrl + addReview;

      var dio = HttpServices().getInstance();

      final prefs = await SharedPreferences.getInstance();
      final user = await prefs.get("LOGGED_IN_USER");
      String token = json.decode(user.toString())["token"];
      print(token);
      dio.options.headers["Authorization"] = "Bearer ${token}";
      Response response = await dio.post(url, data: review.toJson());
      print(response);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      throw Exception(e);
    }
  }
  //
  // Future<bool> deleteReview(Review review)  async{
  //   bool reviewResponse= false;
  //   try {
  //     var url = baseUrl + removeReview + review.id!;
  //     var dio = HttpServices().getInstance();
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     final user = await prefs.get("LOGGED_IN_USER");
  //     String token = json.decode(user.toString())["token"];
  //     dio.options.headers["Authorization"] = "Bearer ${token}";
  //
  //     Response response = await dio.deleteUri(Uri.parse(url));
  //     print(response.data);
  //     if (response.statusCode == 200) {
  //       reviewResponse = true;
  //     } else {
  //       reviewResponse = false;
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  //   return reviewResponse;
  // }
}
