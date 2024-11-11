import 'package:eccomerce/constant/color_constant.dart';
import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  final void Function()? onPressed;
  final Color textcolor;
  // final Gradient gradient;
  // final String name;
  final Widget btnText;
  final double? fontSize;
  final EdgeInsets margin;
  final double? height;
  final double? width;

  const CustomButton1({
    super.key,
    this.onPressed,
    required this.textcolor,
    // required this.gradient,
    required this.btnText,
    this.fontSize,
    // required this.marginSize,
    this.height,
    this.width,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: ColorConstant.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        minWidth: width,
        height: height,
        onPressed: onPressed,
        child: btnText,
      ),
    );
  }
}
