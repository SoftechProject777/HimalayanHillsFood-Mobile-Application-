import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WishlistAddProductProvider extends ChangeNotifier {
  Future<void> addWishlist(String userId, String productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('Token');
      if (accessToken == null) {
        print("No Access Token Found");
      }
      var body = {
        "user_id": userId,
        "product_id": productId,
      };
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var url = AppUrl.baseUrl + AppUrl.addwishlist;
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 201) {
        print("Wishlist Added Successfully");
        var data = response.body;
        print("Dtaat:$data");
        print("hello");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class WishlistDeleteProductProvider extends ChangeNotifier {
  bool _successlogin = false;
  bool get successlogin => _successlogin;

  Future<void> deleteWishlist(int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('Token');
      if (accessToken == null) {
        print("No Access Token Found");
      }
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var url =
          "${AppUrl.baseUrl}${AppUrl.deletewishlist}${userId.toString()}";
      var response = await http.delete(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print("Wishlist Deleted Successfully");
        var data = response.body;
        _successlogin = true;
        print("Dtaat:$data");
        print("hello");

      } else {
        print("Error while deleting Product from Wishlist");
        _successlogin = false;
      }
            notifyListeners();

    } catch (e) {
      print(e.toString());
    }
  }
}

