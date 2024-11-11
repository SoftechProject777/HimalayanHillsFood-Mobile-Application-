

import 'dart:convert';
import 'dart:developer';
import 'package:eccomerce/Models/product_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  ProductModel? _products;
  int? _subcategoryId; // Add this property

  ProductModel? get products => _products;

  Future<void> fetchProduct(
      {required String subcategory, int? subcategoryId}) async {
    try {
      log("Sub category$subcategory");
      log("Sub category id$subcategoryId");
      _subcategoryId = subcategoryId; // Set the subcategoryId
      final url = '${AppUrl.baseUrl}${AppUrl.product}?subcategory=$subcategory';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      if (json['data'] != null) {
        var data = json['data'];

        // Iterate through each product if 'data' is a list, or adjust according to your structure
        for (var product in data) {
          // Parse HTML content in the 'description' field
          if (product['description'] != null) {
            var descriptionDocument = parse(product['description']);
            // Extract text or perform other manipulations with the parsed HTML
            var descriptionText =
                descriptionDocument.body?.text ?? ""; // Extracts all text
            product['description'] =
                descriptionText; // Replace or adjust as necessary
          }

          // Repeat for the 'summary' field
          if (product['summary'] != null) {
            var summaryDocument = parse(product['summary']);
            var summaryText = summaryDocument.body?.text ?? "";
            product['summary'] = summaryText; // Replace or adjust as necessary
          }
          // After modifications, you might need to reassign or update your product model
          // This depends on your ProductModel and how it's structured
        }
      }
      log(json.toString());
      // Filter products based on subcategory
      List<ProductData>? filteredProducts = (json['data'] as List<dynamic>)
          .map((productJson) => ProductData.fromJson(productJson))
          .where((product) => product.subcategoryId == _subcategoryId)
          .toList();

      _products = ProductModel(data: filteredProducts);
      log(_products!.data!.length.toString());
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}


