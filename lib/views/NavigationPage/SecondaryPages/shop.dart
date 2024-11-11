import 'dart:math';

import 'package:eccomerce/Models/brand_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/helper/custom_button_homepage.dart';
import 'package:eccomerce/helper/custom_redbutton.dart';
import 'package:eccomerce/provider/allproduct_provider.dart';
import 'package:eccomerce/provider/brand_provider.dart';
import 'package:eccomerce/provider/category_provider.dart';
import 'package:eccomerce/provider/subcategory_provider.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/descripition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ensure that you are calling methods that do not directly impact the widget tree during the build phase.
      print(
          "List Of filtered DataList:::${Provider.of<AllproductProvider>(context, listen: false).filteredoutProduct}");
      Provider.of<AllproductProvider>(context, listen: false).fetchproducts();
      Provider.of<CategoryProvider>(context, listen: false).fetchcategory();
      Provider.of<SubcategoryProvider>(context, listen: false)
          .fetchSubCategory();
      Provider.of<BrandProvider>(context, listen: false).fetchbrand();
      Provider.of<AllproductProvider>(context, listen: false)
          .setfilteredProduct(
              Provider.of<AllproductProvider>(context, listen: false)
                  .allProducts
                  .data!);
      print(
          "List Of filtered DataList22:::${Provider.of<AllproductProvider>(context, listen: false).filteredoutProduct}");
    });

    // print(
    //     "LIst Of filtered DatatList:::${Provider.of<AllproductProvider>(context, listen: false).filteredoutProduct}");
    // // Provider.of<Search_provider>(context, listen: false);
    // Provider.of<AllproductProvider>(context, listen: false).fetchproducts();
    // Provider.of<CategoryProvider>(context, listen: false).fetchcategory();
    // Provider.of<SubcategoryProvider>(context, listen: false).fetchSubCategory();
    // Provider.of<BrandProvider>(context, listen: false).fetchbrand();
    // Provider.of<AllproductProvider>(context, listen: false).setfilteredProduct(
    //     Provider.of<AllproductProvider>(context, listen: false)
    //         .allProducts
    //         .data!);
    // print(
    //     "LIst Of filtered DatatList22:::${Provider.of<AllproductProvider>(context, listen: false).filteredoutProduct}");
  }

  List<int> selectedCategoryIds = [];
  List<int> selectedSubcategoryIds = [];
  List<int> selectedBrandIds = [];
    String _searchQuery = '';
    bool _showSuggestions = false; 
      final TextEditingController _searchController = TextEditingController();



  String dropdownValue = 'ALL'; // Define dropdownValue here
  List<String> selectedCategories = []; // Define selectedCategories here
  List<String> selectedSubcategories = [];
  List<String> selectedBrands = [];
  @override
  Widget build(BuildContext context) {
    // Search_provider search_provider =
    //     Provider.of<Search_provider>(context, listen: false);
    final provider = Provider.of<AllproductProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leading: Container(
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 22,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'bottomnavbar');
            },
          ),
        ),
        title: const Text('Shop', style: TextStyle(color: Colors.white),),
        // actions: _buildActions(context),
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
                    0.94), // Change the color and opacity as needed
                BlendMode.srcATop, // Experiment with different blend modes
              ),
              child: Image.asset(
                'assets/background.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Consumer<AllproductProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01,
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Row(
                    children: [
                      DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            if (newValue == "Categories") {
                              selectedCategories.clear();
                            }
                            if (newValue == "Subcategories") {
                              selectedSubcategories.clear();
                            }
                            if (newValue == "Brands") {
                              selectedBrands.clear();
                            }
                          });
                        },
                        items: <String>[
                          'ALL',
                          'Categories',
                          'Subcategories',
                          'Brands'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                          width:
                              8), // Add spacing between dropdown and text field
                      // Expanded(
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       suffixIcon: const Icon(Icons.search),
                      //       contentPadding: EdgeInsets.symmetric(
                      //         vertical: MediaQuery.of(context).size.height * 0.01,
                      //         horizontal:
                      //             MediaQuery.of(context).size.width * 0.05,
                      //       ),
                      //       hintText: 'Search...',
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //     ),
                      //     onChanged: (value) {
                      //       provider.search(value);
                      //       print(value);
                      //     },
                      //   ),
                      // ),
                      // Expanded(
                      //     child: TextField(
                      //       decoration: InputDecoration(
                      //         suffixIcon: const Icon(Icons.search),
                      //         contentPadding: EdgeInsets.symmetric(
                      //           vertical:
                      //               MediaQuery.of(context).size.height * 0.01,
                      //           horizontal:
                      //               MediaQuery.of(context).size.width * 0.05,
                      //         ),
                      //         hintText: 'Search...',
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //       ),
                      //       onChanged: (value) {
                      //         setState(() {
                      //           _searchQuery = value;
                      //         });
                      //         provider.search(value);
                      //       },
                      //     ),
                      //   ),
                      //   if (_searchQuery.isNotEmpty)
                      //     Expanded(
                      //       child: SizedBox(
                      //         height: 100,
                      //         child: ListView(
                      //           children: provider
                      //               .getSuggestions(_searchQuery)
                      //               .map((product) {
                      //             return ListTile(
                      //               title: Text(product.title),
                      //               onTap: () {
                      //                 setState(() {
                      //                   _searchQuery = product.title;
                      //                 });
                      //                 provider.search(product.title);
                      //               },
                      //             );
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     ),
                      Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.search),
                              contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                horizontal:
                                    MediaQuery.of(context).size.width *
                                        0.05,
                              ),
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                                                    controller:_searchController,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                                 _showSuggestions = true;
                              });
                              provider.search(value);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                if (dropdownValue == 'Categories') // Inside your first consumer
                  Consumer<CategoryProvider>(
                    builder: (context, categoryProvider, child) {
                      List<String> categories = categoryProvider.categories!.data
                          .map((category) => category.title.toString())
                          .toList();
                      return Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.all(4),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: categories.map((category) {
                              return FilterChip(
                                selected: selectedCategories.contains(category),
                                label: Text(category),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedCategories.add(category);
                                    } else {
                                      selectedCategories.remove(category);
                                    }
        
                                    // Update the list of selected category IDs
                                    selectedCategoryIds = selectedCategories
                                        .map((category) => categoryProvider
                                            .categories!.data
                                            .firstWhere((element) =>
                                                element.title == category)
                                            .id!)
                                        .toList();
        
                                    // Filter products based on selected categories or show all products if no category is selected
                                    if (selectedCategories.isEmpty) {
                                      // If no category is selected, display all products
                                      Provider.of<AllproductProvider>(context,
                                              listen: false)
                                          .filterCategory([]);
                                    } else {
                                      // Otherwise, filter products by selected categories
                                      Provider.of<AllproductProvider>(context,
                                              listen: false)
                                          .filterCategory(selectedCategoryIds);
                                    }
        
                                    print(
                                        'Selected Categories: $selectedCategories'); // Print selected categories
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                if (dropdownValue == 'Subcategories')
                  Consumer<SubcategoryProvider>(
                    builder: (context, subcategoryProvider, child) {
                      List<String> subcategories = subcategoryProvider
                          .subcategories.data!
                          .map((subcategory) => subcategory.title.toString())
                          .toList();
                      return Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: subcategories.map((subcategory) {
                              return FilterChip(
                                selected:
                                    selectedSubcategories.contains(subcategory),
                                label: Text(subcategory),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedSubcategories.add(subcategory);
                                    } else {
                                      selectedSubcategories.remove(subcategory);
                                    }
        
                                    // Update the list of selected category IDs
                                    selectedSubcategoryIds = selectedSubcategories
                                        .map((subcategory) => subcategoryProvider
                                            .subcategories.data!
                                            .firstWhere((element) =>
                                                element.title == subcategory)
                                            .id!)
                                        .toList();
        
                                    // Filter products based on selected categories or show all products if no category is selected
                                    if (selectedSubcategories.isEmpty) {
                                      // If no category is selected, display all products
                                      Provider.of<AllproductProvider>(context,
                                              listen: false)
                                          .filterSubcategory([]);
                                    } else {
                                      // Otherwise, filter products by selected categories
                                      Provider.of<AllproductProvider>(context,
                                              listen: false)
                                          .filterSubcategory(
                                              selectedSubcategoryIds);
                                    }
        
                                    print(
                                        'Selected Categories: $selectedCategories'); // Print selected categories
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                if (dropdownValue == 'Brands')
                  Consumer<BrandProvider>(
                    builder: (context, brandProvider, child) {
                      List<String> brands = brandProvider.brands!.data!
                          .map((brand) => brand.title.toString())
                          .toList();
                      return Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: brands.map((brand) {
                              return FilterChip(
                                selected: selectedBrands.contains(brand),
                                label: Text(brand),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedBrands.add(brand);
                                    } else {
                                      selectedBrands.remove(brand);
                                    }
        
                                    // Update the list of selected category IDs
                                    selectedBrandIds = selectedBrands
                                        .map((subcategory) => brandProvider
                                            .brands!.data!
                                            .firstWhere((element) =>
                                                element.title == brand)
                                            .id!)
                                        .toList();
        
                                    if (selectedBrands.isEmpty) {
                                      // If no category is selected display all products
                                      Provider.of<AllproductProvider>(context,
                                              listen: false)
                                          .filterBrand([]);
                                    } else {
                                      Provider.of<AllproductProvider>(context,
                                              listen: false)
                                          .filterBrand(selectedBrandIds);
                                    }
        
                                    print(
                                        'Selected Categories: $selectedBrands'); // Print selected categories
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                Expanded(
                  child: Consumer<AllproductProvider>(
                    builder: (context, value, child) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.sizeOf(context).width * 0.02,
                          right: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        width: MediaQuery.sizeOf(context).width * 1,
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: value.filteredoutProduct.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 14,
                                    mainAxisSpacing: 17,
                                    childAspectRatio: 7 / 12),
                            itemBuilder: (context, i) {
                              return Container(
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
                                                      builder: (context) =>
                                                          Description(
                                                              product: value.products.data![i])));
                                            },
                                            child: SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.17,
                                              child: Image.network(
                                                AppUrl.baseUrl +
                                                    value.filteredoutProduct[i]
                                                        .image
                                                        .toString(),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.17,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.contain,
                                                errorBuilder:
                                                    (BuildContext context,
                                                        Object exception,
                                                        StackTrace? stackTrace) {
                                                  // Here you return your fallback image when the network image fails to load
                                                  return Image.asset(
                                                    'assets/agricultural.jpg', // The path to your local asset image
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.17,
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (value.filteredoutProduct[i].qty
                                                .toString() ==
                                            "0")
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(12),
                                                  bottomRight:
                                                      Radius.circular(12),
                                                ),
                                              ),
                                              child: const Text(
                                                'OUT OF STOCK',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.sizeOf(context).width *
                                              0.02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                            builder:
                                                (context, brandValue, child) {
                                              var brandID = value
                                                  .filteredoutProduct[i].brandId;
                                              var brand = brandValue.brands!.data!
                                                  .firstWhere(
                                                      (element) =>
                                                          element.id == brandID,
                                                      orElse: () => BrandData());
                                              return Text(
                                                  brand.title ?? 'Unknown Brand');
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (double.parse(value
                                                          .filteredoutProduct[i]
                                                          .discount ??
                                                      '0') >
                                                  0) ...[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 8.0),
                                                  child: Text(
                                                    'Rs.${value.filteredoutProduct[i].price}',
                                                    style: const TextStyle(
                                                        decoration: TextDecoration
                                                            .lineThrough,
                                                        color: Colors.grey,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        MediaQuery.sizeOf(context)
                                                                .width *
                                                            0.01),
                                                child: Text(
                                                  'Rs.${(double.parse(value.filteredoutProduct[i].price) - ((double.parse(value.filteredoutProduct[i].discount ?? '0') / 100) * double.parse(value.filteredoutProduct[i].price))).toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.amber),
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
                                    value.filteredoutProduct[i].qty.toString() ==
                                            "0"
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.sizeOf(context)
                                                        .height *
                                                    0.004),
                                            alignment: Alignment.center,
                                            child: Custom_Redbutton(
                                              text: 'OUT OF STOCK',
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      duration: Durations.short3,
                                                      content:
                                                          Text('OUT OF STOCK!')),
                                                );
                                              },
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.sizeOf(context)
                                                        .height *
                                                    0.004),
                                            alignment: Alignment.center,
                                            child: Custom_Button_Homepage(
                                              text: 'ADD TO CART',
                                              onPressed: () async {
                                                // var box = Hive.box('box');
                                                // List cartItems = box.get('cart');
                                                // // Check if the current product ID is already in the cart
                                                // if (!cartItems.contains(value
                                                //     .filteredoutProduct[i].id)) {
                                                //   cartItems.add(value
                                                //       .filteredoutProduct[i].id);
                                                //   await box.put('cart',
                                                //       cartItems); // Save the updated list back to the box
                                                //   ScaffoldMessenger.of(context)
                                                //       .showSnackBar(
                                                //     const SnackBar(
                                                //         duration:
                                                //             Durations.short3,
                                                //         content: Text(
                                                //             'Added to cart!')),
                                                //   );
                                                //   // print('hello: $cartItems');
                                                // } else {
                                                //   cartItems.contains(value
                                                //       .filteredoutProduct[i].id);
                                                //   ScaffoldMessenger.of(context)
                                                //       .showSnackBar(
                                                //     const SnackBar(
                                                //         duration:
                                                //             Durations.short3,
                                                //         content: Text(
                                                //             'Item already in cart')),
                                                //   );
                                                //   print(
                                                //       'product added: $cartItems');
                                                // }
                                                SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? token =
                                                      prefs.getString('Token');
                                                  print(
                                                      "thisd is the token::$token");
                                                  if (token != null &&
                                                      token.isNotEmpty) {
                                                    var box =
                                                        await Hive.openBox(
                                                            'box');
                                                    List<dynamic> cartItems = box
                                                        .get('cart', defaultValue: <dynamic>[]).cast<
                                                            dynamic>();
                                                    if (!cartItems.contains(
                                                        value.products.data![i]
                                                            .id)) {
                                                      cartItems.add(value
                                                          .products
                                                          .data![i]
                                                          .id);
                                                      await box.put(
                                                          'cart', cartItems);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                                'Added to cart!')),
                                                      );
                                                      print(cartItems);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                                'Item already in cart')),
                                                      );
                                                      print(cartItems);
                                                    }
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Login Required'),
                                                          content: const Text(
                                                              'You need to login to add the product to your cart.'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
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
                            }),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        if (_showSuggestions && _searchQuery.isNotEmpty)
            Positioned(
              top: MediaQuery.sizeOf(context).height*0.08,
              right: MediaQuery.sizeOf(context).width*0.03,
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width*0.57,
                  // height: 200,
                  height: min(
                      provider.getSuggestions(_searchQuery).length * MediaQuery.sizeOf(context).height*0.1,
                      MediaQuery.sizeOf(context).height *
                          0.4), // Adjust the multiplier and max height as needed
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children:
                        provider.getSuggestions(_searchQuery).map((product) {
                      return ListTile(
                        title: Text(product.title),
                        onTap: () {
                          setState(() {
                            _searchQuery = product.title;
                             _searchController.text =
                                product.title; // Update the controller text
                            // _searchController.selection =
                            //     TextSelection.fromPosition(
                            //   TextPosition(offset: product.title.length),
                            // ); // Move cursor to the end of the text
                             _showSuggestions = false; 
                          });
                          provider.search(product.title);
                          
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}