// import 'package:eccomerce/helper/custom_listtile_drawer.dart';
// import 'package:eccomerce/provider/loggeduser_provider.dart';
// import 'package:eccomerce/provider/order_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DrawerTab extends StatefulWidget {
//   const DrawerTab({super.key});

//   @override
//   State<DrawerTab> createState() => _DrawerTabState();
// }

// class _DrawerTabState extends State<DrawerTab> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // Provider.of<LoggedUserProvider>(context, listen: false).fetchLoggedUser();
//   }

//   Future<bool> isLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('Token');
//     return token != null && token.isNotEmpty;
//   }
//   @override
//   Widget build(BuildContext context) {
//     final loggedUserProvider =
//         Provider.of<LoggedUserProvider>(context, listen: false);
//     final orderProvider = Provider.of<OrderProvider>(context, listen: false);
//     return Drawer(
//       width: MediaQuery.sizeOf(context).width * 0.7,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.sizeOf(context).height * 0.02,
//               top: MediaQuery.sizeOf(context).height * 0.03,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//             ),
//             child: Consumer<LoggedUserProvider>(
//               builder: (context, loggedValue, child) {
//                 bool isUserDataAvailable =
//                     loggedValue.loggedUsers?.user != null;
//                 return FutureBuilder<bool>(
//                   future: isLoggedIn(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator(); // or any loading indicator
//                     } else if (snapshot.hasData && snapshot.data == true) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     MediaQuery.sizeOf(context).width * 0.17),
//                             child: Image.asset(
//                               'assets/favicon.png',
//                               width: MediaQuery.sizeOf(context).width * 0.5,
//                               height: MediaQuery.sizeOf(context).height * 0.142,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: MediaQuery.sizeOf(context).width * 0.05,
//                                 top: MediaQuery.sizeOf(context).height * 0.015),
//                             child: Text(
//                               isUserDataAvailable
//                                   ? loggedValue.loggedUsers!.user!.name
//                                       .toString()
//                                   : "Name",
//                               style: const TextStyle(fontSize: 16),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: MediaQuery.sizeOf(context).width * 0.05),
//                             child: Text(
//                               isUserDataAvailable
//                                   ? loggedValue.loggedUsers!.user!.email
//                                       .toString()
//                                   : "example@gmail.com",
//                               style: const TextStyle(fontSize: 13),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                         ],
//                       );
//                     } else {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     MediaQuery.sizeOf(context).width * 0.17),
//                             child: Image.asset(
//                               'assets/favicon.png',
//                               width: MediaQuery.sizeOf(context).width * 0.5,
//                               height: MediaQuery.sizeOf(context).height * 0.142,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: MediaQuery.sizeOf(context).width * 0.05,
//                                 top: MediaQuery.sizeOf(context).height * 0.015),
//                             child: const Text(
//                               "Name",
//                               style: TextStyle(fontSize: 16),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: MediaQuery.sizeOf(context).width * 0.05),
//                             child: const Text(
//                               "example@gmail.com",
//                               style: TextStyle(fontSize: 13),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                         ],
//                       );
//                     }
//                   },
//                 );
//                 // return Column(
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: [
//                 //     Container(
//                 //       padding: EdgeInsets.symmetric(
//                 //           horizontal: MediaQuery.sizeOf(context).width * 0.17),
//                 //       child: Image.asset(
//                 //         'assets/favicon.png',
//                 //         width: MediaQuery.sizeOf(context).width * 0.5,
//                 //         height: MediaQuery.sizeOf(context).height * 0.142,
//                 //       ),
//                 //     ),
//                 //     Padding(
//                 //       padding: EdgeInsets.only(
//                 //           left: MediaQuery.sizeOf(context).width * 0.05,
//                 //           top: MediaQuery.sizeOf(context).height * 0.015),
//                 //       child:  Text(
//                 //         isUserDataAvailable
//                 //         ? loggedValue.loggedUsers!.user!.name.toString():"Name",
//                 //         style: const TextStyle(fontSize: 16),
//                 //         textAlign: TextAlign.left,
//                 //       ),
//                 //     ),
//                 //     Padding(
//                 //       padding: EdgeInsets.only(
//                 //           left: MediaQuery.sizeOf(context).width * 0.05),
//                 //       child:  Text(
//                 //         isUserDataAvailable
//                 //         ? loggedValue.loggedUsers!.user!.email.toString():"example@gmail.com",
//                 //         style: const TextStyle(fontSize: 13),
//                 //         textAlign: TextAlign.left,
//                 //       ),
//                 //     ),
//                 //   ],
//                 // );
//               },
//             ),
//           ),
//           // DrawerHeader(
//           //   decoration: BoxDecoration(
//           //     color: Color.fromARGB(255, 19, 35, 211),
//           //     image: DecorationImage(
//           //       image: AssetImage('res/emblem1.png'),
//           //     ),
//           //   ),
//           //   child: SizedBox(),
//           // ),
//           Custom_Listtile_Drawer(
//             text: 'Home',
//             iconn: Icons.home,
//             onTap: () {
//               Navigator.pushNamed(context, 'bottomnavbar');
//             },
//           ),

//           Custom_Listtile_Drawer(
//               iconn: Icons.shopping_bag,
//               text: 'Shop',
//               onTap: () {
//                 Navigator.pushNamed(context, 'shop');
//               }),
//           Custom_Listtile_Drawer(
//               iconn: Icons.list,
//               text: 'Orders',
//               onTap: () async {
//                 await loggedUserProvider.fetchLoggedUser();
//                 if (loggedUserProvider.loggedUsers != null &&
//                     loggedUserProvider.loggedUsers!.user != null) {
//                   await orderProvider
//                       .fetchOrder(loggedUserProvider.loggedUsers!.user!.id!);
//                   Navigator.pushNamed(context, 'order');
//                 }

//                 // Navigator.pushNamed(context, 'order');
//               }),
//           // Custom_Listtile_Drawer(
//           //   iconn: Icons.payment,
//           //   text: 'Review Transactions',
//           //   onTap: () {},
//           //   // onTap: () {
//           //   //   Navigator.pushNamed(context, 'review');
//           //   // },
//           // ),
//           // Custom_Listtile_Drawer(
//           //     iconn: Icons.attach_money,
//           //     text: 'Payment',
//           //     onTap: () {
//           //       Navigator.pushNamed(context, 'payment');
//           //     }),
//           Custom_Listtile_Drawer(iconn: Icons.info, text: 'Info', onTap: () {}),
//           Custom_Listtile_Drawer(
//               iconn: Icons.settings,
//               text: 'Setting',
//               onTap: () {
//                 print("hello ho");
//                 print(
//                     "hello this is the logged Drawer User ${loggedUserProvider.loggedUsers!.user!.id!}");
//               }),
//           Custom_Listtile_Drawer(iconn: Icons.help, text: 'Help', onTap: () {}),

//           // Custom_Listtile_Drawer(
//           //     iconn: Icons.login,
//           //     text: 'Login',
//           //     onTap: () {
//           //       Navigator.pushNamed(context, "login");
//           //     }),
//           FutureBuilder<bool>(
//             future: isLoggedIn(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircularProgressIndicator(); // or any loading indicator
//               } else if (snapshot.hasData && snapshot.data == true) {
//                 return Custom_Listtile_Drawer(
//                   iconn: Icons.logout,
//                   text: 'Logout',
//                   onTap: () async {
//                     SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                     await prefs.remove('Token');
//                     Navigator.pushNamed(context, "login");
//                   },
//                 );
//               } else {
//                 return Custom_Listtile_Drawer(
//                   iconn: Icons.login,
//                   text: 'Login',
//                   onTap: () {
//                     Navigator.pushNamed(context, "login");
//                   },
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:eccomerce/helper/custom_listtile_drawer.dart';
// import 'package:eccomerce/provider/loggeduser_provider.dart';
// import 'package:eccomerce/provider/order_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DrawerTab extends StatefulWidget {
//   const DrawerTab({super.key});

//   @override
//   State<DrawerTab> createState() => _DrawerTabState();
// }

// class _DrawerTabState extends State<DrawerTab> {
//   late Future<bool> _loginStatusFuture;

//   @override
//   void initState() {
//     super.initState();
//     _loginStatusFuture = isLoggedIn();
//   }

//   Future<bool> isLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('Token');
//     return token != null && token.isNotEmpty;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loggedUserProvider =
//         Provider.of<LoggedUserProvider>(context, listen: false);
//     final orderProvider = Provider.of<OrderProvider>(context, listen: false);

//     return Drawer(
//       width: MediaQuery.sizeOf(context).width * 0.7,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.sizeOf(context).height * 0.02,
//               top: MediaQuery.sizeOf(context).height * 0.03,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//             ),
//             child: FutureBuilder<bool>(
//               future: _loginStatusFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator(); // or any loading indicator
//                 } else if (snapshot.hasData && snapshot.data == true) {
//                   return Consumer<LoggedUserProvider>(
//                     builder: (context, loggedValue, child) {
//                       bool isUserDataAvailable =
//                           loggedValue.loggedUsers?.user != null;
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     MediaQuery.sizeOf(context).width * 0.17),
//                             child: Image.asset(
//                               'assets/favicon.png',
//                               width: MediaQuery.sizeOf(context).width * 0.5,
//                               height: MediaQuery.sizeOf(context).height * 0.142,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: MediaQuery.sizeOf(context).width * 0.05,
//                                 top: MediaQuery.sizeOf(context).height * 0.015),
//                             child: Text(
//                               isUserDataAvailable
//                                   ? loggedValue.loggedUsers!.user!.name
//                                       .toString()
//                                   : "Name",
//                               style: const TextStyle(fontSize: 16),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: MediaQuery.sizeOf(context).width * 0.05),
//                             child: Text(
//                               isUserDataAvailable
//                                   ? loggedValue.loggedUsers!.user!.email
//                                       .toString()
//                                   : "example@gmail.com",
//                               style: const TextStyle(fontSize: 13),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 } else {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal:
//                                 MediaQuery.sizeOf(context).width * 0.17),
//                         child: Image.asset(
//                           'assets/favicon.png',
//                           width: MediaQuery.sizeOf(context).width * 0.5,
//                           height: MediaQuery.sizeOf(context).height * 0.142,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: MediaQuery.sizeOf(context).width * 0.05,
//                             top: MediaQuery.sizeOf(context).height * 0.015),
//                         child: const Text(
//                           "Name",
//                           style: TextStyle(fontSize: 16),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: MediaQuery.sizeOf(context).width * 0.05),
//                         child: const Text(
//                           "example@gmail.com",
//                           style: TextStyle(fontSize: 13),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//           Custom_Listtile_Drawer(
//             text: 'Home',
//             iconn: Icons.home,
//             onTap: () {
//               Navigator.pushNamed(context, 'bottomnavbar');
//             },
//           ),
//           Custom_Listtile_Drawer(
//               iconn: Icons.shopping_bag,
//               text: 'Shop',
//               onTap: () {
//                 Navigator.pushNamed(context, 'shop');
//               }),
//           Custom_Listtile_Drawer(
//               iconn: Icons.list,
//               text: 'Orders',
//               onTap: () async {
//                 await loggedUserProvider.fetchLoggedUser();
//                 if (loggedUserProvider.loggedUsers != null &&
//                     loggedUserProvider.loggedUsers!.user != null) {
//                   await orderProvider
//                       .fetchOrder(loggedUserProvider.loggedUsers!.user!.id!);
//                   Navigator.pushNamed(context, 'order');
//                 }
//               }),
//           Custom_Listtile_Drawer(iconn: Icons.info, text: 'Info', onTap: () {}),
//           Custom_Listtile_Drawer(
//               iconn: Icons.settings,
//               text: 'Setting',
//               onTap: () {
//                 print("hello ho");
//                 print(
//                     "hello this is the logged Drawer User ${loggedUserProvider.loggedUsers!.user!.id!}");
//               }),
//           Custom_Listtile_Drawer(iconn: Icons.help, text: 'Help', onTap: () {}),
//           FutureBuilder<bool>(
//             future: _loginStatusFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircularProgressIndicator(); // or any loading indicator
//               } else if (snapshot.hasData && snapshot.data == true) {
//                 return Custom_Listtile_Drawer(
//                   iconn: Icons.logout,
//                   text: 'Logout',
//                   onTap: () async {
//                     SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                     await prefs.remove('Token');
//                     Navigator.pushNamed(context, "login");
//                   },
//                 );
//               } else {
//                 return Custom_Listtile_Drawer(
//                   iconn: Icons.login,
//                   text: 'Login',
//                   onTap: () {
//                     Navigator.pushNamed(context, "login");
//                   },
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/helper/custom_listtile_drawer.dart';
import 'package:eccomerce/provider/loggeduser_provider.dart';
import 'package:eccomerce/provider/order_provider.dart';
import 'package:eccomerce/provider/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerTab extends StatefulWidget {
  const DrawerTab({super.key});

  @override
  State<DrawerTab> createState() => _DrawerTabState();
}

