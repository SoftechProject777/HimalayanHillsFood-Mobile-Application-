

import 'dart:convert';
import 'package:eccomerce/Models/subcategory_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubcategoryProvider extends ChangeNotifier {
  List<String>? subcategoryTitles;
  List<int>? subcategoryID;
  var subcategories = SubcategoryModel();

  get subcategory => null;

  Future<void> fetchSubCategory() async {
    try {
      const url = AppUrl.baseUrl + AppUrl.subcategory;
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      subcategories = SubcategoryModel.fromJson(json);
   
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<int?> getSubcategoryId({required String subcategoryTitle}) async {
  //   try {
  //     // Implement your logic to get the subcategory ID based on the title
  //     // For example, you might iterate through subcategories and find the matching title
  //     // Replace the following lines with your actual implementation
  //     if (subcategories.data != null) {
  //       final matchingSubcategory = subcategories.data!.firstWhere(
  //           (subcategory) => subcategory.title == subcategoryTitle,
  //           orElse: () => Data());
  //       return matchingSubcategory.id;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
  //The above code doesnot do anything
}
