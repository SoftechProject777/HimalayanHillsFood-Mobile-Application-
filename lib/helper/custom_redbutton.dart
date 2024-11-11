import 'package:eccomerce/constant/color_constant.dart';
import 'package:flutter/material.dart';

class Custom_Redbutton extends StatelessWidget {
  final String text;
  final double? height;
  final double? minWidth;
  final void Function()? onPressed;
  final int? fontSize;

  const Custom_Redbutton({
    super.key,
    required this.text,
    this.height,
    this.minWidth,
    this.onPressed,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: minWidth,
      color: Colors.red,
      splashColor: Colors.grey,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: ColorConstant.whiteColor,
        ),
      ),
    );
  }
}