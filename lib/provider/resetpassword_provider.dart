import 'dart:convert';
import 'package:eccomerce/Models/loggeduser_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordProvider extends ChangeNotifier {
  bool _successlogin = false;
  bool _isLoggingin = false;

  bool get successlogin => _successlogin;
  bool get isLogginging => _isLoggingin;
  setLoggin(bool value) {
    _isLoggingin = value;
    print(_isLoggingin);
    notifyListeners();
  }

  Future<void> restPassword1(
      String email) async {
    final prefs = await SharedPreferences.getInstance();
    // final String? accessToken = prefs.getString('Token');
    setLoggin(true);

    // await Future.delayed(Duration(seconds: 2));
    try {
      var body = {
        "email": email,
      };
      var url = AppUrl.baseUrl + AppUrl.resetpassword1;
      var response = await http.post(Uri.parse(url),
          body:
              body); // this body is the data we are adding through the code above
      if (response.statusCode == 200) {
        print('You have logged in');
        var data = jsonDecode(response.body);
        String token = data['token'];
        print('You have logged in::::$token');
        _successlogin = true;
        print("helow");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('ForgotToken', token);
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
  Future<void> restPassword2(String password, String confirmpassword) async {
    final prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('ForgotToken');
    setLoggin(true);

    // await Future.delayed(Duration(seconds: 2));
    try {
      var body = {
        "password": password,
        "password_confirmation": confirmpassword,
      };
      var url = "${AppUrl.baseUrl}${AppUrl.resetpassword2}$accessToken";
      var response = await http.post(Uri.parse(url),
          body:body); // this body is the data we are adding through the code above
      if (response.statusCode == 200) {
        print('You have logged in');
        var data = jsonDecode(response.body);
        String token = data['token'];
        print('You have logged in::::$token');
        _successlogin = true;
        print("helow");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('ForgotToken', token);
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
