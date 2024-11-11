import 'package:eccomerce/provider/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField2 extends StatelessWidget {
  final String fieldText;
  final Icon prefixIcon;
  // final IconData? suffixIcon;

  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomTextField2({
    super.key,
    required this.fieldText,
    required this.prefixIcon,
    // this.suffixIcon,
    this.textInputType,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordProvider>(
      builder: (context, passwordProvider, child) => Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: passwordProvider.isShowPassword,
          controller: controller,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.025),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            label: Text(
              fieldText,
              style: const TextStyle(fontSize: 20),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: IconButton(
                onPressed: () {
                  passwordProvider.showPassword();
                },
                icon: Icon(
                  passwordProvider.isShowPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                )),
          ),
          validator: validator,
        ),
      ),
    );
  }
}
