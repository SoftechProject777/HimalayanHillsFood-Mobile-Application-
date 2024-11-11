// import 'dart:math';
// import 'package:eccomerce/Models/brand_model.dart';
// import 'package:eccomerce/constant/app_urls.dart';
// import 'package:eccomerce/helper/custom_button_homepage.dart';
// import 'package:eccomerce/helper/custom_redbutton.dart';
// import 'package:eccomerce/provider/allproduct_provider.dart';
// import 'package:eccomerce/provider/brand_provider.dart';
// import 'package:eccomerce/views/NavigationPage/SecondaryPages/descripition.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class Custom_Grid extends StatefulWidget {
//   final Axis axisDirection;
//   final int crossAxisCount;
//   final double childAspectRatio;
//   final double mainAxisSpacing;
//   final double crossAxisSpacing;
//   final double? height;
//   final double? width;

//   const Custom_Grid(
//       {super.key,
//       required this.axisDirection,
//       required this.crossAxisCount,
//       required this.childAspectRatio,
//       required this.mainAxisSpacing,
//       required this.crossAxisSpacing,
//       this.height,
//       this.width});

//   @override
//   State<Custom_Grid> createState() => _Custom_GridState();
// }

// class _Custom_GridState extends State<Custom_Grid> {
//   bool loading = false;

//   @override
//   void initState() {
   
//     super.initState();
  
//     getProduct();
//   }

//   void getProduct() async {
//     if (loading == false) {
//       loading = true;
//       await Provider.of<AllproductProvider>(context, listen: false)
//           .fetchproducts()
//           .then((value) {
//         loading = false;
//       }).catchError((error) {
//         SnackBar(content: Text('$error'));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AllproductProvider>(
//       builder: (context, value, child) {
//         if(value.products==null){}
//         return Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.only(
//             left: MediaQuery.sizeOf(context).width * 0.027,
//             right: MediaQuery.sizeOf(context).width * 0.027,
           
//           ),
//           height: widget.height,
//           width: widget.width,
//           child: GridView.builder(
//               scrollDirection: widget.axisDirection,
//               // scrollDirection: axisDirection!,
//               itemCount: min(value.products.data!.length, 10),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: widget.crossAxisCount,
//                   crossAxisSpacing: widget.crossAxisSpacing,
//                   mainAxisSpacing: widget.mainAxisSpacing,
//                   childAspectRatio: widget.childAspectRatio),
//               itemBuilder: (context, i) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade200,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                           offset: const Offset(3, 2),
//                           color: Colors.grey.shade300,
//                           spreadRadius: 1,
//                           blurRadius: 5)
//                     ],
//                   ),
                 
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
                     
