import 'dart:convert';

import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class CartPostProvider extends ChangeNotifier {
    bool _successregister = true;


    bool _isRegistering = false;

bool get isRegistering => _isRegistering;
  bool get successregister => _successregister;

  void setRegistering(bool value) {
    _isRegistering = value;
    print(_isRegistering);
    notifyListeners();
  }
  Future<void> postCart(List<Map<String, String>> cartItems) async {
        setRegistering(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('Token');
      if (accessToken == null) {
        print("No Access Token Found");
      }
     
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var url = AppUrl.baseUrl + AppUrl.cart;
      var response =
          await http.post(Uri.parse(url), headers: headers, body: jsonEncode(cartItems));
      if (response.statusCode == 201) {
        print("Cart Added Successfully");
        var data = response.body;
        print("Dtaat:$data");
        print("hello");
         setRegistering(true);
        _successregister = true;
      }else{
        _successregister = false;
        print('There is something wrong in Cart!!!');
      }
            notifyListeners();

    } catch (e) {
      print(e.toString());
    }
  }
}
