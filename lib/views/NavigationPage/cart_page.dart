import 'package:eccomerce/Models/brand_model.dart';
import 'package:eccomerce/Models/product_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/provider/allproduct_provider.dart';
import 'package:eccomerce/provider/brand_provider.dart';
import 'package:eccomerce/provider/cart_provider.dart';
import 'package:eccomerce/provider/product_provider.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/descripition.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../Models/category_model.dart';
import '../../provider/category_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    var box = Hive.box('box');

    List? cartItems = box.get('cart'); // Use nullable List type
    if (cartItems != null) {
      print(cartItems.length);
      // print("CARTITEMS:$cartItems");
    } else {
      print('Cart is null'); // Handle null case here
    }
    // List cartItems = box.get('cart');
    // print(cartItems.length);
    // print("CARTITEMS:$cartItems");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllproductProvider>(builder: (context, value, child) {
      if (value.products.data!.isEmpty && value.products.data != null) {
        return const Center(
          child: Text('Server Error!'),
        );
      }
      print(
          "PRODUCT: ${value.products.data!}"); // prints Instance of ProductData
      return CartPageView(
      productList: value.products.data!,
              );
    });
  }
}

class CartPageView extends StatefulWidget {
  const CartPageView({super.key, required this.productList});

  final List<ProductData> productList;
  @override
  State<CartPageView> createState() => _CartPageViewState();
}

class _CartPageViewState extends State<CartPageView> {
  @override
  void initState() {
    super.initState();
    getValues();
  }

  var box = Hive.box('box');
  List<ProductData> cartProduct = [];

  Map<int, int> quantity = {};

  Future<void> getValues() async {
    List<ProductData>? productList = widget.productList;

    List? cartItems = box.get('cart') ?? [];

    List? cartProductList = cartItems!.toSet().toList();

    cartProduct.clear();

    if (cartProductList.isNotEmpty) {
      for (int j = 0; j < cartProductList.length; j++) {
        productList
            .where((element) => element.id == cartProductList[j])
            .forEach((element) {
          cartProduct.add(element);
        });
      }
    }

    for (int number in cartItems) {
      quantity[number] = (quantity[number] ?? 0) + 1;
    }
  }
  addItem(id) {
    // cartProduct!.clear();
    quantity = {};
    List? cartItems = box.get('cart');
    if (cartItems != null && cartItems.isNotEmpty) {
      cartItems.add(id);
      print("Item added to cart: $id");
      box.put('cart', cartItems);
    }
    cartProduct.clear();
    getValues();
    setState(() {});
  }

  decreseItem(id) {
    if (quantity[id]! > 1) {
      cartProduct.clear();
      quantity = {};
      List? cartItems = box.get('cart');

      if (cartItems != null && cartItems.isNotEmpty) {
        cartItems.remove(id);

        box.put('cart', cartItems);
      }
      getValues();
      setState(() {});
    }
  }

  deleteItem(id) {
    List? cartItems = box.get('cart');

    if (cartItems != null && cartItems.isNotEmpty) {
      for (int i = 0; i < quantity[id]!; i++) {
        cartItems.remove(id);
      }

      box.put('cart', cartItems);
    }

    cartProduct.clear();
    quantity = {};
    getValues();
    setState(() {});
  }

