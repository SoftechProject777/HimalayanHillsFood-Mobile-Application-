import 'package:flutter/material.dart';

class CustomTextField1 extends StatelessWidget {
  final String fieldText;
  final Icon prefixIcon;
  final IconButton? suffixIcon;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextField1({
    super.key,
    required this.fieldText,
    required this.prefixIcon,
    this.suffixIcon,
    this.textInputType,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.025),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          label: Text(
            fieldText,
            style: TextStyle(fontSize: 20),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }
}
