import 'dart:convert';
import 'package:eccomerce/Models/brand_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class BrandProvider extends ChangeNotifier {
  List<String>? brandTitles;
  List<int>? brandID;
  BrandModel? brands;
  Future<void> fetchbrand() async {
    try {
      const url = AppUrl.baseUrl + AppUrl.brand;
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      // print(json['data']);
      brands = BrandModel.fromJson(json);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}