class _DrawerTabState extends State<DrawerTab> {
  late Future<void> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = fetchUserData();
  }

  Future<void> fetchUserData() async {
    final loggedUserProvider =
        Provider.of<LoggedUserProvider>(context, listen: false);
    await loggedUserProvider.fetchLoggedUser();
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Token');
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final loggedUserProvider =
        Provider.of<LoggedUserProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    // final googleSignInProvider = Provider.of<GoogleSignInProvider>(context,
    //     listen: false); // Get the existing provider

    return FutureBuilder<void>(
      future: _userDataFuture,
      builder: (context, snapshot) {
        return Drawer(
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: Column(
mainAxisAlignment: MainAxisAlignment.spaceBetween,            
children: [
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).height * 0.02,
                      top: MediaQuery.sizeOf(context).height * 0.03,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                    ),
                    child: Consumer<LoggedUserProvider>(
                      builder: (context, loggedValue, child) {
                        bool isUserDataAvailable =
                            loggedValue.loggedUsers?.user != null;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.sizeOf(context).width * 0.17),
                              child: Image.asset(
                                'assets/favicon.png',
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                height: MediaQuery.sizeOf(context).height * 0.142,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * 0.05,
                                  top: MediaQuery.sizeOf(context).height * 0.015),
                              child: Text(
                                isUserDataAvailable
                                    ? loggedValue.loggedUsers!.user!.name.toString()
                                    : "Name",
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * 0.05),
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
                      },
                    ),
                  ),
                  Custom_Listtile_Drawer(
                    text: 'Home',
                    iconn: Icons.home,
                    onTap: () {
                      Navigator.pushNamed(context, 'bottomnavbar');
                    },
                  ),
                  Custom_Listtile_Drawer(
                      iconn: Icons.shopping_bag,
                      text: 'Shop',
                      onTap: () {
                        Navigator.pushNamed(context, 'shop');
                      }),
                  Custom_Listtile_Drawer(
                      iconn: Icons.list,
                      text: 'My Orders',
                      onTap: () async {
                        await loggedUserProvider.fetchLoggedUser();
                        if (loggedUserProvider.loggedUsers != null &&
                            loggedUserProvider.loggedUsers!.user != null) {
                          await orderProvider.fetchOrder(
                              loggedUserProvider.loggedUsers!.user!.id!);
                          Navigator.pushNamed(context, 'order');
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Login Required'),
                                content: const Text(
                                    'You need to login to see the Orders.'),
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
                                      Navigator.pushNamed(context, "login");
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      }),
                  Custom_Listtile_Drawer(
                      iconn: Icons.security,
                      text: 'Privacy Policy',
                      onTap: () {
                        Navigator.pushNamed(context, 'privacy');
                      }),
                  // Consumer<GoogleSignInProvider>(
                  //   builder: (context, googleSignInProvider, child) => Text(
                  //     googleSignInProvider.userEmail ?? "No email",
                  //     style: const TextStyle(fontSize: 16),
                  //   ),
                  // ),
                  // Custom_Listtile_Drawer(
                  //     iconn: Icons.settings,
                  //     text: 'Setting',
                  //     onTap: () {
                  //       print("hello ho");
                  //       print(
                  //           "hello this is the logged Drawer User ${loggedUserProvider.loggedUsers!.user!.id!}");
                  //     }),
                  Custom_Listtile_Drawer(
                      iconn: Icons.call,
                      text: 'Contact Us',
                      onTap: () {
                        Navigator.pushNamed(context, 'contactus');
                      }),
                ],
              ),
                  FutureBuilder<bool>(
                    future: isLoggedIn(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // or any loading indicator
                      } else if (snapshot.hasData && snapshot.data == true) {
                        return Column(
                          children: [
                            Custom_Listtile_Drawer(
                              iconn: Icons.logout,
                              text: 'Logout',
                              onTap: () async {
                                // await googleSignInProvider.logout();
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.remove('Token');
                                Navigator.pushNamed(context, "login");
                              },
                            ),
                            // Consumer<GoogleSignInProvider>(
                            //   builder: (context, googleSignInProvider, child) =>
                            //       Custom_Listtile_Drawer(
                            //     iconn: Icons.logout,
                            //     text: 'Logout',
                            //     onTap: () async {
                            //       // await googleSignInProvider.logout();
                            //       SharedPreferences prefs =
                            //           await SharedPreferences.getInstance();
                            //       await prefs.remove('Token');
                            //       Navigator.pushNamed(context, "login");
                            //     },
                            //   ),
                            // ),
                          ],
                        );
                      } else {
                        return Custom_Listtile_Drawer(
                          iconn: Icons.login,
                          text: 'Login',
                          onTap: () {
                            Navigator.pushNamed(context, "login");
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
           
        );
      },
    );
  }
}

