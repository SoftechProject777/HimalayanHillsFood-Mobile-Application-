import 'dart:convert';
import 'package:eccomerce/Models/category_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  CategoryModel? categories;
  Future<void> fetchcategory() async {
    try {
      const url = AppUrl.baseUrl + AppUrl.category;
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      // print(json['data']);
      categories = CategoryModel.fromJson(json);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
