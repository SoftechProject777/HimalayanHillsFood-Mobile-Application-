


import 'package:eccomerce/Models/wishlist_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class WishlistProvider extends ChangeNotifier {
  WishlistModel? wishlists;

  
  Future<void> fetchwishlist() async {
    try {
      const url = AppUrl.baseUrl + AppUrl.wishlist;
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('helo kmo: ${json['data']}');
        wishlists = WishlistModel.fromJson(json);
        notifyListeners();
        
      } else {
        print("Failed to load wishlist from network");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}