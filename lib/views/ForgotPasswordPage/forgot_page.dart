import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/helper/custom_button1.dart';
import 'package:eccomerce/helper/custom_textfield1.dart';
import 'package:eccomerce/provider/changepassword_provider.dart';
import 'package:eccomerce/provider/password_provider.dart';
import 'package:eccomerce/provider/resetpassword_provider.dart';
import 'package:eccomerce/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailcontroller = TextEditingController();
    final newpasswordcontroller = TextEditingController();
    final confirmpasswordcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // toolbarHeight: ,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 0,
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.25,
                width: MediaQuery.sizeOf(context).width * 0.7,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Please enter your email address below. You will receive a link to reset your password.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomTextField1(
                fieldText: 'Email',
                prefixIcon: const Icon(Icons.email),
                validator: FormValidator.validateEmail,
                controller: emailcontroller,
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<ResetPasswordProvider>(
                builder: (context, value, child) {
                  return CustomButton1(
                    onPressed: () async {
                      await value.restPassword1(emailcontroller.text);
                      if (value.successlogin == true) {
                        // Navigator.pushNamed(context, 'login');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Password Reset'),
                              content: SizedBox(
                                width: MediaQuery.sizeOf(context).width*0.65 ,
                                height: MediaQuery.sizeOf(context).height * 0.2,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Consumer<PasswordProvider>(builder:
                                          (context, passwordProvider, child) {
                                        return SizedBox(
                                          width: MediaQuery.sizeOf(context).width,
                                          // height: MediaQuery.sizeOf(context).height*0.01,
                                          // color: Colors.red,
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            obscureText:
                                                passwordProvider.isShowPassword,
                                            // controller: controller,
                                            obscuringCharacter: '*',
                                            decoration: InputDecoration(
                                              // contentPadding: EdgeInsets.all(
                                              //     MediaQuery.sizeOf(context)
                                              //             .height *
                                              //         0.025),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              label: const Text(
                                                "New Password",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              prefixIcon:
                                                  const Icon(Icons.lock),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    passwordProvider
                                                        .showPassword();
                                                  },
                                                  icon: Icon(
                                                    passwordProvider
                                                            .isShowPassword
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                  )),
                                            ),
                                            validator:
                                                FormValidator.validatePassword,
                                            controller: newpasswordcontroller,
                                          ),
                                        );
                                      }),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Consumer<PasswordProvider>(builder:
                                          (context, passwordProvider, child) {
                                        return SizedBox(
                                                                                    width:
                                              MediaQuery.sizeOf(context).width,
                                          // color: Colors.red,
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            obscureText:
                                                passwordProvider.isShowPassword,
                                            // controller: controller,
                                            obscuringCharacter: '*',
                                            decoration: InputDecoration(
                                              // contentPadding: EdgeInsets.all(
                                              //     MediaQuery.sizeOf(context)
                                              //             .height *
                                              //         0.025),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              label: const Text(
                                                "Confirm Password",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              prefixIcon:
                                                  const Icon(Icons.lock),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    passwordProvider
                                                        .showPassword();
                                                  },
                                                  icon: Icon(
                                                    passwordProvider
                                                            .isShowPassword
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                  )),
                                            ),
                                            validator:
                                                FormValidator.validatePassword,
                                            controller:
                                                confirmpasswordcontroller,
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // Navigate to login screen
                                        // Navigator.pushNamed(context, 'login');
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            // color: Colors.white,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Consumer<ResetPasswordProvider>(
                                      builder: (context, value, child) {
                                        return MaterialButton(
                                          hoverColor: Colors.green,
                                          color: Colors.amber,
                                          onPressed: () async {
                                            await value.restPassword2(
                                                newpasswordcontroller.text,
                                                confirmpasswordcontroller.text);
                                            if (value.successlogin == true) {
                                              Navigator.pushNamed(
                                                  context, 'login');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    duration:
                                                        Duration(seconds: 2),
                                                    content: Row(
                                                      children: [
                                                        Text(
                                                            "Password has been Reset"),
                                                      ],
                                                    )),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    duration: Durations.long1,
                                                    content: Row(
                                                      children: [
                                                        Text(
                                                            "Something Went Wrong"),
                                                      ],
                                                    )),
                                              );
                                            }
                                            // Navigator.pushNamed(
                                            //     context, "login");
                                          },
                                          child: const Text(
                                            "Submit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        );
                        
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              duration: Durations.long1,
                              content: Row(
                                children: [
                                  Text("Something Went Wrong"),
                                ],
                              )),
                        );
                      }
                    },
                    margin: const EdgeInsets.all(12),
                    textcolor: Colors.black,
                    btnText: Text(
                      'Reset Password',
                      style: TextStyle(
                          color: ColorConstant.whiteColor, fontSize: 24),
                    ),
                    // marginSize: 10,
                    width: double.infinity,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
