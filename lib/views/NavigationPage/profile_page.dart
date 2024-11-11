import 'dart:io';

import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/helper/custom_profile.dart';
import 'package:eccomerce/provider/changepassword_provider.dart';
import 'package:eccomerce/provider/houseownerimage_provider.dart';
import 'package:eccomerce/provider/loggeduser_provider.dart';
import 'package:eccomerce/provider/password_provider.dart';
import 'package:eccomerce/utils/validator.dart';
import 'package:flutter/material.dart';

import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _temporaryAddressController =
      TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();

  bool _isEditingDateOfBirth = true;
  bool _isEditingPhoneNumber = true;
  final bool _isEditingEmail = true;
  bool _isTemporaryAddress = true;
  bool _isPermanentAddress = true;

  picker.NepaliDateTime? _selectedDateTime;

  Future<void> _selectDate(BuildContext context) async {
    final NepaliDateTime? picked = await picker.showAdaptiveDatePicker(
      context: context,
      initialDate: picker.NepaliDateTime.now(),
      firstDate: picker.NepaliDateTime(2000),
      lastDate: picker.NepaliDateTime(2090),
      language: picker.Language.nepali, // Set language to English
    );

    if (picked != null && picked != _selectedDateTime) {
      setState(() {
        _selectedDateTime = picked;
        _dateOfBirthController.text = picked.format("yyyy-MM-dd");
        print("selectedDate::$_selectedDateTime");
        print("_dateofbirthController::$_dateOfBirthController");
      });
    }
  }

  

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Token');
    return token != null && token.isNotEmpty;
  }

  final newpasswordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.shade200.withOpacity(
                    0.94), // Change the color and opacity as needed
                BlendMode.srcATop, // Experiment with different blend modes
              ),
              child: Image.asset(
                'assets/background.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.03),
                  child: Align(
                    alignment: Alignment.center,
                    child: Consumer<HouseOwnerImageProvider>(
                      builder: (context, value, child) {
                        return Stack(
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.sizeOf(context).height * 0.08,
                              backgroundImage: value.image != null
                                  ? FileImage(value.image!)
                                  : const AssetImage('assets/persona2.jpg')
                                      as ImageProvider,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: ColorConstant.primaryColor,
                                child: IconButton(
                                  onPressed: () {
                                    value.getImageGallery();
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white, size: 20),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              
                Consumer<LoggedUserProvider>(
                  builder: (context, loggedValue, child) {
                    bool isUserDataAvailable =
                        loggedValue.loggedUsers?.user != null;
                    return FutureBuilder<bool>(
                      future: isLoggedIn(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // or any loading indicator
                        } else if (snapshot.hasData && snapshot.data == true) {
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  isUserDataAvailable
                                      ? loggedValue.loggedUsers!.user!.name
                                          .toString()
                                      : "Name",
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Center(
                                child: Text(
                                  isUserDataAvailable
                                      ? loggedValue.loggedUsers!.user!.email
                                          .toString()
                                      : "example@gmail.com",
                                  style: const TextStyle(fontSize: 13),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Column(
                            children: [
                              Center(
                                child: Text(
                                  "Name",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "example@gmail.com",
                                  style: TextStyle(fontSize: 13),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    );
                  },
                ),

            
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.03 ),
                  height: MediaQuery.sizeOf(context).height * 0.56,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.02,
                      vertical: MediaQuery.sizeOf(context).height * 0.03,
                      ),
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      // bottomLeft: Radius.circular(25),
                      // bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Contact Information',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
              
                      Row(
                        children: [
                          const Custom_Profile(
                            text: 'Date of Birth',
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.001),
                            child: _isEditingDateOfBirth
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: MediaQuery.sizeOf(context).height *
                                            0.02,
                                        left: MediaQuery.sizeOf(context).width *
                                            0.07),
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    height: MediaQuery.of(context).size.height *
                                        0.055,
                                    child: TextFormField(
                                      onTap: () async {
                                        // Show date picker when tapping the text field
                                        await _selectDate(context);
                                        print(
                                            "Date Time::${_dateOfBirthController.text}");
                                      },
                                      controller: _dateOfBirthController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            await _selectDate(context);
                                          },
                                          icon:
                                              const Icon(Icons.calendar_month),
                                        ),
                                        hintText: 'Enter Date of Birth',
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        hintStyle: const TextStyle(
                                            color: Colors.black),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2,
                                              color: Colors.redAccent),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isEditingDateOfBirth = true;
                                      });
                                    },
                                    child: const Custom_Profile2(text1: ''),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.04),
                        child: Row(
                          children: [
                            const Custom_Profile(
                              text: 'Phone Number',
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.001),
                                child: _isEditingPhoneNumber
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.02,
                                            left: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.03),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _phoneNumberController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            hintText: 'Enter a Phone no.',
                                            border: InputBorder.none,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            hintStyle: const TextStyle(
                                                color: Colors.black),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Colors.redAccent),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            _isEditingPhoneNumber = true;
                                          });
                                        },
                                        child: const Custom_Profile2(text1: ''),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
            
                 
                      Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.04),
                        child: Row(
                          children: [
                            const Custom_Profile(
                              text: 'Temporary Address',
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.001),
                                child: _isTemporaryAddress
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.02,
                                            left: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.03),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextFormField(
                                          controller:
                                              _temporaryAddressController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            hintText:
                                                'Enter a Temporary Address',
                                            border: InputBorder.none,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            hintStyle: const TextStyle(
                                                color: Colors.black),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Colors.redAccent),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            _isTemporaryAddress = true;
                                          });
                                        },
                                        child: const Custom_Profile2(text1: ''),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.04),
                        child: Row(
                          children: [
                            const Custom_Profile(
                              text: 'Permanent Address',
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.001),
                                child: _isPermanentAddress
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.02,
                                            left: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.03),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextFormField(
                                          controller:
                                              _permanentAddressController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            hintText:
                                                'Enter a Permanent Address',
                                            border: InputBorder.none,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            hintStyle: const TextStyle(
                                                color: Colors.black),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Colors.redAccent),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            _isPermanentAddress = true;
                                          });
                                        },
                                        child: const Custom_Profile2(text1: ''),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: TextButton(
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String? token = prefs.getString('Token');
                                print("thisd is the token::$token");
                                if (token != null && token.isNotEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Change Password'),
                                        content: SizedBox(
                                          width: double.infinity,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.2,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Consumer<PasswordProvider>(
                                                    builder: (context,
                                                        passwordProvider,
                                                        child) {
                                                  return SizedBox(
                                                    // color: Colors.red,
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    child: TextFormField(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      obscureText:
                                                          passwordProvider
                                                              .isShowPassword,
                                                      // controller: controller,
                                                      obscuringCharacter: '*',
                                                      decoration:
                                                          InputDecoration(
                                                        // contentPadding: EdgeInsets.all(
                                                        //     MediaQuery.sizeOf(context)
                                                        //             .height *
                                                        //         0.025),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        label: const Text(
                                                          "New Password",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        prefixIcon: const Icon(
                                                            Icons.lock),
                                                        suffixIcon: IconButton(
                                                            onPressed: () {
                                                              passwordProvider
                                                                  .showPassword();
                                                            },
                                                            icon: Icon(
                                                              passwordProvider
                                                                      .isShowPassword
                                                                  ? Icons
                                                                      .visibility
                                                                  : Icons
                                                                      .visibility_off,
                                                            )),
                                                      ),
                                                      validator: FormValidator
                                                          .validatePassword,
                                                      controller:
                                                          newpasswordcontroller,
                                                    ),
                                                  );
                                                }),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Consumer<PasswordProvider>(
                                                    builder: (context,
                                                        passwordProvider,
                                                        child) {
                                                  return SizedBox(
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    // color: Colors.red,
                                                    child: TextFormField(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      obscureText:
                                                          passwordProvider
                                                              .isShowPassword,
                                                      // controller: controller,
                                                      obscuringCharacter: '*',
                                                      decoration:
                                                          InputDecoration(
                                                        // contentPadding: EdgeInsets.all(
                                                        //     MediaQuery.sizeOf(context)
                                                        //             .height *
                                                        //         0.025),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        label: const Text(
                                                          "Confirm Password",
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        prefixIcon: const Icon(
                                                            Icons.lock),
                                                        suffixIcon: IconButton(
                                                            onPressed: () {
                                                              passwordProvider
                                                                  .showPassword();
                                                            },
                                                            icon: Icon(
                                                              passwordProvider
                                                                      .isShowPassword
                                                                  ? Icons
                                                                      .visibility
                                                                  : Icons
                                                                      .visibility_off,
                                                            )),
                                                      ),
                                                      validator: FormValidator
                                                          .validatePassword,
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
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      // color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Consumer<ChangePasswordProvider>(
                                                builder:
                                                    (context, value, child) {
                                                  return MaterialButton(
                                                    hoverColor: Colors.green,
                                                    color: Colors.amber,
                                                    onPressed: () async {
                                                      await value.changePassword(
                                                          newpasswordcontroller
                                                              .text,
                                                          confirmpasswordcontroller
                                                              .text);
                                                      if (value.successlogin ==
                                                          true) {
                                                        Navigator.pushNamed(
                                                            context, 'login');
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                              content: Row(
                                                                children: [
                                                                  Text(
                                                                      "Password has been Changed"),
                                                                ],
                                                              )),
                                                        );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              duration:
                                                                  Durations
                                                                      .long1,
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
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Login Required'),
                                        content: const Text(
                                            'You need to login to change the password.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              // Navigate to login screen
                                              // Navigator.pushNamed(context, 'login');
                                            },
                                            child: const Text('Later'),
                                          ),
                                          MaterialButton(
                                            hoverColor: Colors.green,
                                            color: Colors.amber,
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, "login");
                                            },
                                            child: const Text(
                                              "Login",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors
                                    .transparent, // Set background color to transparent
                                splashFactory: NoSplash
                                    .splashFactory, // Disable splash effect
                              ),
                              child: const Text(
                                "Change Password",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ))),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width * 0.3,
                        ),
                        child: MaterialButton(
                          height: 40,
                          minWidth: double.infinity,
                          color: ColorConstant.secondaryColor,
                          splashColor: ColorConstant.primaryColor,
                          onPressed: () async {
                            // await googleSignInProvider.logout();
                            // Get SharedPreferences instance
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
            
                            // Remove the token
                            await prefs.remove('Token');
            
                            // Navigate to login screen
                            Navigator.pushNamed(context, 'login');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: ColorConstant.whiteColor,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        // child: Consumer<GoogleSignInProvider>(
                        //   builder: (context, googleSignInProvider, child) {
                        //     return MaterialButton(
                        //       height: 40,
                        //       minWidth: double.infinity,
                        //       color: ColorConstant.secondaryColor,
                        //       splashColor: ColorConstant.primaryColor,
                        //       onPressed: () async {
                        //         await googleSignInProvider.logout();
                        //         // Get SharedPreferences instance
                        //         SharedPreferences prefs =
                        //             await SharedPreferences.getInstance();
            
                        //         // Remove the token
                        //         await prefs.remove('Token');
            
                        //         // Navigate to login screen
                        //         Navigator.pushNamed(context, 'login');
                        //       },
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //       child: Text(
                        //         'Logout',
                        //         style: TextStyle(
                        //           color: ColorConstant.whiteColor,
                        //           fontSize: 17,
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                 
                    ],
                  ),
                ),
                         ],
            ),
          ),
        ],
      ),
    );
  }
}