// import 'package:eccomerce/constant/color_constant.dart';
// import 'package:eccomerce/helper/custom_listtile_drawer.dart';
// import 'package:eccomerce/provider/loggeduser_provider.dart';
// import 'package:eccomerce/provider/order_provider.dart';
// import 'package:eccomerce/provider/password_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DrawerTab extends StatefulWidget {
//   const DrawerTab({super.key});

//   @override
//   State<DrawerTab> createState() => _DrawerTabState();
// }

// class _DrawerTabState extends State<DrawerTab> {
//   late Future<void> _userDataFuture;

//   @override
//   void initState() {
//     super.initState();
//     _userDataFuture = fetchUserData();
//   }

//   Future<void> fetchUserData() async {
//     final loggedUserProvider =
//         Provider.of<LoggedUserProvider>(context, listen: false);
//     await loggedUserProvider.fetchLoggedUser();
//   }

//   Future<bool> isLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('Token');
//     return token != null && token.isNotEmpty;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loggedUserProvider =
//         Provider.of<LoggedUserProvider>(context, listen: false);
//     final orderProvider = Provider.of<OrderProvider>(context, listen: false);

//     return FutureBuilder<void>(
//       future: _userDataFuture,
//       builder: (context, snapshot) {
//         // if (snapshot.connectionState == ConnectionState.waiting) {
//         //   return const Center(
//         //       child: CircularProgressIndicator()); // or any loading indicator
//         // } else {
//           return Drawer(
//             width: MediaQuery.sizeOf(context).width * 0.7,
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                     bottom: MediaQuery.sizeOf(context).height * 0.02,
//                     top: MediaQuery.sizeOf(context).height * 0.03,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                   ),
//                   child: Consumer<LoggedUserProvider>(
//                     builder: (context, loggedValue, child) {
//                       bool isUserDataAvailable =
//                           loggedValue.loggedUsers?.user != null;
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     MediaQuery.sizeOf(context).width * 0.17),
//                             child: Image.asset(
//                               'assets/favicon.png',
//                               width: MediaQuery.sizeOf(context).width * 0.5,
//                               height: MediaQuery.sizeOf(context).height * 0.142,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: MediaQuery.sizeOf(context).width * 0.05,
//                                 top: MediaQuery.sizeOf(context).height * 0.015),
//                             child: Text(
//                               isUserDataAvailable
//                                   ? loggedValue.loggedUsers!.user!.name
//                                       .toString()
//                                   : "Name",
//                               style: const TextStyle(fontSize: 16),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: MediaQuery.sizeOf(context).width * 0.05),
//                             child: Text(
//                               isUserDataAvailable
//                                   ? loggedValue.loggedUsers!.user!.email
//                                       .toString()
//                                   : "example@gmail.com",
//                               style: const TextStyle(fontSize: 13),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//                 Custom_Listtile_Drawer(
//                   text: 'Home',
//                   iconn: Icons.home,
//                   onTap: () {
//                     Navigator.pushNamed(context, 'bottomnavbar');
//                   },
//                 ),
//                 Custom_Listtile_Drawer(
//                     iconn: Icons.shopping_bag,
//                     text: 'Shop',
//                     onTap: () {
//                       Navigator.pushNamed(context, 'shop');
//                     }),
//                 Custom_Listtile_Drawer(
//                     iconn: Icons.list,
//                     text: 'Orders',
//                     onTap: () async {
//                       await loggedUserProvider.fetchLoggedUser();
//                       if (loggedUserProvider.loggedUsers != null &&
//                           loggedUserProvider.loggedUsers!.user != null) {
//                         await orderProvider.fetchOrder(
//                             loggedUserProvider.loggedUsers!.user!.id!);
//                         Navigator.pushNamed(context, 'order');
//                       }
//                     }),
//                 Custom_Listtile_Drawer(
//                     iconn: Icons.info, text: 'Info', onTap: () {}),
//                 Custom_Listtile_Drawer(
//                     iconn: Icons.settings,
//                     text: 'Setting',
//                     onTap: () {
//                       print("hello ho");
//                       print(
//                           "hello this is the logged Drawer User ${loggedUserProvider.loggedUsers!.user!.id!}");
//                     }),
//                 Custom_Listtile_Drawer(
//                     iconn: Icons.help, text: 'Help', onTap: () {}),
//                 FutureBuilder<bool>(
//                   future: isLoggedIn(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator(); // or any loading indicator
//                     } else if (snapshot.hasData && snapshot.data == true) {
//                       return Consumer<GoogleSignInProvider>(
//                       builder: (context, googleSignInProvider, child) =>
//                           Custom_Listtile_Drawer(
//                         iconn: Icons.logout,
//                         text: 'Logout',
//                         onTap: () async {
//                           await googleSignInProvider.logout();
//                           SharedPreferences prefs =
//                               await SharedPreferences.getInstance();
//                           await prefs.remove('Token');
//                           Navigator.pushNamed(context, "login");
//                         },
//                       ),
//                     );
//                       // return Custom_Listtile_Drawer(
//                       //   iconn: Icons.logout,
//                       //   text: 'Logout',
//                       //   onTap: () async {
//                       //     SharedPreferences prefs =
//                       //         await SharedPreferences.getInstance();
//                       //     await prefs.remove('Token');
//                       //     Navigator.pushNamed(context, "login");
//                       //   },
//                       // );
//                     } else {
//                       return Custom_Listtile_Drawer(
//                         iconn: Icons.login,
//                         text: 'Login',
//                         onTap: () {
//                           Navigator.pushNamed(context, "login");
//                         },
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           );
//         // }
//       },
//     );
//   }
// }
