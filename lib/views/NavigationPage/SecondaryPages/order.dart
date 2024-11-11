
import 'package:eccomerce/Models/product_model.dart';
import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/provider/allproduct_provider.dart';
import 'package:eccomerce/provider/loggeduser_provider.dart';
import 'package:eccomerce/provider/order_provider.dart';
import 'package:eccomerce/views/NavigationPage/SecondaryPages/descripition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int _expandedTileIndex = -1; // To track the expanded tile

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var loggedUserProvider =
          Provider.of<LoggedUserProvider>(context, listen: false);
      var orderProvider = Provider.of<OrderProvider>(context, listen: false);
      var loggerUser = loggedUserProvider.loggedUsers?.user?.id;
      if (loggerUser != null) {
        orderProvider.fetchOrder(loggerUser);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 22,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'bottomnavbar');
          },
        ),
        title: const Text('My Order', style: TextStyle(color: Colors.white),),
      ),
      body:Stack(
        children: [Container(height: double.infinity,width: double.infinity,
          decoration: const BoxDecoration(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.shade200.withOpacity(0.94), // Change the color and opacity as needed
                BlendMode.srcATop, // Experiment with different blend modes
              ),
              child: Image.asset('assets/background.jpeg', fit: BoxFit.cover,),

            ),),Consumer<OrderProvider>(
            builder: (context, orderValue, child) {
              if (orderValue.orders == null) {
                return const Center(child: CircularProgressIndicator());
              }
               if (!orderValue.successlogin || orderValue.orders!.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'My Order is Empty',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                );
              }
              if (!orderValue.successlogin) {
                return const Center(
                  child: Text(
                    'Error fetching order details or No order details available.',
                  ),
                );
              }
              return ListView.builder(
                itemCount: orderValue.orders!.data!.length,
                itemBuilder: (context, index) {
                  var order = orderValue.orders!.data![index];
                  return Container(
                     margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.02),
                    child: Card(
                      color: Colors.green.shade200,
                      shadowColor: Colors.grey.shade300, // Color of the shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Adjust the border radius as needed
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
                        child: ExpansionTile(
                            key: PageStorageKey<int>(index),
                            initiallyExpanded: _expandedTileIndex == index,
                            onExpansionChanged: (bool expanded) {
                              if (expanded) {
                                setState(() {
                                  _expandedTileIndex = index;
                                });
                                orderProvider.fetchParticularOrder(order.cartId!);
                              } else {
                                setState(() {
                                  _expandedTileIndex = -1;
                                });
                              }
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Order ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white,
                                    fontSize: 16),),
                                Text('Date: ${order.createdAt!.substring(0, 10)}', style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16) ,),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Status: ${order.status!}', style: TextStyle(color: Colors.green.shade900, fontSize: 14),),
                                    Text(
                                        'Time: ${order.createdAt!.substring(11, 19)}', style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade900,
                                        fontSize: 14),
                                  ),
                                  ],
                                ),
                                Text('Total Amount: Rs.${order.totalAmount}',
                                style: TextStyle(
                                    color: Colors.green.shade900, fontSize: 14),
                              ),
                                Text('Delivery Charge: ${order.deliveryCharge}',
                                style: TextStyle(
                                    color: Colors.green.shade900, fontSize: 14),
                              ),
                              ],
                            ),
                            // : [
                            //     ListTile(
                            //       title: ElevatedButton(
                            //         onPressed: () {
                            //           orderProvider
                            //               .fetchParticularOrder(order.cartId!);
                            //         },
                            //         child: const Text('View Order Details'),
                            //       ),
                            //     ),
                            //   ],
                            tilePadding: EdgeInsets.all(MediaQuery.sizeOf(context).width*0.03), // Remove padding to avoid extra space
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          childrenPadding:  EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.01),
                            children:
                                // _expandedTileIndex == index &&
                                //         orderProvider.orderdetails != null
                                //     ?
                                [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int productIndex = 0;
                                      productIndex <
                                          (orderProvider.orderdetails?.data?.length ??
                                              0);
                                      productIndex++)
                                    // for (int productIndex = 0;
                                    //     productIndex <
                                    //         orderProvider
                                    //             .orderdetails!.data!.length;
                                    //     productIndex++)
                                    Consumer<AllproductProvider>(
                                      builder: (context, value, child) {
                                        var item = orderProvider
                                            .orderdetails!.data![productIndex];
                                        var product = value.products.data?.firstWhere(
                                          (p) => p.id == item.productId,
                                          orElse: () => ProductData(
                                              title: '',
                                              price: '',
                                              discount: '',
                                              qty: ''),
                                        );
                                        return ListTile(
                                          title: Column(
                                            children: [
                                              Consumer<AllproductProvider>(
                                                builder: (context, value, child) {
                                                  var item = orderProvider
                                                      .orderdetails!
                                                      .data![productIndex];
                                                  var product =
                                                      value.products.data?.firstWhere(
                                                    (p) => p.id == item.productId,
                                                    orElse: () => ProductData(
                                                        title: '',
                                                        price: '',
                                                        discount: '',
                                                        qty: ''),
                                                  );
                                                  return Row(
                                                    children: [
                                                      Text('${productIndex + 1}.  ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .green.shade900,
                                                          fontSize: 16),
                                                    ),
                                                      Expanded(
                                                        child: Text(
                                                          product!.title,
                                                          softWrap: true,
                                                          overflow: TextOverflow.clip,
                                                          maxLines: null,
                                                          // Allows unlimited lines
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .green.shade900,
                                                            fontSize: 14),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Consumer<AllproductProvider>(
                                                    builder: (context, value, child) {
                                                      var item = orderProvider
                                                          .orderdetails!
                                                          .data![productIndex];
                                                      var product = value
                                                          .products.data
                                                          ?.firstWhere(
                                                        (p) => p.id == item.productId,
                                                        orElse: () => ProductData(
                                                            title: '',
                                                            price: '',
                                                            discount: '',
                                                            qty: ''),
                                                      );
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Description(
                                                                      product:
                                                                          product!),
                                                            ),
                                                          );
                                                        },
                                                        child: SizedBox(
                                                          height: MediaQuery.sizeOf(
                                                                      context)
                                                                  .height *
                                                              0.17,
                                                          width:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.3,
                                                          child: Image.network(
                                                            AppUrl.baseUrl +
                                                                (product?.image ??
                                                                    ''),
                                                            height:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                    0.17,
                                                            width:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .width *
                                                                    0.3,
                                                            fit: BoxFit.contain,
                                                            errorBuilder:
                                                                (BuildContext context,
                                                                    Object exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              return Image.asset(
                                                                'assets/agricultural.jpg',
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.17,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                fit: BoxFit.cover,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          'Quantity: ${item.quantity}',style: const TextStyle(
                                                          
                                                          color: Colors
                                                              .white,
                                                          fontSize: 16),),
                                                      Text('Price: Rs.${item.price}',
                                                      style: const TextStyle(
                                                          
                                                          color: Colors
                                                              .white,
                                                          fontSize: 16),
                                                    ),
                                                      Text(
                                                          'After Discount: Rs.${item.afterDiscount}',
                                                      style: const TextStyle(
                                                          
                                                          color: Colors
                                                              .white,
                                                          fontSize: 16),
                                                    ),
                                                      Text(
                                                          'Total Amount: Rs.${item.totalAmount}',
                                                      style: const TextStyle(
                                                          
                                                          color: Colors
                                                              .white,
                                                          fontSize: 16),
                                                    ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ], // Adjust padding as needed
                            ),
                      ),
                    ),
                  );
                },
              );
            },
          ),],
      ),
      
    );
  }
}