  double calculateTotal() {
    double total = 0;
    for (int id in quantity.keys) {
      ProductData product =
          cartProduct.firstWhere((element) => element.id == id);
      double itemTotal = (double.parse(product.price) -
              ((double.parse(product.discount ?? '0') / 100) *
                  double.parse(product.price))) *
          quantity[id]!;
      total += itemTotal;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal();
    // return Text(cartProduct!.length.toString());
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

            ),),cartProduct.isNotEmpty
            ? SingleChildScrollView(
                child: Consumer<AllproductProvider>(
                    builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: const Text(
                          'Your Cart',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: cartProduct.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          print('CARTy: ${cartProduct[index]}');
                          print('CART: ${cartProduct.length}');
                          final product = cartProduct[index];
                          return CartProduct(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Description(
                                        product: cartProduct[index]),
                                  ),
                                );
                              },
                              data: product,
                              quantity: quantity[product.id]!,
                              delete: () => deleteItem(product.id),
                              increase: () => addItem(product.id),
                              decrease: () => decreseItem(product.id),
                              calculateTotal: () => calculateTotal());
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        height: 170,
                        width: 360,
                        color: Colors.grey.shade300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20, left: 12),
                                  child: Text(
                                    'Subtotal',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 12, top: 20),
                                  child: Text(
                                    // '\$685',
                                    '---',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20, left: 12),
                                  child: Text(
                                    'Shipping',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 12, top: 20),
                                  child: Text(
                                    '---',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20, left: 12),
                                  child: Text(
                                    'Taxes',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 12, top: 20),
                                  child: Text(
                                    '---',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 20, left: 12),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 12, top: 20),
                                  child: Text(
                                    'Rs. $total',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'BACK',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  )),
                            ),
                            Container(
                              height: 60,
                              width: 270,
                              padding: const EdgeInsets.only(
                                  left: 50, top: 20, right: 8),
                              child: MaterialButton(
                                height: 50,
                                elevation: 0,
                                onPressed: () {
                                  Navigator.pushNamed(context, 'payment');
                                },
                                color: ColorConstant.secondaryColor,
                                splashColor: ColorConstant.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'CONTINUE TO CHECKOUT',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },),
              )
            : const Center(
                child: Text('Cart is Empty!'),
              ),],
      ),
    );
  }
}

class CartProduct extends StatelessWidget {
  const CartProduct({
    super.key,
    required this.data,
    required this.quantity,
    this.increase,
    this.delete,
    this.decrease,
    this.calculateTotal,
    this.onTap,
  });

  final ProductData data;
  final int quantity;
  final void Function()? increase;
  final void Function()? delete;
  final void Function()? decrease;
  final void Function()? calculateTotal;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Consumer<AllproductProvider>(
      builder: (context, value, child) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.015),
          child: Card(
            color: Colors.green.shade200,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.02,
                  bottom: MediaQuery.sizeOf(context).height * 0.02),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onTap,
                       
                        child: Image(
                          height: MediaQuery.sizeOf(context).height * 0.13,
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          image: NetworkImage(
                              AppUrl.baseUrl + data.image.toString()),
                          fit: BoxFit.fitHeight,
                        ),
                       
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 20),
                              child: Text(
                                data.title,
                                maxLines: 3,
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.green.shade900, fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * 0.01,
                                  top: MediaQuery.sizeOf(context).height *
                                      0.006),
                              //     child: Row(children:[Text(data.categoryId.toString()),
                              //   Text(data.subcategoryId.toString())
                              // ]),
                              child: Consumer<BrandProvider>(
                                builder: (context, brandvalue, child) {
                                  BrandModel brand = brandvalue.brands!;
                                  var brandData = brand.data!.firstWhere(
                                      (element) => element.id == data.brandId,
                                      orElse: () =>
                                          BrandData(title: "Unknown Brand"));
                                  return Text(
                                    brandData.title!,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  );
                                },
                              ),
                     
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: delete,
                        splashColor: Colors.red,
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Colors.white,
                        ),
                      ),
                    
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.sizeOf(context).height * 0.01),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.sizeOf(context).width * 0.09),
                          child: const Text(
                            'Qty',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.sizeOf(context).width * 0.05),
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          width: MediaQuery.sizeOf(context).width * 0.15,
                          color: Colors.grey.shade100,
                          child: IconButton(
                              onPressed: decrease,
                              icon: Icon(
                                Icons.remove,
                                size: 25,
                                color: Colors.grey.shade400,
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            quantity.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          width: MediaQuery.sizeOf(context).width * 0.15,
                          color: Colors.grey.shade300,
                          child: IconButton(
                              onPressed: increase,
                              icon: Icon(
                                Icons.add,
                                size: 25,
                                color: Colors.green.shade800,
                              )),
                        ),
                        const Spacer(),
                        Container(
                          margin: EdgeInsets.only(
                            right: MediaQuery.sizeOf(context).width * 0.06,
                          ),
                          child: Text(
                            'Rs.${(double.parse(data.price) - ((double.parse(data.discount!) / 100) * double.parse(data.price))) * quantity}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
             
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
