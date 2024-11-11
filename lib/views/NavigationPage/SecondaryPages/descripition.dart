import 'package:carousel_slider/carousel_slider.dart';
import 'package:eccomerce/Models/brand_model.dart';
import 'package:eccomerce/Models/category_model.dart';
import 'package:eccomerce/Models/product_model.dart';
import 'package:eccomerce/Models/review_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/helper/custom_button_homepage.dart';
import 'package:eccomerce/provider/brand_provider.dart';
import 'package:eccomerce/provider/category_provider.dart';
import 'package:eccomerce/provider/loggeduser_provider.dart';
import 'package:eccomerce/provider/productimages_provider.dart';
import 'package:eccomerce/provider/review_provider.dart';
import 'package:eccomerce/provider/wishlist_provider.dart';
import 'package:eccomerce/provider/wishlistnewproduct_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../Models/subcategory_model.dart';
import '../../../provider/subcategory_provider.dart';

class Description extends StatefulWidget {
  const Description({super.key, required this.product});

  final ProductData product;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  int _current = 0;
  bool loading = true;
  bool _isHeartClicked = false;
  @override
  void initState() {
    
    Provider.of<WishlistProvider>(context, listen: false).fetchwishlist();
    Provider.of<ProductImageProvider>(context, listen: false)
        .fetchproductimage();
    Provider.of<ReviewProvider>(context, listen: false)
        .fetchreview()
        .then((value) => loading = false);
    Provider.of<LoggedUserProvider>(context, listen: false).fetchLoggedUser();
    super.initState();
  }


