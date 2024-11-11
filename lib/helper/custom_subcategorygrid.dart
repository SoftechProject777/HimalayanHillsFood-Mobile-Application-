import 'package:eccomerce/Models/brand_model.dart';
import 'package:eccomerce/Models/product_model.dart';
import 'package:eccomerce/Models/subcategory_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/helper/custom_button_homepage.dart';
import 'package:eccomerce/helper/custom_redbutton.dart';
import 'package:eccomerce/provider/brand_provider.dart';
import 'package:eccomerce/provider/product_provider.dart';
import 'package:eccomerce/provider/subcategory_provider.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/descripition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Custom_SubcategoryGrid extends StatefulWidget {
  final Axis axisDirection;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double? height;
  final double? width;

  final Data datas;

  const Custom_SubcategoryGrid({
    super.key,
    required this.axisDirection,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.datas,
    this.height,
    this.width,
  });

  @override
  State<Custom_SubcategoryGrid> createState() => _Custom_SubcategoryGridState();
}

class _Custom_SubcategoryGridState extends State<Custom_SubcategoryGrid> {
  @override
  void initState() {
    super.initState();
    () async {
      await Provider.of<ProductProvider>(context, listen: false).fetchProduct(
          subcategory: widget.datas.title ?? '',
          subcategoryId: widget.datas.id);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        // print('Subcategory ID: ${widget.}');
        // print('Filtered Products: ${value.products?.data?.length}');
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: MediaQuery.sizeOf(context).width * 0.027,
            right: MediaQuery.sizeOf(context).width * 0.027,
            // bottom: MediaQuery.sizeOf(context).height * 0.025,
            top: MediaQuery.sizeOf(context).height * 0.01,
            // bottom: MediaQuery.sizeOf(context).height * 0.01,
          ),
          height: widget.height,
          width: widget.width,
          child: value.products != null && value.products!.data != null
              ? GridView.builder(
                  scrollDirection: widget.axisDirection,
                  // scrollDirection: axisDirection!,
                  itemCount: value.products!.data != null
                      ? value.products!.data!.length
                      : 0,
                  // itemCount: value.products!.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.crossAxisCount,
                      crossAxisSpacing: widget.crossAxisSpacing,
                      mainAxisSpacing: widget.mainAxisSpacing,
                      childAspectRatio: widget.childAspectRatio),
                  itemBuilder: (context, i) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(3, 8),
                              color: Colors.grey.shade300,
                              spreadRadius: 1,
                              blurRadius: 5)
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
                                                product:
                                                    value.products!.data![i])));
                                  },
                                  child: SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.17,
                                    child: Image(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.17,
                                        width: MediaQuery.sizeOf(context).width,
                                        fit: BoxFit.contain,
                                        // image: NetworkImage(AppUrl.baseUrl+value.products.data[i].image)),
                                        // image: const AssetImage('assets/chana.png')),

//   image: NetworkImage(
//     value.products!.data![i].image?.toString() ??
//     'https://images.pexels.com/photos/6129010/pexels-photo-6129010.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
//   ),
// )
                                        image: NetworkImage(
                                          AppUrl.baseUrl +
                                                  value.products!.data![i].image
                                                      .toString() ??
                                              'assets/chana.png',
                                        )),
                                  ),
                                  // image:  NetworkImage(AppUrl.baseUrl+value.products!.data![i].image.toString() ?? 'assets/chana.png',)),
                                ),
                              ),
                              if (value.products!.data![i].qty.toString() ==
                                  "0")
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
                          // ClipRRect(
                          //   borderRadius: const BorderRadius.only(
                          //       topLeft: Radius.circular(15),
                          //       topRight: Radius.circular(15)),
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       // Navigator.pushNamed(context, 'description');

                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => Description(
                          //                   product:
                          //                       value.products!.data![i])));
                          //     },
                          //     child: Image(
                          //       height:
                          //           MediaQuery.sizeOf(context).height * 0.19,
                          //       width: MediaQuery.sizeOf(context).width,
                          //       fit: BoxFit.cover,
                          //       image:
                          //           const AssetImage('assets/basmati-rice.png'),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.sizeOf(context).width * 0.001),
                            child: Text(
                              value.products!.data![i].title.toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                          ),
                          Consumer<BrandProvider>(
                            builder: (context, brandValue, child) {
                              var brandID = value.products!.data![i].brandId;
                              var brand = brandValue.brands?.data!.firstWhere(
                                  (element) => element.id == brandID,
                                  orElse: () => BrandData());
                              return Text(brand?.title ?? 'Unknown Brand');
                            },
                          ),
                          // Consumer<SubcategoryProvider>(
                          //   builder: (context, subcategoryValue, child) {
                          //     // Assuming 'data' could be null, indicating data is not loaded yet.
                          //     if (subcategoryValue.subcategories.data ==
                          //         null) {
                          //       // Data is not loaded yet, show a loading indicator.
                          //       return const Center(
                          //           child: CircularProgressIndicator());
                          //     }

                          //     // Data is loaded, proceed to find the subcategory.
                          //     var subcategoryId =
                          //         value.products!.data![i].subcategoryId;
                          //     var subcategory = subcategoryValue
                          //         .subcategories.data!
                          //         .firstWhere(
                          //       (sub) => sub.id == subcategoryId,
                          //       orElse: () =>
                          //           Data(), // Make sure Data() can safely be used like this; it should have a default title or handle null.
                          //     );

                          //     // Now that you have handled the data loading part, you can safely use the subcategory.
                          //     return Text(
                          //       subcategory.title ?? 'Unknown Subcategory',
                          //       style: const TextStyle(
                          //         overflow: TextOverflow.ellipsis,
                          //         fontSize: 15,
                          //         color: Colors.grey,
                          //       ),
                          //       maxLines: 1,
                          //     );
                          //   },
                          // ),
                          // Consumer<SubcategoryProvider>(
                          //   builder: (context, subcategoryValue, child) {
                          //     // Find the corresponding subcategory based on the product's subcategoryId
                          //     var subcategoryId =
                          //         value.products!.data![i].subcategoryId;
                          //     var subcategory =
                          //         subcategoryValue // We are using subcategoryValue here instead of just value because for productprovider it is already defined above
                          //             .subcategories
                          //             .data!
                          //             .firstWhere(
                          //                 (sub) => sub.id == subcategoryId,
                          //                 orElse: () => Data());

                          //     return Text(
                          //       subcategory.title ?? 'Unknown Subcategory',
                          //       style: const TextStyle(
                          //         overflow: TextOverflow.ellipsis,
                          //         fontSize: 15,
                          //         color: Colors.grey,
                          //       ),
                          //       maxLines: 1,
                          //     );
                          //   },
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (double.parse(
                                      value.products!.data![i].discount ??
                                          '0') >
                                  0) ...[
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    'Rs.${value.products!.data![i].price}',
                                    style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                              Text(
                                'Rs.${(double.parse(value.products!.data![i].price) - ((double.parse(value.products!.data![i].discount ?? '0') / 100) * double.parse(value.products!.data![i].price))).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: Colors.amber, fontSize: 15),
                              ),
                            ],
                          ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'Rs.${value.products!.data![i].price.toString()}',
                          //       style: const TextStyle(
                          //           fontSize: 16,
                          //           decoration: TextDecoration.lineThrough,
                          //           color: Colors.grey),
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.only(left: 5),
                          //       child: Text(
                          //         // if(value.products!.data![i].price.toString()*(double.value.products!.data![i].discount.toString()/100))
                          //         'Rs.${(double.parse(value.products!.data![i].price) - ((double.parse(value.products!.data![i].discount ?? '0') / 100) * double.parse(value.products!.data![i].price)))}',
                          //         style: const TextStyle(
                          //             fontSize: 16, color: Colors.amber),
                          //         // style: TextStyle(
                          //         //     decoration: TextDecoration.lineThrough),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Container(
                            padding: EdgeInsets.all(
                                MediaQuery.sizeOf(context).width * 0.005),
                            alignment: Alignment.center,
                            child: RatingBar.builder(
                                wrapAlignment: WrapAlignment.center,
                                itemSize: 25,
                                initialRating: 3.5,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.only(
                                    left: MediaQuery.sizeOf(context).width *
                                        0.015),
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                }),
                          ),
                          value.products!.data![i].qty.toString() == "0"
                              ? Container(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.sizeOf(context).height *
                                          0.004),
                                  alignment: Alignment.center,
                                  child: Custom_Redbutton(
                                    text: 'OUT OF STOCK',
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            duration: Durations.short3,
                                            content: Text('OUT OF STOCK!')),
                                      );
                                    },
                                  ),
                                )
                              :
                              // Container(
                              //   padding: EdgeInsets.all(
                              //       MediaQuery.sizeOf(context).width * 0.001),
                              //   alignment: Alignment.center,
                              //   child: Custom_Button_Homepage(
                              //     text: 'ADD TO CART',

                              //     onPressed: () async {
                              //       var box = await Hive.openBox(
                              //           'box'); // Ensure the box is opened
                              //       List<dynamic> cartItems = box.get('cart',
                              //           defaultValue: <dynamic>[]).cast<dynamic>();

                              //       // Check if the current product ID is already in the cart
                              //       if (!cartItems
                              //           .contains(value.products!.data![i].id)) {
                              //         cartItems.add(value.products!.data![i].id);
                              //         await box.put('cart',
                              //             cartItems); // Save the updated list back to the box
                              //         ScaffoldMessenger.of(context).showSnackBar(
                              //           const SnackBar(
                              //               content: Text('Added to cart!')),
                              //         );
                              //         print(cartItems);
                              //       } else {
                              //         cartItems
                              //             .contains(value.products!.data![i].id);
                              //         ScaffoldMessenger.of(context).showSnackBar(
                              //           const SnackBar(
                              //               content: Text('Item already in cart')),
                              //         );
                              //         print(cartItems);
                              //       }
                              //     },
                              //     // var box = Hive.box('box');
                              //     // List? cartItems = box.get('cart');

                              //     // if (cartItems != null && cartItems.isNotEmpty) {
                              //     //   cartItems.add(value.products!.data![i].id);
                              //     //   box.put('cart', cartItems);
                              //     //   print(cartItems);
                              //     // } else {
                              //     //   List ids = [];
                              //     //   ids.add(value.products!.data![i].id);
                              //     //   box.put('cart', ids);
                              //     // }

                              //     // height: 40,
                              //     // minWidth: 60,
                              //     // onPressed: () {
                              //     //   Navigator.pushNamed(context, 'cart');
                              //     // },
                              //   ),
                              // ),
                              Container(
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
                                        // User is logged in, proceed with adding to cart
                                        var box = await Hive.openBox('box');
                                        List<dynamic> cartItems = box.get(
                                            'cart',
                                            defaultValue: <dynamic>[]).cast<dynamic>();

                                        // Implement your cart logic here
                                        // Assuming `value.products!.data![i].id` is accessible

                                        // Example logic:
                                        if (!cartItems.contains(
                                            value.products!.data![i].id)) {
                                          cartItems
                                              .add(value.products!.data![i].id);
                                          await box.put('cart', cartItems);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Added to cart!')),
                                          );
                                          print(cartItems);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Item already in cart')),
                                          );
                                          print(cartItems);
                                        }
                                      } else {
                                        // User is not logged in, show dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Login Required'),
                                              content: const Text(
                                                  'You need to log in to add the product to your cart.'),
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
                                                  color:Colors.amber,
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, "login");
                                                  },
                                                  child: const Text("Login", style: TextStyle(color:Colors.white),),
                                                )
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
                  })
              : const Text('Error Loading Data'),
        );
      },
    );
  }
}
