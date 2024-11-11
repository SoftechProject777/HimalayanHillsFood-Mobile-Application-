import 'dart:convert';
import 'package:eccomerce/Models/product_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';


class AllproductProvider extends ChangeNotifier {
  ProductModel products = ProductModel(data: []);
  List<ProductData> filteredProductModel = [];
  int _currentPage = 1;
  final int _itemsPerPage = 15;
  List<ProductData> paginatedProducts = [];

  ProductModel get allProducts => products;
  List<ProductData> get filteredoutProduct => filteredProductModel;
  List<ProductData> get currentPaginatedProducts => paginatedProducts;
  int get currentPage => _currentPage;
  int get itemsPerPage => _itemsPerPage;

  void setfilteredProduct(List<ProductData> filteredproduct) {
    filteredProductModel = filteredproduct;
    _currentPage = 1; // Reset to the first page whenever the filter changes
    _updatePaginatedProducts();
    notifyListeners();
  }

  void _updatePaginatedProducts() {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    paginatedProducts = filteredProductModel.sublist(
      startIndex,
      endIndex > filteredProductModel.length
          ? filteredProductModel.length
          : endIndex,
    );
    // notifyListeners();
  }

  void nextPage() {
    if (_currentPage * _itemsPerPage < filteredProductModel.length) {
      _currentPage++;
      _updatePaginatedProducts();
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      _updatePaginatedProducts();
      notifyListeners();
    }
  }

  Future<void> fetchproducts() async {
    // Your existing fetchproducts code...
    try {
      const url = AppUrl.baseUrl + AppUrl.product;
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      if (json['data'] != null) {
        var data = json['data'];
        for (var product in data) {
          if (product['description'] != null) {
            var descriptionDocument = parse(product['description']);
            var descriptionText = descriptionDocument.body?.text ?? "";
            product['description'] = descriptionText;
          }
          if (product['summary'] != null) {
            var summaryDocument = parse(product['summary']);
            var summaryText = summaryDocument.body?.text ?? "";
            product['summary'] = summaryText;
          }
        }
      }
      products = ProductModel.fromJson(json);
      setfilteredProduct(products.data!);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void search(String title) {
    if (title.isEmpty) {
      setfilteredProduct(products.data!);
    } else {
      setfilteredProduct(
        
        products.data!
            .where((product) =>
                product.title.toLowerCase().contains(title.toLowerCase()))
            .toList(),
      );
    }
  }
  List<ProductData> getSuggestions(String query) {
    if (query.isEmpty) {
      return [];
    } else {
      return products.data!
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void filterCategory(List<int> categoryIds) {
    List<ProductData> filteredProducts = [];
    if (categoryIds.isEmpty) {
      setfilteredProduct(products.data!);
    } else {
      for (var product in filteredoutProduct) {
        if (categoryIds.contains(product.categoryId)) {
          filteredProducts.add(product);
        }
      }
      setfilteredProduct(filteredProducts.isNotEmpty ? filteredProducts : []);
    }
  }

  void filterSubcategory(List<int> subcategoryId) {
    List<ProductData> filteredProducts = [];
    if (subcategoryId.isNotEmpty) {
      for (var product in filteredoutProduct) {
        if (subcategoryId.contains(product.subcategoryId)) {
          filteredProducts.add(product);
        }
      }
      setfilteredProduct(filteredProducts.isNotEmpty ? filteredProducts : []);
    } else {
      setfilteredProduct(products.data!);
    }
  }

  void filterBrand(List<int> brandId) {
    List<ProductData> filteredProducts = [];
    if (brandId.isNotEmpty) {
      for (var product in filteredoutProduct) {
        if (brandId.contains(product.brandId)) {
          filteredProducts.add(product);
        }
      }
      setfilteredProduct(filteredProducts.isNotEmpty ? filteredProducts : []);
    } else {
      setfilteredProduct(products.data!);
    }
  }
}
