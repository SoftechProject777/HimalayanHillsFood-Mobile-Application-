import 'dart:convert';
import 'package:eccomerce/Models/loggeduser_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoggedUserProvider extends ChangeNotifier {
  LoggedUserModel? loggedUsers;
  Future<void> fetchLoggedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? Token = prefs.getString('Token');
      print("This is the TOken of Himalayan Hills:::$Token");
      if (Token == null) {
        print("No Access Token Found");
        return;
      }
      const url = AppUrl.baseUrl + AppUrl.loggeduser;
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $Token'
      });
      print("Fucmdkdkd Hello::${response.statusCode}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        loggedUsers = LoggedUserModel.fromJson(json);
        print("User data loaded successfully: $loggedUsers");
        print("Fucmdkdkd Hello11");
      } else {
        print("Fucmdkdkd Hello33");
        print('Failed to fetch user: ${response.body}');
      }
      notifyListeners();
      print("Fucmdkdkd Hello22");
      
    } catch (e) {
      print(e.toString());
    }
  }
}
