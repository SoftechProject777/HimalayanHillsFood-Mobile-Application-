import 'dart:convert';

import 'package:eccomerce/constant/app_urls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordProvider extends ChangeNotifier {
  bool _isShowPassword = true;
  bool _isLoggingin = false;
  bool _successlogin = false;
  String _loginMessage = ""; 
  // bool _successregister = false;
  // bool get successregister => _successregister;
  bool get successlogin => _successlogin;
  bool get isShowPassword => _isShowPassword;
  bool get isLogginging => _isLoggingin;
   String get loginMessage => _loginMessage; 

  showPassword() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  setLoggin(bool value) {
    _isLoggingin = value;
    print(_isLoggingin);
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    setLoggin(true);

    // await Future.delayed(Duration(seconds: 2));
    try {
      var body = {"email": username, "password": password};
      var headers = {'Accept': 'application/json'};
      var url = AppUrl.baseUrl + AppUrl.login;
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body:
              body); // this body is the data we are adding through the code above
      if (response.statusCode == 200) {
        print('You have logged in');
        var data = jsonDecode(response.body);
        String token = data['token'];
          _loginMessage = data['message']; // Store the login message
        print('You have logged in::::$token');
        _successlogin = true;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('Token', token);
      } else {
        var data = jsonDecode(response.body);
        _loginMessage = data['message'] ??
            'The User Credentials is wrong!!!'; // Handle missing message
        _successlogin = false;
        print('The User Credentials is wrong!!!');
      }
      notifyListeners();

      print(response.body);
    } catch (e) {
      print(e.toString());
      _loginMessage =
          'An error occurred. Please try again.'; // Handle exceptions
      _successlogin = false;
      notifyListeners();
    }
    setLoggin(false);
  }

}

class RegisteredProvider extends ChangeNotifier {
  bool _successregister = true;
  bool _isRegistering = false;
  String _loginMessage = "";
 

  bool get successregister => _successregister;
  bool get isRegistering => _isRegistering;
   String get loginMessage => _loginMessage; 

  void setRegistering(bool value) {
    _isRegistering = value;
    print(_isRegistering);
    notifyListeners();
  }

  Future<void> register(String name, String email,String address, String mobile,String password,
      String confirmpassword) async {
    setRegistering(true);

    // await Future.delayed(Duration(seconds: 2));
    try {
      var body = {
        "name": name,
        "email": email,
        "address":address,
        "mobile":mobile,
        "password": password,
        "password_confirmation": confirmpassword
      };
      var headers = {'Accept': 'application/json'};
      var url = AppUrl.baseUrl + AppUrl.register;
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body:
              body); // this body is the data we are adding through the code above
      if (response.statusCode == 201) {
        print('You have logged in');
        var data = jsonDecode(response.body);
        String token = data['token'];
        _loginMessage = data['message'];
        print('You have logged in::::$token');
        setRegistering(true);
        _successregister = true;
      } else {
        var data = jsonDecode(response.body);
        _loginMessage = data['message'] ?? 'The User Credentials is wrong!!!';
        _successregister = false;
        print('The User Credentials is wrong!!!');
      }
      notifyListeners();

      print(response.body);
    } catch (e) {
      print(e.toString());
      _loginMessage =
          'An error occurred. Please try again.'; // Handle exceptions
      _successregister = false;
      // _successregister = false;
    } finally {
      setRegistering(false);
    }

    // notifyListeners();
  }
}

// class GoogleSignInProvider extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;
//    String? _userEmail;
//   GoogleSignInAccount get user => _user!;
//   String? get userEmail => _userEmail;
//   Future googleLogin() async {
//     try {
//       final googleUser = await googleSignIn.signIn();
//       if (googleUser == null) return;
//       _user = googleUser;

//       final googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       print('AccessToken: ${googleAuth.accessToken}');
//       print('IdToken: ${googleAuth.idToken}');
//       // print('User Email: ${credential.token}');

//       if (googleAuth.idToken != null) {
//         Map<String, dynamic> decodedToken =
//             JwtDecoder.decode(googleAuth.idToken!);
//         _userEmail = decodedToken['email'];
//       }
//       await FirebaseAuth.instance.signInWithCredential(credential);
//     } catch (e) {
//       print(e.toString());
//     }
//     notifyListeners();
//   }

//   Future logout() async {
//     await googleSignIn.disconnect();
//     FirebaseAuth.instance.signOut();
//      _userEmail = null;
//     notifyListeners();
//   }
// }
