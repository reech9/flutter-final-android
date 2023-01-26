import 'dart:io';

// import '../model/dropdown_category.dart';
import '../api/productapi.dart';
import '../api/reviewapi.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../response/productresponse.dart';

class ReviewRepository {
  // Future<bool> addReview(File? file, Review product) async {
  //   return ReviewAPI().addReview(file, product);
  // }
  //
  // Future<bool> editReview(Review product) async {
  //   return ReviewAPI().editReview( product);
  // }
  //
  // Future<bool> deleteReview(Review product) async {
  //   return ReviewAPI().deleteReview( product);
  // }
  //
  //
  // Future<List<Review>?> getReviews() async {
  //   return ReviewAPI().getReviews();
  // }
  //
  //
  // Future<List<Review>?> getReviewFromCategory(String categoryId) async {
  //   return ReviewAPI().getReviewFromCategory(categoryId);
  // }
  //
  //
  // Future<List<Review>?> getUserReview() async {
  //   return ReviewAPI().getUserReview();
  // }
  //
  //
  Future<List<Review>?> getReviewForProduct(String id) async {
    return ReviewAPI().getReviewForProduct(id);
  }

  Future<bool> createReview(Review review) async {
    return ReviewAPI().createReview(review);
  }
}
