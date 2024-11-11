import 'dart:convert';
import 'package:eccomerce/Models/loggeduser_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordProvider extends ChangeNotifier {
  bool _successlogin = false;
  bool _isLoggingin = false;

  bool get successlogin => _successlogin;
  bool get isLogginging => _isLoggingin;
  setLoggin(bool value) {
    _isLoggingin = value;
    print(_isLoggingin);
    notifyListeners();
  }

  Future<void> changePassword(
      String newpassword, String confirmpassword) async {
    final prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('Token');
    setLoggin(true);

    // await Future.delayed(Duration(seconds: 2));
    try {
      var body = {
        "password": newpassword,
        "password_confirmation": confirmpassword
      };
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var url = AppUrl.baseUrl + AppUrl.changepassword;
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body:
              body); // this body is the data we are adding through the code above
      if (response.statusCode == 200) {
        print('You have logged in');
       
        _successlogin = true;
        print("helow");
        
      } else {
        _successlogin = false;
        print('The User Credentials is wrong!!!');
      }
      notifyListeners();

      print(response.body);
    } catch (e) {
      print(e.toString());
    }
    setLoggin(false);
  }
}
