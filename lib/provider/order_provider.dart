import 'dart:convert';

import 'package:eccomerce/Models/order_model.dart';
import 'package:eccomerce/Models/orderdetail_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class OrderProvider extends ChangeNotifier {
  bool _successlogin = false;
  bool get successlogin => _successlogin;
  OrderModel? orders;
  OrderDetailModel? orderdetails;
  

  Future<void> fetchOrder(int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('Token');
      if (accessToken == null) {
        print("No Access Token Found");
      }
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      var url = "${AppUrl.baseUrl}${AppUrl.order}${userId.toString()}";
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('helo kordermo: ${json['data']}');
        orders = OrderModel.fromJson(json);
        print("Order Fetched Successfully");
        // var data = response.body;
        _successlogin = true;
        // print("Dtaat:$data");
        print("hello");
      } else {
        print("Error while fetching Product from Order");
        _successlogin = false;
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }


  Future<void> fetchParticularOrder(String cartId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('Token');
      if (accessToken == null) {
        print("No Access Token Found");
      }
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      var url = "${AppUrl.baseUrl}${AppUrl.orderdetail}${cartId.toString()}";
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('helo korderparticularmo: ${json['data']}');
        orderdetails = OrderDetailModel.fromJson(json);
                // orderDetails[cartId] = OrderDetailModel.fromJson(json);

        print("Order Particular Fetched Successfully");
        // var data = response.body;
        _successlogin = true;
        // print("Dtaat:$data");
        print("hello");
      } else {
        print("Error while fetching Product from Order");
        _successlogin = false;
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}

