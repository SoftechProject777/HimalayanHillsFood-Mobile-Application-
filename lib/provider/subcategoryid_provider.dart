import 'dart:convert';

import 'package:eccomerce/Models/subcategory_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubcategoryProvider extends ChangeNotifier {
  List<String>? subcategoryTitles;

  SubcategoryModel? subcategoriesid;
  Future<void> fetchSubCategoryid() async {
    try {
      const url = AppUrl.baseUrl + AppUrl.subcategoryid;
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      // print(json['data']);
      subcategoriesid = SubcategoryModel.fromJson(json);
      if (json['data'] != null) {
        subcategoryTitles = (json['data'] as List<dynamic>)
            .take(3)
            .map((data) => data['title'].toString())
            .toList();
      }
      // print(json['data']);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
