import 'package:eccomerce/Models/brand_model.dart';
import 'package:eccomerce/Models/subcategory_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/helper/custom_button_homepage.dart';
import 'package:eccomerce/helper/custom_redbutton.dart';
import 'package:eccomerce/provider/allproduct_provider.dart';
import 'package:eccomerce/provider/brand_provider.dart';
// import 'package:eccomerce/provider/subcategory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../views/NavigationPage/SecondaryPages/descripition.dart';

class Custom_Grid_Shop extends StatefulWidget {
  final Axis axisDirection;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double? height;
  final double? width;

  // final Data datas;

  const Custom_Grid_Shop(
      {super.key,
      required this.axisDirection,
      required this.crossAxisCount,
      required this.childAspectRatio,
      required this.mainAxisSpacing,
      required this.crossAxisSpacing,
      // required this.datas,
      this.height,
      this.width});

  @override
  State<Custom_Grid_Shop> createState() => _Custom_Grid_ShopState();
}

class _Custom_Grid_ShopState extends State<Custom_Grid_Shop> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    () async {
      await Provider.of<AllproductProvider>(context, listen: false)
          .fetchproducts();
    }(); // () async {
    //   await Provider.of<AllproductProvider>(context, listen: false)
    //       .fetchproducts(subcategory: ''
    //           // subcategory: widget.datas.title ?? '',
    //           // subcategoryId: widget.datas.id
    //           );
    // }();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllproductProvider>(
      builder: (context, value, child) {
        return Container(
          // margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.08),
          // padding: EdgeInsets.only(
          //   left: MediaQuery.sizeOf(context).width * 0.02,
          //   right: MediaQuery.sizeOf(context).width * 0.02,
          // ),
          margin: EdgeInsets.only(
            left: MediaQuery.sizeOf(context).width * 0.02,
            right: MediaQuery.sizeOf(context).width * 0.02,
            // bottom: MediaQuery.sizeOf(context).height*0.02,
            // top: MediaQuery.sizeOf(context).height * 0.02,
          ),
          // height: widget.height,
          // decoration: BoxDecoration(
          //     color: Colors.amber, borderRadius: BorderRadius.circular(20)),
          width: widget.width,
          child: GridView.builder(
              scrollDirection: widget.axisDirection,
              // scrollDirection: axisDirection!,
                              itemCount: value.filteredoutProduct.length,

              // itemCount: value.products.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  crossAxisSpacing: widget.crossAxisSpacing,
                  mainAxisSpacing: widget.mainAxisSpacing,
                  childAspectRatio: widget.childAspectRatio),
              itemBuilder: (context, i) {
                return Container(
                  // height: MediaQuery.sizeOf(context).height*0.25,
                  // width: MediaQuery.sizeOf(context).width*0.23,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 8),
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image(image: data[index]['image']),
                      // Image(
                      //   image: AssetImage(data[index]['image']),
                      // ),
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
                                                value.products.data![i])));
                              },
                              child: SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.17,
                                    child: Image.network(
                                  AppUrl.baseUrl +
                                              value.filteredoutProduct[i].image
                                                  .toString(),
                                  height: MediaQuery.of(context).size.height *
                                      0.17,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.contain,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    // Here you return your fallback image when the network image fails to load
                                    return Image.asset(
                                      'assets/agricultural.jpg', // The path to your local asset image
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.17,
                                      width:
                                          MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                                // child: Image(
                                //     height:
                                //         MediaQuery.sizeOf(context).height *
                                //             0.17,
                                //     width: MediaQuery.sizeOf(context).width,
                                //     fit: BoxFit.cover,
                                //     // image: NetworkImage(AppUrl.baseUrl+value.products.data[i].image)),
                                //     // image: const AssetImage('assets/chana.png')),
                                //     image: NetworkImage(
                                //       AppUrl.baseUrl +
                                //               value.products!.data![i].image
                                //                   .toString() ??
                                //           'assets/chana.png',
                                //     )),
                              ),
                              // image:  NetworkImage(AppUrl.baseUrl+value.products!.data![i].image.toString() ?? 'assets/chana.png',)),
                            ),
                          ),
                          if(value.filteredoutProduct[i].qty.toString() == "0")
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
                          // Center(
                          //   child: Container(
                          //     padding: const EdgeInsets.all(5),
                          //     decoration: const BoxDecoration(
                          //         color: Colors.red,
                          //         borderRadius: BorderRadius.only(
                          //             bottomLeft: Radius.circular(12),
                          //             bottomRight: Radius.circular(12))),
                          //     child: const Text(
                          //       'OUT OF STOCK',
                          //       style: TextStyle(color: Colors.white),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              value.filteredoutProduct[i].title,
                              style: const TextStyle(
                                  // color: Colors.green.shade900,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Consumer<BrandProvider>(
                              builder: (context, brandValue, child) {
                                var brandID =
                                    value.filteredoutProduct[i].brandId;
                                var brand = brandValue.brands!.data!
                                    .firstWhere(
                                        (element) => element.id == brandID,
                                        orElse: () => BrandData());
                                return Text(brand.title ?? 'Unknown Brand');
                              },
                            ),
                            // Consumer<SubcategoryProvider>(
                            //   builder: (context, subcategoryValue, child) {
                            //     var subcategoryID =
                            //         value.products!.data![i].subcategoryId;
                            //     var subcategory = subcategoryValue
                            //         .subcategories.data!
                            //         .firstWhere(
                            //             (element) =>
                            //                 element.id == subcategoryID,
                            //             orElse: () => Data());
                            //     return Text(
                            //       subcategory.title ?? 'Unknown Subcategory',
                            //       style: const TextStyle(color: Colors.grey),
                            //       maxLines: 1,
                            //       overflow: TextOverflow.ellipsis,
                            //     );
                            //   },
                            // ),
                            // Consumer<SubcategoryProvider>(
                            //   builder: (context, subcategoryValue, child) {
                            //     var subcategoryId =
                            //         value.products!.data![i].subcategoryId;
                            //     var subcategory = subcategoryValue
                            //         .subcategories.data!
                            //         .firstWhere((ele) => ele.id == subcategoryId,
                            //             orElse: () => Data());
                            //     return  Text(
                            //       subcategory.title ?? 'Unknown Subcategory',
                            //       style: const TextStyle(color: Colors.grey),
                            //       maxLines: 1,
                            //       overflow: TextOverflow.ellipsis,
                            //     );
                            //   },
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (double.parse(
                                        value.filteredoutProduct[i].discount ??
                                            '0') >
                                    0) ...[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'Rs.${value.filteredoutProduct[i].price}',
                                      style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.sizeOf(context).width *
                                          0.01),
                                  child: Text(
                                    'Rs.${(double.parse(value.filteredoutProduct[i].price) - ((double.parse(value.filteredoutProduct[i].discount ?? '0') / 100) * double.parse(value.filteredoutProduct[i].price))).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.amber),
                                    // style: TextStyle(
                                    //     decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      RatingBar.builder(
                          wrapAlignment: WrapAlignment.center,
                          // ignoreGestures: true,
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
                          }),
                       value.filteredoutProduct[i].qty.toString() == "0" 
                       ?   Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.sizeOf(context).height *
                                      0.004),
                                      alignment: Alignment.center,
                                      child: Custom_Redbutton(text: 'OUT OF STOCK', onPressed: (){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        duration: Durations.short3,
                                        content: Text('OUT OF STOCK!')),
                                  );
                                },),
                            )
                      :Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height * 0.004),
                        alignment: Alignment.center,
                        child: Custom_Button_Homepage(
                          text: 'ADD TO CART',
                          onPressed: () async {
                            // var box = await Hive.openBox(
                            //         'cart'); // Ensure the box is opened
                            //     List<dynamic> cartItems = box.get('cart',
                            //         defaultValue: <dynamic>[]).cast<dynamic>();
                            var box = Hive.box('box');
                            List cartItems = box.get('cart');
                            // Check if the current product ID is already in the cart
                            if (!cartItems
                                .contains(value.filteredoutProduct[i].id)) {
                              cartItems.add(value.filteredoutProduct[i].id);
                              await box.put('cart',
                                  cartItems); // Save the updated list back to the box
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Durations.short3,
                                    content: Text('Added to cart!')),
                              );
                              // print('hello: $cartItems');
                            } else {
                              cartItems.contains(value.filteredoutProduct[i].id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Durations.short3,
                                    content: Text('Item already in cart')),
                              );
                              print('product added: $cartItems');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
        );
            },
    );
  }
}
