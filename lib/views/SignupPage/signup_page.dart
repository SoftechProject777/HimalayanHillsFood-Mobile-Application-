import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/helper/custom_button1.dart';
import 'package:eccomerce/helper/custom_textfield1.dart';
import 'package:eccomerce/helper/custom_textfield2forpassword.dart';
import 'package:eccomerce/provider/password_provider.dart';
import 'package:eccomerce/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.shade200.withOpacity(
                    0.96), // Change the color and opacity as needed
                BlendMode.srcATop, // Experiment with different blend modes
              ),
              child: Image.asset(
                'assets/background.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  // Container(
                  //   height: MediaQuery.sizeOf(context).height * 0.25,
                  //   width: MediaQuery.sizeOf(context).width * 0.7,
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey.shade100,
                  //       borderRadius: BorderRadius.circular(50)),
                  //   child: const Image(
                  //     height: 180,
                  //     width: 200,
                  //     image: AssetImage("assets/favicon.png"),
                  //   ),
                  // ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.25,
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 8))
                        ],
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Image(
                      height: 180,
                      width: 200,
                      image: AssetImage("assets/favicon.png"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField1(
                      fieldText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                      controller: namecontroller),
                  CustomTextField1(
                    validator: FormValidator.validateEmail,
                    textInputType: TextInputType.emailAddress,
                    fieldText: 'Email Address',
                    prefixIcon: const Icon(Icons.email),
                    controller: emailcontroller,
                  ),
                  CustomTextField1(
                      fieldText: 'Address',
                      prefixIcon: const Icon(Icons.location_city),
                      controller: addresscontroller),
                  CustomTextField1(
                      fieldText: 'Contact No.',
                      prefixIcon: const Icon(Icons.phone),
                      controller: mobilecontroller),
                  CustomTextField2(
                    fieldText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    validator: FormValidator.validatePassword,
                    controller: passwordcontroller,
                  ),
                  CustomTextField2(
                    fieldText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock),
                    validator: FormValidator.validatePassword,
                    controller: confirmpasswordcontroller,
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Consumer<RegisteredProvider>(
                    builder: (context, provider, child) => CustomButton1(
                      onPressed: () async {
                        await provider.register(
                            namecontroller.text,
                            emailcontroller.text,
                            addresscontroller.text,
                            mobilecontroller.text,
                            passwordcontroller.text,
                            confirmpasswordcontroller.text);
                        if (provider.successregister == true) {
                          print('hello Aryan Rijal ');
                          Navigator.pushNamed(context, 'login');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text(provider.loginMessage)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                duration: Durations.long1,
                                content: Text(provider.loginMessage)),
                          );
                        }
                      },
                      margin: const EdgeInsets.all(12),
                      textcolor: Colors.black,
                      btnText: provider.isRegistering
                          ? CircularProgressIndicator(
                              color: ColorConstant.whiteColor,
                            )
                          : Text(
                              "Sign Up",
                              style: TextStyle(
                                color: ColorConstant.whiteColor,
                                fontSize: 24,
                              ),
                            ),
                      width: double.infinity,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: Text(
                      "Registered Customer?",
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
