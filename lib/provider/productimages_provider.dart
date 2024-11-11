import 'dart:convert';

import 'package:eccomerce/Models/product_model.dart';
import 'package:eccomerce/Models/productimage_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductImageProvider extends ChangeNotifier {
  ProductImageModel? productimage;
  bool _isLoading = false;
  bool get isLoading=>_isLoading;
  Future<void> fetchproductimage() async {
    // Future<void> fetchproductimage(int productId) async {
       _isLoading = true;

    try {
      print("Try Block Start");
      const url = AppUrl.baseUrl + AppUrl.productimage;
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      print("FUNGU:${json['data']}");
      productimage = ProductImageModel.fromJson(json);
             _isLoading = false;
      notifyListeners();
    } catch (e) {
                   _isLoading = false;
      notifyListeners();
      print("ERROR SANDEEP${e.toString()}");
    }
  }
}
