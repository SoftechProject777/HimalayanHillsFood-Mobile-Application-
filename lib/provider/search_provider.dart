import 'package:eccomerce/provider/allproduct_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search_provider extends ChangeNotifier {
  bool _isSearching = true;
  bool get isSearching => _isSearching;

  search() {
    _isSearching = !_isSearching;
    notifyListeners();
  }
}

class Search_provider1 extends ChangeNotifier {
  final AllproductProvider allproductProvider;

  Search_provider1(this.allproductProvider);

  List<Map<String, dynamic>> _filteredProductsList = [];
  List<Map<String, dynamic>> get filteredProductsList => _filteredProductsList;

  Future<void> fetchproducts() async {
    await allproductProvider.fetchproducts();
    _filteredProductsList = List.from(allproductProvider.products!.data ?? []);
    print("abcfgfgrgrgrgg:$allproductProvider");
    notifyListeners();
  }

  void filterProducts(String searchText) {
      allproductProvider.setfilteredProduct(allproductProvider.filteredoutProduct
        .where((product) =>
            product.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList());
 
  }
}
