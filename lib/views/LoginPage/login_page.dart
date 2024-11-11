import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/helper/custom_button1.dart';
import 'package:eccomerce/helper/custom_social_button.dart';
import 'package:eccomerce/helper/custom_textfield1.dart';
import 'package:eccomerce/helper/custom_textfield2forpassword.dart';
import 'package:eccomerce/provider/password_provider.dart';
import 'package:eccomerce/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isTapped = false;

  void _changeColor() {
    setState(() {
      _isTapped = !_isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0.0,
      ),
      body: Stack(
        children:[Container(height: double.infinity,width: double.infinity,
          decoration: const BoxDecoration(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.shade200.withOpacity(0.96), // Change the color and opacity as needed
                BlendMode.srcATop, // Experiment with different blend modes
              ),
              child: Image.asset('assets/background.jpeg', fit: BoxFit.cover,),

            ),), SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                 SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.05,
                ),
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
                  height: 20,
                ),
                CustomTextField1(
                  fieldText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  validator: FormValidator.validateEmail,
                  controller: emailcontroller,
                ),
                CustomTextField2(
                  fieldText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  // suffixIcon: Icons.visibility,
                  validator: FormValidator.validatePassword,
                  controller: passwordcontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<PasswordProvider>(
                  builder: (context, provider, child) => CustomButton1(
                    onPressed: () async {
                      await provider.login(
                          emailcontroller.text, passwordcontroller.text);
                      if (provider.successlogin == true) {
                        Navigator.pushNamed(context, 'bottomnavbar');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              duration:  const Duration(seconds: 2),
                              content: Text(provider.loginMessage)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                              duration: Durations.long1,
                              content: Row(
                                children: [
                                  Text(provider.loginMessage),
                                ],
                              )),
                        );
                      }
                  
                    },
                    margin: const EdgeInsets.all(12),
                    textcolor: Colors.black,
                    btnText: provider.isLogginging
                        ? CircularProgressIndicator(
                            color: ColorConstant.whiteColor,
                          )
                        : Text(
                            "Login",
                            style: TextStyle(
                              color: ColorConstant.whiteColor,
                              fontSize: 24,
                            ),
                          ),
                    // marginSize: 10,
                    width: double.infinity,
                  ),
                ),
              
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'forgot');
                  },
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an acccount?',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'signup');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
        
               
              ],
            ),
          ),
        ),],
      ),
    );
  }
}
