
import 'dart:convert';
import 'package:eccomerce/Models/banner_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BannerProvider extends ChangeNotifier {
  BannerModel?
      banners; // This means that BannerModel can be null. Or also known as null safety "?"
  Future<void> fetchbanner() async {
    try {
      const url = AppUrl.baseUrl +
          AppUrl
              .banner; //Getting the base url and the banner url from the constant folder.
      final uri = Uri.parse(
          url); //uri variable is assigned using the final keyword. It cannot be changed after its been assigned. Then parse is used to get the url as uri.
      final response = await http.get(
          uri); //final keyword is used to assign the variable response. And since data takes time to be fetched we use async await method to get the data from the url through the assigned variable uri
      final json = jsonDecode(response
          .body); // final keyword is used to assign a variable json. And since the data which arrives can be changed to string due to the computer/ somthing. we use jsonDecode to change the fecthed data to json once more. And response.body is the part where datas are inside the [] and assigned through each index being mapped in {},{}per data mapped in json format
      banners = BannerModel.fromJson(json);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}