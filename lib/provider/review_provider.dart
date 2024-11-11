import 'dart:convert';
import 'package:eccomerce/Models/review_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReviewProvider extends ChangeNotifier {
  // List<String>? brandTitles;
  // List<int>? brandID;
  ReviewModel? reviews;
  Future<void> fetchreview() async {
    try {
      const url = AppUrl.baseUrl + AppUrl.review;
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      print('Hello this is the review part:${json['data']}');
      reviews = ReviewModel.fromJson(json);
      print('This is the View print part:$reviews');
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}