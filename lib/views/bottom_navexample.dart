import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/helper/drawer_tab.dart';
import 'package:eccomerce/provider/bottom_nav_provider.dart';
import 'package:eccomerce/views/NavigationPage/cart_page.dart';
import 'package:eccomerce/views/NavigationPage/home_page.dart';
import 'package:eccomerce/views/NavigationPage/profile_page.dart';
import 'package:eccomerce/views/NavigationPage/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  static const List _widgetOptions = [
    HomePage(),
    WishlistPage(),
    CartPage(),
    ProfilePage(),
  ];
  final Color _iconColor = Colors.black;
  final bool _showText = false;
    final bool _isTapped = false;


  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          // backgroundColor: ColorConstant.blackColor,
          foregroundColor: Colors.black,
          shadowColor: const Color.fromARGB(255, 167, 133, 133),
          elevation: 0,
          title: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.25),
            child: Image(
              height: MediaQuery.sizeOf(context).height * 0.06,
              image: const AssetImage('assets/favicon.png'),
              alignment: Alignment.center,
            ),
          ),
          actions: [
            Container(
              margin:  EdgeInsets.only(right: MediaQuery.sizeOf(context).width*0.03),
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                // color: Colors.amber,
                color: _isTapped
                    ? Colors.green
                    : Colors.amber, // Change color based on _isTapped

                splashColor: Colors.green,
                onPressed: () {
                  Navigator.pushNamed(context, 'shop');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      // Icons.shopping_bag,
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      'Shop',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
            )
            // Padding(
            //   padding: const EdgeInsets.only(right: 15),
            //   child: GestureDetector(
            //     onLongPress: () {
            //       setState(() {
            //         _showText = true;
            //       });
            //     },
            //     onLongPressEnd: (_) {
            //       setState(() {
            //         _showText = false;
            //       });
            //     },
            //     child: InkWell(
            //                  onTap: () {
            //           Navigator.pushNamed(context, 'shop');
            //           setState(() {
            //             _iconColor =
            //                 ColorConstant.primaryColor; // Change this to your desired color
            //           });
            //         },
            //         child:  Row(
            //           children: [
            //               _showText ? const Text('Shop') : const SizedBox(),
            //             Icon(Icons.shopping_bag, color: _iconColor,),

            //           ],
            //         )),
            //   ),
            // ),
          ],
        ),
        drawer: const DrawerTab(),
        body: Center(
          child: _widgetOptions.elementAt(value.selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorConstant.primaryColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Wishlist',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_checkout_outlined),
              label: 'Cart',
              backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: value.selectedIndex,
          selectedItemColor: ColorConstant.whiteColor,
          onTap: (index) {
            value.onItemTapped(index);
          },
        ),
      ),
    );
  }
}