//                       Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               topRight: Radius.circular(15),
//                             ),
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => Description(
//                                         product: value.products.data![i]),
//                                   ),
//                                 );
//                               },

//                               child: SizedBox(
//                                 height:
//                                     MediaQuery.sizeOf(context).height * 0.17,
//                                 child: Image.network(
//                                   AppUrl.baseUrl +
//                                       value.products.data![i].image
//                                           .toString(),
//                                   height: MediaQuery.of(context).size.height *
//                                       0.17,
//                                   width: MediaQuery.of(context).size.width,
//                                   fit: BoxFit.contain,
//                                   errorBuilder: (BuildContext context,
//                                       Object exception,
//                                       StackTrace? stackTrace) {
//                                     // Here you return your fallback image when the network image fails to load
//                                     return Image.asset(
//                                       'assets/agricultural.jpg', // The path to your local asset image
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.17,
//                                       width:
//                                           MediaQuery.of(context).size.width,
//                                       fit: BoxFit.cover,
//                                     );
//                                   },
//                                 ),
                                
//                               ),
//                               // image:  NetworkImage(AppUrl.baseUrl+value.products!.data![i].image.toString() ?? 'assets/chana.png',)),
//                             ),
//                           ),
//                           if (value.products.data![i].qty.toString() == "0")
//                             Align(
//                               alignment: Alignment.center,
//                               child: Container(
//                                 padding: const EdgeInsets.all(5),
//                                 decoration: const BoxDecoration(
//                                   color: Colors.red,
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(12),
//                                     bottomRight: Radius.circular(12),
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'OUT OF STOCK',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
                     
//                       // ),
//                       Padding(
//                         padding: EdgeInsets.all(
//                             MediaQuery.sizeOf(context).width * 0.001),
//                         child: Text(
//                           value.products.data![i].title,
//                           style: const TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold),
//                           maxLines: 1,
//                         ),
//                       ),
                      
//                       Consumer<BrandProvider>(
//                         builder: (context, brandValue, child) {
//                           var brandID = value.products.data?[i]
//                               .brandId; // Safely access brandId
//                           if (brandID != null &&
//                               brandValue.brands?.data != null) {
//                             var brand = brandValue.brands!.data!.firstWhere(
//                               (element) => element.id == brandID,
//                               orElse: () => BrandData(),
//                             );
//                             return Text(brand.title ?? 'Unknown Brand');
//                           } else {
//                             return const Text('Unknown Brand');
//                           }
//                         },
//                       ),
                     
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           if (double.parse(
//                                   value.products.data![i].discount ?? '0') >
//                               0) ...[
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: Text(
//                                 'Rs.${value.products.data![i].price}',
//                                 style: const TextStyle(
//                                     decoration: TextDecoration.lineThrough,
//                                     color: Colors.grey,
//                                     fontSize: 15),
//                               ),
//                             ),
//                           ],
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left:
//                                     MediaQuery.sizeOf(context).width * 0.01),
//                             child: Text(
//                               'Rs.${(double.parse(value.products.data![i].price) - ((double.parse(value.products.data![i].discount ?? '0') / 100) * double.parse(value.products.data![i].price))).toStringAsFixed(2)}',
//                               style: const TextStyle(
//                                   fontSize: 16, color: Colors.amber),
//                               // style: TextStyle(
//                               //     decoration: TextDecoration.lineThrough),
//                             ),
//                           ),
//                         ],
//                       ),
                     
//                       Container(
//                         padding: EdgeInsets.all(
//                             MediaQuery.sizeOf(context).width * 0.005),
//                         alignment: Alignment.center,
//                         child: RatingBar.builder(
//                             wrapAlignment: WrapAlignment.center,
//                             ignoreGestures: true,
//                             itemSize: 25,
//                             initialRating: 3.5,
//                             minRating: 1,
//                             direction: Axis.horizontal,
//                             allowHalfRating: true,
//                             itemCount: 5,
//                             itemPadding: EdgeInsets.only(
//                                 left:
//                                     MediaQuery.sizeOf(context).width * 0.015),
//                             itemBuilder: (context, _) => const Icon(
//                                   Icons.star,
//                                   color: Colors.amber,
//                                 ),
//                             onRatingUpdate: (rating) {
//                               print(rating);
//                             }),
//                       ),
//                       value.products.data![i].qty.toString() == "0"
//                           ? Container(
//                               padding: EdgeInsets.only(
//                                   top: MediaQuery.sizeOf(context).height *
//                                       0.004),
//                               alignment: Alignment.center,
//                               child: Custom_Redbutton(
//                                 text: 'OUT OF STOCK',
//                                 onPressed: () {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         duration: Duration(seconds: 2),
//                                         content: Text('OUT OF STOCK!')),
//                                   );
//                                 },
//                               ),
//                             )
//                             : Container(
//                               padding: EdgeInsets.all(
//                                   MediaQuery.sizeOf(context).width * 0.001),
//                               alignment: Alignment.center,
//                               child: Custom_Button_Homepage(
//                                 text: 'ADD TO CART',
//                                 onPressed: () async {
//                                   SharedPreferences prefs =
//                                       await SharedPreferences.getInstance();
//                                   String? token = prefs.getString('Token');
//                                   print("thisd is the token::$token");
//                                   if (token != null && token.isNotEmpty) {
//                                     // User is logged in, proceed with adding to cart
//                                     var box = await Hive.openBox('box');
//                                     List<dynamic> cartItems = box.get('cart',
//                                         defaultValue: <dynamic>[]).cast<dynamic>();
//                                     // Implement your cart logic here
//                                     // Assuming `value.products!.data![i].id` is accessible
//                                     // Example logic:
//                                     if (!cartItems.contains(
//                                         value.products.data![i].id)) {
//                                       cartItems
//                                           .add(value.products.data![i].id);
//                                       await box.put('cart', cartItems);
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                             content: Text('Added to cart!')),
//                                       );
//                                       print(cartItems);
//                                     } else {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                             content:
//                                                 Text('Item already in cart')),
//                                       );
//                                       print(cartItems);
//                                     }
//                                   } else {
//                                     // User is not logged in, show dialog
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('Login Required'),
//                                           content: const Text(
//                                               'You need to login to add the product to your cart.'),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                                 // Navigate to login screen
//                                                 // Navigator.pushNamed(context, 'login');
//                                               },
//                                               child: const Text('Later'),
//                                             ),
//                                             MaterialButton(
//                                               hoverColor: Colors.green,
//                                               color: Colors.amber,
//                                               onPressed: () {
//                                                 Navigator.pushNamed(
//                                                     context, "login");
//                                               },
//                                               child: const Text(
//                                                 "Login",
//                                                 style: TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   }
//                                 },
//                               ),
//                             ),
                      
//                     ],
//                   ),
//                 );
//               }),
//         );
//             },
//     );
//   }
// }

import 'dart:math';
import 'package:eccomerce/Models/brand_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/helper/custom_button_homepage.dart';
import 'package:eccomerce/helper/custom_redbutton.dart';
import 'package:eccomerce/provider/allproduct_provider.dart';
import 'package:eccomerce/provider/brand_provider.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/descripition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

// class Custom_Grid extends StatefulWidget {
//   final Axis axisDirection;
//   final int crossAxisCount;
//   final double childAspectRatio;
//   final double mainAxisSpacing;
//   final double crossAxisSpacing;
//   final double? height;
//   final double? width;

//   const Custom_Grid(
//       {super.key,
//       required this.axisDirection,
//       required this.crossAxisCount,
//       required this.childAspectRatio,
//       required this.mainAxisSpacing,
//       required this.crossAxisSpacing,
//       this.height,
//       this.width});

//   @override
//   State<Custom_Grid> createState() => _Custom_GridState();
// }

// class _Custom_GridState extends State<Custom_Grid> {
//   bool loading = false;

//   @override
//   void initState() {
//     super.initState();
//     getProduct();
//   }

//   void getProduct() async {
//     if (loading == false) {
//       loading = true;
//       await Provider.of<AllproductProvider>(context, listen: false)
//           .fetchproducts()
//           .then((value) {
//         loading = false;
//       }).catchError((error) {
//         SnackBar(content: Text('$error'));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AllproductProvider>(
//       builder: (context, value, child) {
//         return Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.only(
//             left: MediaQuery.sizeOf(context).width * 0.027,
//             right: MediaQuery.sizeOf(context).width * 0.027,
//           ),
//           height: widget.height,
//           width: widget.width,
//           child: GridView.builder(
//             scrollDirection: widget.axisDirection,
//             itemCount: min(value.products.data!.length, 10),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: widget.crossAxisCount,
//               crossAxisSpacing: widget.crossAxisSpacing,
//               mainAxisSpacing: widget.mainAxisSpacing,
//               childAspectRatio: widget.childAspectRatio,
//             ),
//             itemBuilder: (context, i) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       offset: const Offset(3, 2),
//                       color: Colors.grey.shade300,
//                       spreadRadius: 1,
//                       blurRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(15),
//                             topRight: Radius.circular(15),
//                           ),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Description(
//                                       product: value.products.data![i]),
//                                 ),
//                               );
//                             },
//                             child: SizedBox(
//                               height:
//                                   MediaQuery.sizeOf(context).height * 0.17,
//                               child: Image.network(
//                                 AppUrl.baseUrl +
//                                     value.products.data![i].image.toString(),
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.17,
//                                 width: MediaQuery.of(context).size.width,
//                                 fit: BoxFit.contain,
//                                 errorBuilder: (BuildContext context,
//                                     Object exception,
//                                     StackTrace? stackTrace) {
//                                   return Image.asset(
//                                     'assets/agricultural.jpg',
//                                     height:
//                                         MediaQuery.of(context).size.height *
//                                             0.17,
//                                     width: MediaQuery.of(context).size.width,
//                                     fit: BoxFit.cover,
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         if (value.products.data![i].qty.toString() == "0")
//                           Align(
//                             alignment: Alignment.center,
//                             child: Container(
//                               padding: const EdgeInsets.all(5),
//                               decoration: const BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(12),
//                                   bottomRight: Radius.circular(12),
//                                 ),
//                               ),
//                               child: const Text(
//                                 'OUT OF STOCK',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(
//                           MediaQuery.sizeOf(context).width * 0.001),
//                       child: Text(
//                         value.products.data![i].title,
//                         style: const TextStyle(
//                           overflow: TextOverflow.ellipsis,
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 1,
//                       ),
//                     ),
//                     Consumer<BrandProvider>(
//                       builder: (context, brandValue, child) {
//                         var brandID = value.products.data?[i].brandId;
//                         if (brandID != null &&
//                             brandValue.brands?.data != null) {
//                           var brand = brandValue.brands!.data!.firstWhere(
//                             (element) => element.id == brandID,
//                             orElse: () => BrandData(),
//                           );
//                           return Text(brand.title ?? 'Unknown Brand');
//                         } else {
//                           return const Text('Unknown Brand');
//                         }
//                       },
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         if (double.parse(
//                                 value.products.data![i].discount ?? '0') >
//                             0) ...[
//                           Padding(
//                             padding: const EdgeInsets.only(right: 8.0),
//                             child: Text(
//                               'Rs.${value.products.data![i].price}',
//                               style: const TextStyle(
//                                 decoration: TextDecoration.lineThrough,
//                                 color: Colors.grey,
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ),
//                         ],
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: MediaQuery.sizeOf(context).width * 0.01),
//                           child: Text(
//                             'Rs.${(double.parse(value.products.data![i].price) - ((double.parse(value.products.data![i].discount ?? '0') / 100) * double.parse(value.products.data![i].price))).toStringAsFixed(2)}',
//                             style: const TextStyle(
//                                 fontSize: 16, color: Colors.amber),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(
//                           MediaQuery.sizeOf(context).width * 0.005),
//                       alignment: Alignment.center,
//                       child: RatingBar.builder(
//                         wrapAlignment: WrapAlignment.center,
//                         ignoreGestures: true,
//                         itemSize: 25,
//                         initialRating: 3.5,
//                         minRating: 1,
//                         direction: Axis.horizontal,
//                         allowHalfRating: true,
//                         itemCount: 5,
//                         itemPadding: EdgeInsets.only(
//                             left: MediaQuery.sizeOf(context).width * 0.015),
//                         itemBuilder: (context, _) => const Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                         ),
//                         onRatingUpdate: (rating) {
//                           print(rating);
//                         },
//                       ),
//                     ),
//                     value.products.data![i].qty.toString() == "0"
//                         ? Container(
//                             padding: EdgeInsets.only(
//                                 top: MediaQuery.sizeOf(context).height *
//                                     0.004),
//                             alignment: Alignment.center,
//                             child: Custom_Redbutton(
//                               text: 'OUT OF STOCK',
//                               onPressed: () {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       duration: Duration(seconds: 2),
//                                       content: Text('OUT OF STOCK!')),
//                                 );
//                               },
//                             ),
//                           )
//                         : Container(
//                             padding: EdgeInsets.all(
//                                 MediaQuery.sizeOf(context).width * 0.001),
//                             alignment: Alignment.center,
//                             child: Custom_Button_Homepage(
//                               text: 'ADD TO CART',
//                               onPressed: () async {
//                                 SharedPreferences prefs =
//                                     await SharedPreferences.getInstance();
//                                 String? token = prefs.getString('Token');
//                                 print("thisd is the token::$token");
//                                 if (token != null && token.isNotEmpty) {
//                                   var box = await Hive.openBox('box');
//                                   List<dynamic> cartItems = box.get('cart',
//                                       defaultValue: <dynamic>[]).cast<dynamic>();
//                                   if (!cartItems
//                                       .contains(value.products.data![i].id)) {
//                                     cartItems.add(value.products.data![i].id);
//                                     await box.put('cart', cartItems);
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(
//                                       const SnackBar(
//                                           content: Text('Added to cart!')),
//                                     );
//                                     print(cartItems);
//                                   } else {
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(
//                                       const SnackBar(
//                                           content:
//                                               Text('Item already in cart')),
//                                     );
//                                     print(cartItems);
//                                   }
//                                 } else {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         title: const Text('Login Required'),
//                                         content: const Text(
//                                             'You need to login to add the product to your cart.'),
//                                         actions: <Widget>[
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: const Text('Later'),
//                                           ),
//                                           MaterialButton(
//                                             hoverColor: Colors.green,
//                                             color: Colors.amber,
//                                             onPressed: () {
//                                               Navigator.pushNamed(
//                                                   context, "login");
//                                             },
//                                             child: const Text(
//                                               "Login",
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 }
//                               },
//                             ),
//                           ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//             },
//     );
//   }
// }

class Custom_Grid extends StatefulWidget {
  final Axis axisDirection;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double? height;
  final double? width;

  const Custom_Grid(
      {super.key,
      required this.axisDirection,
      required this.crossAxisCount,
      required this.childAspectRatio,
      required this.mainAxisSpacing,
      required this.crossAxisSpacing,
      this.height,
      this.width});

  @override
  State<Custom_Grid> createState() => _Custom_GridState();
}

class _Custom_GridState extends State<Custom_Grid> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  void getProduct() async {
    if (loading == false) {
      setState(() {
        loading = true;
      });
      await Provider.of<AllproductProvider>(context, listen: false)
          .fetchproducts()
          .then((value) {
        setState(() {
          loading = false;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$error')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllproductProvider>(
      builder: (context, value, child) {
        if (loading) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.41,
            child: GridView.builder(
              scrollDirection: widget.axisDirection,
              itemCount: 10, // Adjust the number of shimmer items here
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                crossAxisSpacing: widget.crossAxisSpacing,
                mainAxisSpacing: widget.mainAxisSpacing,
                childAspectRatio: widget.childAspectRatio,
              ),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (value.products.data == null ||
            value.products.data!.isEmpty) {
          return const Center(child: Text('No products available'));
        } else {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: MediaQuery.sizeOf(context).width * 0.027,
              right: MediaQuery.sizeOf(context).width * 0.027,
            ),
            height: widget.height,
            width: widget.width,
            child: GridView.builder(
              scrollDirection: widget.axisDirection,
              itemCount: min(value.products.data!.length, 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                crossAxisSpacing: widget.crossAxisSpacing,
                mainAxisSpacing: widget.mainAxisSpacing,
                childAspectRatio: widget.childAspectRatio,
              ),
              itemBuilder: (context, i) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3, 2),
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Description(
                                        product: value.products.data![i]),
                                  ),
                                );
                              },
                              child: SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.17,
                                child: Image.network(
                                  AppUrl.baseUrl +
                                      value.products.data![i].image.toString(),
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.contain,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(
                                      'assets/agricultural.jpg',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.17,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          if (value.products.data![i].qty.toString() == "0")
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'OUT OF STOCK',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.sizeOf(context).width * 0.001),
                        child: Text(
                          value.products.data![i].title,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Consumer<BrandProvider>(
                        builder: (context, brandValue, child) {
                          var brandID = value.products.data?[i].brandId;
                          if (brandID != null &&
                              brandValue.brands?.data != null) {
                            var brand = brandValue.brands!.data!.firstWhere(
                              (element) => element.id == brandID,
                              orElse: () => BrandData(),
                            );
                            return Text(brand.title ?? 'Unknown Brand');
                          } else {
                            return const Text('Unknown Brand');
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (double.parse(
                                  value.products.data![i].discount ?? '0') >
                              0) ...[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Rs.${value.products.data![i].price}',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.sizeOf(context).width * 0.01),
                            child: Text(
                              'Rs.${(double.parse(value.products.data![i].price) - ((double.parse(value.products.data![i].discount ?? '0') / 100) * double.parse(value.products.data![i].price))).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.amber),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.sizeOf(context).width * 0.005),
                        alignment: Alignment.center,
                        child: RatingBar.builder(
                          wrapAlignment: WrapAlignment.center,
                          ignoreGestures: true,
                          itemSize: 25,
                          initialRating: 3.5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.only(
                              left: MediaQuery.sizeOf(context).width * 0.015),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      value.products.data![i].qty.toString() == "0"
                          ? Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.sizeOf(context).height *
                                      0.004),
                              alignment: Alignment.center,
                              child: Custom_Redbutton(
                                text: 'OUT OF STOCK',
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Text('OUT OF STOCK!')),
                                  );
                                },
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).width * 0.001),
                              alignment: Alignment.center,
                              child: Custom_Button_Homepage(
                                text: 'ADD TO CART',
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String? token = prefs.getString('Token');
                                  print("thisd is the token::$token");
                                  if (token != null && token.isNotEmpty) {
                                    var box = await Hive.openBox('box');
                                    List<dynamic> cartItems = box.get('cart',
                                        defaultValue: <dynamic>[]).cast<dynamic>();
                                    if (!cartItems
                                        .contains(value.products.data![i].id)) {
                                      cartItems.add(value.products.data![i].id);
                                      await box.put('cart', cartItems);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Added to cart!')),
                                      );
                                      print(cartItems);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Item already in cart')),
                                      );
                                      print(cartItems);
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Login Required'),
                                          content: const Text(
                                              'You need to login to add the product to your cart.'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
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
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