  bool _isExpanded = false;
  bool _isExpanded1 = false;
  @override
  Widget build(BuildContext context) {
    print(
        "UNIQUE: ${widget.product.uniqueId}"); //prints the id of the product when I go from grid image to description.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: ColorConstant.primaryColor,
        title: Text(
          widget.product.title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(80), // Circular bottom left
            bottomRight: Radius.circular(80), // Circular bottom right
          ),
        ),
        elevation: 8,
        shadowColor: Colors.grey,
        centerTitle: true,
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.08,
      ),
      body: widget.product == null
          ? const SizedBox(
            height: 500,
            child: Center(
                child: CircularProgressIndicator(),
              ),
          )
          : Stack(
            children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade200.withOpacity(
                          0.94), // Change the color and opacity as needed
                      BlendMode
                          .srcATop, // Experiment with different blend modes
                    ),
                    child: Image.asset(
                      'assets/background.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                child: Consumer<ProductImageProvider>(
                    builder: (context, productImageValue, child) {
                  var productImages = productImageValue.productimage?.data
                          ?.where((img) =>
                              img.productId == widget.product.uniqueId.toString())
                          .toList() ??
                      [];
            
              
                  return productImageValue.isLoading
                      ? const SizedBox(height: 500,child: Center(child: CircularProgressIndicator()))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                if (productImages.isEmpty)
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    child: Image.asset(
                                      'assets/agricultural.jpg', // Placeholder asset image path
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: MediaQuery.of(context).size.height *
                                          0.4,
                                    ),
                                  ),
                                if (productImages.isNotEmpty)
                                  Container(
                                    // padding: const EdgeInsets.only(left: 8, right: 8),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.sizeOf(context).height *
                                              0.02),
                                      child: CarouselSlider.builder(
                                        itemCount: productImages.length,
                                        // itemCount: value.products!.data!.length,
                                        itemBuilder: (context, index, realIndex) {
                                          String imageUrl = AppUrl.baseUrl +
                                              productImages[index]
                                                  .file
                                                  .toString();
                                          print('Product Image URL: $imageUrl');
                                          return Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Image.asset(
                                                'assets/agricultural.jpg', // The path to your local asset image
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          );
                                        },
                                        options: CarouselOptions(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.4,
                                            enlargeCenterPage: false,
                                            autoPlay: true,
                                            autoPlayCurve: Curves.linear,
                                            enableInfiniteScroll: true,
                                            autoPlayAnimationDuration:
                                                const Duration(milliseconds: 400),
                                            viewportFraction: 1,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _current = index;
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                if (productImages.isNotEmpty)
                                  Positioned(
                                    top: MediaQuery.sizeOf(context).height * 0.37,
                                    width: MediaQuery.sizeOf(context).width,
                                    // left: MediaQuery.sizeOf(context).width * 0.4,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                          productImages.length, (index) {
                                        // Replace 4 with the actual count of your items
                                        return Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.02,
                                          height:
                                              MediaQuery.sizeOf(context).height *
                                                  0.01,
                                          margin: EdgeInsets.symmetric(
                                              vertical: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.01,
                                              horizontal:
                                                  MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.015),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _current == index
                                                ? Colors
                                                    .amber // Active indicator color
                                                : Colors.grey
                                                    .shade400, // Inactive indicator color
                                          ),
                                        );
                                      }),
                                    ),
                                  )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.sizeOf(context).width * 0.027),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Icon(Icons.remove_red_eye),
                                        ),
                                        // Text("${widget.product.visitNo.toString()} People are looking for this product!"),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors
                                                    .black), // Default text style
                                            children: [
                                              TextSpan(
                                                text: widget.product.visitNo
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold), // Bold style
                                              ),
                                              const TextSpan(
                                                text:
                                                    " People are looking for this product!",
                                              ),
                                            ],
                                          ),
                                        ),
                                        Consumer2<WishlistProvider,
                                            LoggedUserProvider>(
                                          builder: (context, wishlistValue,
                                              loggeduserValue, child) {
                                            if (wishlistValue.wishlists == null ||
                                                loggeduserValue.loggedUsers ==
                                                    null) {
                                              return Center(
                                                // child: CircularProgressIndicator(),
                                                child: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Login Required'),
                                                            content: const Text(
                                                                'You need to login to add the product to wishlist.'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  // Navigate to login screen
                                                                  // Navigator.pushNamed(context, 'login');
                                                                },
                                                                child: const Text(
                                                                    'Later'),
                                                              ),
                                                              MaterialButton(
                                                                hoverColor:
                                                                    Colors.green,
                                                                color:
                                                                    Colors.amber,
                                                                onPressed: () {
                                                                  Navigator
                                                                      .pushNamed(
                                                                          context,
                                                                          "login");
                                                                },
                                                                child: const Text(
                                                                  "Login",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                        Icons.favorite_border)),
                                              );
                                            }
            
                                            final wishlists =
                                                wishlistValue.wishlists!.data;
                                            final userId = loggeduserValue
                                                .loggedUsers!.user?.id;
                                            if (userId == null) {
                                              return const Center(
                                                child: Text("User ID not found."),
                                              );
                                            }
            
                                            final userWishlists = wishlists!
                                                .where((item) =>
                                                    item.userId == userId)
                                                .toList();
                                            final isFavorite = userWishlists.any(
                                                (item) =>
                                                    item.productId ==
                                                    widget.product.id);
            
                                            return IconButton(
                                              color: Colors.blue,
                                              icon: Icon(
                                                isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color:
                                                    _isHeartClicked || isFavorite
                                                        ? Colors.red
                                                        : Colors.grey,
                                                size: 25.0,
                                              ),
                                              onPressed: () {
                                                if (isFavorite) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "The product is already in the wishlist."),
                                                    ),
                                                  );
                                                } else {
                                                  Provider.of<WishlistAddProductProvider>(
                                                          context,
                                                          listen: false)
                                                      .addWishlist(
                                                          userId.toString(),
                                                          widget.product.id
                                                              .toString())
                                                      .then((_) {
                                                    // Refresh the wishlist provider
                                                    Provider.of<WishlistProvider>(
                                                            context,
                                                            listen: false)
                                                        .fetchwishlist();
                                                    setState(() {
                                                      _isHeartClicked = true;
                                                    });
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "The product has been added to Wishlist."),
                                                      ),
                                                    );
                                                  });
                                                }
                                              },
                                            );
                                          },
                                        ),      
                                      ],
                                    ),
                                  ),      
                                  Container(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Availability:",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width:
                                              8, // Add some space between text and quantity
                                        ),
                                        Text(
                                          widget.product.qty == "0"
                                              ? "Out of Stock"
                                              : (int.parse(widget.product.qty) <
                                                      100
                                                  ? "Out of Stock soon"
                                                  : "In Stock"),
                                          style: TextStyle(
                                            color: widget.product.qty == "0" ||
                                                    int.parse(
                                                            widget.product.qty) <
                                                        100
                                                ? Colors
                                                    .red // Change text color for out of stock or low stock
                                                : ColorConstant.primaryColor,
                                            fontWeight: widget.product.qty ==
                                                        "0" ||
                                                    int.parse(
                                                            widget.product.qty) <
                                                        100
                                                ? FontWeight
                                                    .bold // Make text bold for out of stock or low stock
                                                : FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        // Text(widget.product.qty),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Category:',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Consumer<CategoryProvider>(
                                          builder: (context, value, child) {
                                            CategoryModel categoryModel =
                                                value.categories!;
                                            var category =
                                                categoryModel.data.firstWhere(
                                              (element) =>
                                                  element.id ==
                                                  widget.product.categoryId,
                                              orElse: () => CategoryData(),
                                            );
                                            return Text(
                                              category.title ??
                                                  'Unknown category',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey.shade700,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text(widget.product.id.toString()),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Subcategory:',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Consumer<SubcategoryProvider>(
                                          builder: (context, value, child) {
                                            SubcategoryModel subcategoryModel =
                                                value.subcategories;
                                            var subcategory =
                                                subcategoryModel.data!.firstWhere(
                                              (element) =>
                                                  element.id ==
                                                  widget.product.subcategoryId,
                                              orElse: () => Data(),
                                            );
                                            return Text(
                                              subcategory.title ??
                                                  'Unknown Subcategory',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey.shade700,
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Brand:',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Consumer<BrandProvider>(
                                          builder: (context, brandValue, child) {
                                            var brandID = widget.product
                                                .brandId; // Safely access brandId
                                            if (brandID != null &&
                                                brandValue.brands?.data != null) {
                                              var brand = brandValue.brands!.data!
                                                  .firstWhere(
                                                (element) =>
                                                    element.id == brandID,
                                                orElse: () => BrandData(),
                                              );
                                              return Text(
                                                  brand.title ?? 'Unknown Brand');
                                            } else {
                                              return const Text('Unknown Brand');
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'Description:',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  AnimatedCrossFade(
                                    firstChild: Text(
                                      widget.product.description ??
                                          "No Description",
                                      // product.description!,
                                      // overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
            
                                      style: const TextStyle(fontSize: 12),
                                      // overflow: TextOverflow.visible,
                                      // maxLines: 5,
                                    ),
                                    secondChild: Text(
                                      widget.product.description ??
                                          "No Description",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    crossFadeState: _isExpanded
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: const Duration(milliseconds: 200),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isExpanded = !_isExpanded;
                                      });
                                    },
                                    child: Text(
                                      _isExpanded ? 'Read Less' : 'Read More',
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
            
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 8.0, top: 12),
                                    child: Text(
                                      'Summary:',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  AnimatedCrossFade(
                                    firstChild: Text(
                                      widget.product.summary ?? "No Summary",
                                      // product.description!,
                                      // overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
            
                                      style: const TextStyle(fontSize: 12),
                                      // overflow: TextOverflow.visible,
                                      // maxLines: 5,
                                    ),
                                    secondChild: Text(
                                      widget.product.summary ?? "No Summary",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    crossFadeState: _isExpanded1
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: const Duration(milliseconds: 200),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isExpanded1 = !_isExpanded1;
                                      });
                                    },
                                    child: Text(
                                      _isExpanded1 ? 'Read Less' : 'Read More',
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Price:',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        if (double.parse(
                                                widget.product.discount ?? '0') >
                                            0) ...[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8.0),
                                            child: Text(
                                              'Rs.${widget.product.price}',
                                              style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.lineThrough,
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                        Text(
                                          'Rs.${(double.parse(widget.product.price) - ((double.parse(widget.product.discount ?? '0') / 100) * double.parse(widget.product.price))).toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: Colors.amber, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8),
                                    child: RatingBar.builder(
                                        wrapAlignment: WrapAlignment.center,
                                        itemSize: 25,
                                        initialRating: 3.5,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.only(
                                            left:
                                                MediaQuery.sizeOf(context).width *
                                                    0.015),
                                        itemBuilder: (context, _) => const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        }),
                                  ),
                                  // Custom_Button_Homepage(
                                  //   text: 'ADD TO CART',
                                  //   fontSize: 20,
                                  //   height: 50,
                                  //   minWidth: 100,
                                  //   onPressed: () {
                                  //     var box = Hive.box('box');
                                  //     List? cartItems = box.get('cart');
            
                                  //     if (cartItems != null &&
                                  //         cartItems.isNotEmpty) {
                                  //       cartItems.add(widget.product.id);
                                  //       box.put('cart', cartItems);
                                  //     } else {
                                  //       List ids = [];
                                  //       ids.add(widget.product.id);
                                  //       box.put('cart', ids);
                                  //     }
                                  //   },
                                  // ),
                                  Custom_Button_Homepage(
                                    fontSize: 20,
                                    height: 50,
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
                                        if (!cartItems.contains(widget.product.id)) {
                                          cartItems.add(widget.product.id);
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
                                                  'You need to login to add the product to your cart.'),
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
                                  ),
            
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.02),
                                          child: const Text(
                                            "Customer Reviews:",
                                            style: TextStyle(fontSize: 18),
                                          )),
                                      Container(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.02),
                                          child: MaterialButton(
                                            focusColor:
                                                ColorConstant.primaryColor,
                                            hoverColor:
                                                ColorConstant.primaryColor,
                                            splashColor:
                                                ColorConstant.primaryColor,
                                            color: ColorConstant.secondaryColor,
                                            onPressed: () {
                                              showReviewDialog(context);
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Text(
                                              'Write a Review',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ))
                                    ],
                                  ),
                                  //////////// This the working code of the review provider!!!
                                  Consumer<ReviewProvider>(
                                    builder: (context, reviewvalue, child) {
                                      print(
                                          'This is it ofofofoooooooo $reviewvalue');
                                      ReviewModel? reviewModel =
                                          reviewvalue.reviews;
                                          if (reviewModel == null ||
                                          reviewModel.data == null) {
                                        return Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.03),
                                            child: const Text(
                                                'No reviews found for this product!'));
                                      }
                                      List<ReviewData> reviewss = reviewModel.data!.where((element) =>
                                              element.productId ==
                                              widget.product.id!)
                                          .toList();
            
                                      if (reviewss.isEmpty) {
                                        return Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.03),
                                            child: const Text(
                                                'No reviews found for this product!'));
                                      }
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: reviewss.length,
                                          itemBuilder: (context, i) {
                                            return Card(
                                              // semanticContainer: true,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                      leading: const CircleAvatar(
                                                          backgroundColor: Colors
                                                              .blue,
                                                          child: Icon(
                                                            size: 30,
                                                            Icons.person,
                                                            color: Colors.white,
                                                          )),
                                                      trailing: RatingBar.builder(
                                                          wrapAlignment:
                                                              WrapAlignment
                                                                  .center,
                                                          itemSize: 25,
                                                          ignoreGestures: true,
                                                          initialRating:
                                                              reviewss[i]
                                                                  .rate!
                                                                  .toDouble(),
                                                          minRating: 1,
                                                          direction: Axis
                                                              .horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets.only(
                                                              left: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.015),
                                                          itemBuilder: (context,
                                                                  _) =>
                                                              const Icon(
                                                                Icons.star,
                                                                color:
                                                                    Colors.amber,
                                                              ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            print(rating);
                                                          }),
                                                      title: Text(reviewss[i]
                                                          .userId
                                                          .toString())),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.sizeOf(
                                                                      context)
                                                                  .width *
                                                              0.06,
                                                          right:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.06,
                                                          bottom:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.03),
                                                      // color: Colors.red,
                                                      child: Text(reviewss[i]
                                                              .review
                                                              .toString()
                                                          // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                                                          )),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                }),
              ),],
          ),
    );
  }

  void showReviewDialog(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    double currentRating = 1;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Center(child: Text('Leave a Review')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLines:
                      3, // Allows the input to expand to as many lines as needed
                  keyboardType: TextInputType.multiline,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Type your review here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0), // Border radius
                    ),
                    // Border when the TextFormField is in focus
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    // Border when the TextFormField is disabled
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Rate us:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                RatingBar.builder(
                  initialRating: currentRating,
                  minRating: 1,
                  itemSize: 30,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.01),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: ColorConstant.secondaryColor,
                  ),
                  onRatingUpdate: (rating) {
                    currentRating = rating;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // const MenuItemButton(style:ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.amber),),child: Text('Cancel')),
            // const MenuItemButton(child: Text('Send')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: MaterialButton(
                  focusColor: Colors.grey,
                  hoverColor: Colors.grey,
                  splashColor: Colors.grey,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                )),
                Container(
                    child: MaterialButton(
                  focusColor: ColorConstant.primaryColor,
                  hoverColor: ColorConstant.primaryColor,
                  splashColor: ColorConstant.primaryColor,
                  color: ColorConstant.secondaryColor,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Send',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                )),
              ],
            ), // TextButton(
            //   onPressed: () {
            //     // Here, you might want to use the text and rating for something
            //     print('Review: ${textEditingController.text}');
            //     print('Rating: $currentRating');
            //     Navigator.of(context).pop(); // Dismiss the dialog
            //   },
            //   child: const Text('Submit'),
            // ),
          ],
        );
      },
    );
  }
}
