import 'package:eccomerce/views/ForgotPasswordPage/forgot_page.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/checkout.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/contactus.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/descripition.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/privacypolicy.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/notification.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/order.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/payment.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/review.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/shop.dart';
import 'package:eccomerce/views/NavigationPage/cart_page.dart';
import 'package:eccomerce/views/NavigationPage/home_page.dart';
import 'package:eccomerce/views/bottom_navexample.dart';
import 'package:eccomerce/views/splash_screen.dart';
import 'views/LoginPage/login_page.dart';
import 'views/SignupPage/signup_page.dart';

final routes = {
  "/": (context) => const HomePage(),
  'home': (context) => const HomePage(),
  'login': (context) => const LoginPage(),
  'signup': (context) => const SignUpPage(),
  'forgot': (context) => const ForgotPage(),
  'bottomnavbar': (context) => const BottomNav(),
  'notification': (context) => const Notificationn(),
  'checkout': (context) => const CashOnDelivery(),
  'payment': (context) => const Payment(),
  'review': (context) => const Review(),
  'order':(context)=>const Order(),
  'shop': (context) => const Shop(),
  'cart': (context) => const CartPage(),
  'splash':(context)=> const SplashScreen(),
  'privacy':(context)=>const PrivacyPolicy(),
  'contactus':(context)=>const ContactUs(),
  // 'description': (context) => Description(),
  // 'tabbar': (context) => TabBarExample(),
  // 'dashboard': (context) => DashboardPage(),
};
