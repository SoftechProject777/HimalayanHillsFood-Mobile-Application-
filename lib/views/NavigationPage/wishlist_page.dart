import 'package:eccomerce/Models/banner_model.dart';
import 'package:eccomerce/Models/brand_model.dart';
import 'package:eccomerce/Models/product_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/provider/allproduct_provider.dart';
import 'package:eccomerce/provider/brand_provider.dart';
import 'package:eccomerce/provider/loggeduser_provider.dart';
import 'package:eccomerce/provider/wishlist_provider.dart';
import 'package:eccomerce/provider/wishlistnewproduct_provider.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/descripition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    () async {
      Provider.of<AllproductProvider>(context, listen: false).fetchproducts();
      Provider.of<WishlistProvider>(context, listen: false).fetchwishlist();
      Provider.of<LoggedUserProvider>(context, listen: false).fetchLoggedUser();
    }();
  }

  final bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Container(height: double.infinity,width: double.infinity,
          decoration: const BoxDecoration(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.shade200.withOpacity(0.94), // Change the color and opacity as needed
                BlendMode.srcATop, // Experiment with different blend modes
              ),
              child: Image.asset('assets/background.jpeg', fit: BoxFit.cover,),

            ),),Consumer3<WishlistProvider, AllproductProvider, LoggedUserProvider>(
          builder: (context, wishlistProvider, productProvider,
              loggedUserProvider, child) {
            print(
                ":this is the logged user::${loggedUserProvider.loggedUsers?.user}");
            // Get wishlist items
            final wishlists = wishlistProvider.wishlists?.data;
            print("THis is only the wishlist part:::$wishlists");
            // Get logged-in user's ID
            final userId = loggedUserProvider.loggedUsers?.user?.id;
            print("THis is only the User Logged In part:::$userId");
            // if (wishlistProvider.wishlists == null) {
            //   return const SizedBox(height: 500,child: Expanded(child: Center(child: CircularProgressIndicator())));
            // } else if (wishlists == null || wishlists.isEmpty) {
            if (wishlists == null || wishlists.isEmpty) {
              return const Center(child: Text('Wishlist is Empty!'));
            } else {
              // Filter wishlist items based on user ID
              final userWishlists =
                  wishlists.where((item) => item.userId == userId).toList();
              print(
                  "This is the wishlist part of only the user::$userWishlists");
              if (userWishlists.isEmpty
              ) {
                return  Container(
                  alignment: Alignment.center,
                  // color:Colors.red,
                  height: MediaQuery.sizeOf(context).height*1,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No items in wishlist!'),
                    ],
                  ),
                );
              }
              return userId != null
                  ? ListView.builder(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: userWishlists.length,
                      itemBuilder: (context, i) {
                        // Find product details for the wishlist item
                        final productId =
                            userWishlists[i].productId?.toString();
                        print("This is the PrOduct Parta::$productId");
                        final productDetails =
                            productProvider.products.data?.firstWhere(
                          (p) => p.id?.toString() == productId,
                          orElse: () => ProductData(
                              title: '', price: '', discount: '', qty: ''),
                        );
              
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.sizeOf(context).width * 0.02),
                          child: Card(
                            color: Colors.green.shade200,
                            shadowColor:
                                Colors.grey.shade300, // Color of the shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Adjust the border radius as needed
                            ),
                            // elevation: 8,
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.sizeOf(context).height *
                                          0.02,
                                  top: MediaQuery.sizeOf(context).height *
                                      0.02),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                    
                                        child: productDetails != null &&
                                                productDetails.image !=
                                                    null &&
                                                productDetails
                                                    .image!.isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Description(
                                                                  product:
                                                                      productDetails)));
                                                },
                                                child: Image.network(
                                                  AppUrl.baseUrl +
                                                      productDetails.image!
                                                          .toString(),
                                                  height: MediaQuery.sizeOf(
                                                              context)
                                                          .height *
                                                      0.13,
                                                  width: MediaQuery.sizeOf(
                                                              context)
                                                          .width *
                                                      0.3,
                                                  fit: BoxFit.fitHeight,
                                                  errorBuilder: (context,
                                                      error, stackTrace) {
                                                    return Image.asset(
                                                      'assets/agricultural.jpg',
                                                      height: 50,
                                                      width: 50,
                                                    );
                                                  },
                                                ),
                                              )
                                            : Image.asset(
                                                'assets/agricultural.jpg',
                                                height: 50,
                                                width: 50,
                                              ),
                                      ),
                                      
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productDetails!.title,
                                              maxLines: 3,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color:
                                                      Colors.green.shade900,
                                                  fontSize: 16),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.sizeOf(
                                                              context)
                                                          .width *
                                                      0.01,
                                                  top: MediaQuery.sizeOf(
                                                              context)
                                                          .height *
                                                      0.006),
                                              child:
                                                  Consumer<BrandProvider>(
                                                builder: (context,
                                                    brandvalue, child) {
                                                  BrandModel brand =
                                                      brandvalue.brands!;
                                                  var brandData = brand
                                                      .data!
                                                      .firstWhere(
                                                          (element) =>
                                                              element.id ==
                                                              productDetails
                                                                  .brandId,
                                                          orElse: () =>
                                                              BrandData(
                                                                  title:
                                                                      "Unknown Brand"));
                                                  return Text(
                                                    brandData.title!,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  );
                                                },
                                              ),
 
                                            ),
                                            if (double.parse(productDetails
                                                        .discount ??
                                                    '0') >
                                                0) ...[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        right: 8.0),
                                                child: Text(
                                                  'Rs.${productDetails.price}',
                                                  style: const TextStyle(
                                                      decoration:
                                                          TextDecoration
                                                              .lineThrough,
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ],
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.sizeOf(
                                                              context)
                                                          .width *
                                                      0.01),
                                              child: Text(
                                                'Rs.${(double.tryParse(productDetails.price)! - ((double.tryParse(productDetails.discount ?? '0')! / 100) * double.parse(productDetails.price))).toStringAsFixed(2)}',
                                                style:  const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          // Implement add to cart functionality
                                          var box = Hive.box('box');
                                          List cartItems = box.get('cart');
                                          // Check if the current product ID is already in the cart
                                          if (!cartItems.contains(
                                              productDetails.id)) {
                                            cartItems
                                                .add(productDetails.id);
                                            await box.put('cart',
                                                cartItems); // Save the updated list back to the box
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  duration:
                                                      Durations.short3,
                                                  content: Text(
                                                      'Added to cart!')),
                                            );
                                            // print('hello: $cartItems');
                                          } else {
                                            cartItems.contains(
                                                productDetails.id);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  duration:
                                                      Durations.short3,
                                                  content: Text(
                                                      'Item already in cart')),
                                            );
                                            print(
                                                'product added: $cartItems');
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Consumer<
                                          WishlistDeleteProductProvider>(
                                        builder: (context, provider, _) {
                                          return IconButton(
                                            splashColor: Colors.red,
                                            onPressed: () {
                                              provider
                                                  .deleteWishlist(
                                                      productDetails.id!)
                                                  .then((_) {
                                                if (provider.successlogin) {
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Item removed from wishlist!'),
                                                    ),
                                                  );
              
                                                  // Check if WishlistProvider is empty or null
                                                  final wishlistProvider =
                                                      Provider.of<
                                                              WishlistProvider>(
                                                          context,
                                                          listen: false);
                                                  if (wishlistProvider
                                                          .wishlists ==
                                                      null) {
                                                    const CircularProgressIndicator();
                                                    // const Text(
                                                    //     'Wishlist is empty!');
                                                  } else {
                                                    wishlistProvider.fetchwishlist();
                                                  }
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                     
                                    ],
                                  ),
                                
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Expanded(
                      child: Center(
                          child: Text('Login to see the Wishlist!')));
            }
          },
        ),],
      ),
    );
  }
}
