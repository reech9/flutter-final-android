import 'dart:convert';

import '../models/review.dart';

ReviewResopnse reviewResopnseFromJson(String str) => ReviewResopnse.fromJson(json.decode(str));

String reviewResopnseToJson(ReviewResopnse data) => json.encode(data.toJson());

class ReviewResopnse {
  ReviewResopnse({
    required this.review,
  });

  List<Review> review;

  factory ReviewResopnse.fromJson(Map<String, dynamic> json) => ReviewResopnse(
    review: List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "review": List<dynamic>.from(review.map((x) => x.toJson())),
  };
}
