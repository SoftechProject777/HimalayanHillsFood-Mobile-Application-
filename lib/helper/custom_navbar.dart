import 'package:flutter/material.dart';

class CustomNavBarItem {
  final Widget icon;
  final Widget? title;
  final Color selectedcolor;
  final Color unselectedcolor;
  final Color backgroundcolor;

  CustomNavBarItem({
    required this.backgroundcolor,
    required this.icon,
    required this.title,
    required this.selectedcolor,
    required this.unselectedcolor,
  });
}
