import 'package:carousel_slider/carousel_slider.dart';
import 'package:eccomerce/Models/brand_model.dart';
import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/helper/custom_bannerbutton.dart';
import 'package:eccomerce/helper/custom_banner2.dart';
import 'package:eccomerce/helper/custom_brand.dart';
import 'package:eccomerce/helper/custom_button_homepage.dart';
import 'package:eccomerce/helper/custom_categorygrid.dart';
import 'package:eccomerce/helper/custom_gridhome.dart';
import 'package:eccomerce/helper/custom_tab_bar.dart';
import 'package:eccomerce/provider/banner_provider.dart';
import 'package:eccomerce/provider/brand_provider.dart';
import 'package:eccomerce/provider/category_provider.dart';
import 'package:eccomerce/provider/loggeduser_provider.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slide_countdown/slide_countdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// Scroll to the top
  ScrollController scrollController = ScrollController();
  bool showbtn = false;

  @override
  void initState() {
  
    scrollController.addListener(() {
      //scroll listener
      double showoffset =
          10.0; //Back to top botton will show on scroll offset 10.0

      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {
          //update state
        });
      } else {
        showbtn = false;
        setState(() {
          //update state
        });
      }
    });
    super.initState();
    () async {
      Provider.of<BannerProvider>(context, listen: false).fetchbanner();
      Provider.of<CategoryProvider>(context, listen: false).fetchcategory();
      Provider.of<BrandProvider>(context, listen: false).fetchbrand();
      // Provider.of<LoggedUserProvider>(context, listen: false).fetchloggeduser();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedOpacity(
        opacity: showbtn ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        child: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn);
          },
          backgroundColor: ColorConstant.primaryColor,
          child: const Icon(
            Icons.arrow_upward,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [ Container(height: double.infinity,width: double.infinity,
          decoration: const BoxDecoration(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.shade200.withOpacity(0.94), // Change the color and opacity as needed
                BlendMode.srcATop, // Experiment with different blend modes
              ),
              child: Image.asset('assets/background.jpeg', fit: BoxFit.cover,),

            ),

          ),SingleChildScrollView(
          controller: scrollController,
          // scrollDirection: Axis.vertical, // This syntax was the reason for blank page error.
          child: Column(
            children: [
              Container(
                // padding: const EdgeInsets.only(left: 8, right: 8),
                child: Consumer<BannerProvider>(
                  builder: (context, value, child) {
                    if (value.banners == null) {
                      return Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.95,
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              color: Colors.white,
                            ),
                          ),
                        );
                      // return const Center(
                      //   child: CircularProgressIndicator(),
                      // );
                    } else {
                      return SizedBox(
                          // height: 200,
                          child: CarouselSlider.builder(
                        itemCount: value.banners!.data!.length,
                        itemBuilder: (context, i, realIndex) {
                          // print(
                          //     "Banner Image Path: ${value.banners!.data![i].image}");
        
                          return Custom_bannerbutton(
                            text1:
                                value.banners!.data![i].title?.toString() ?? '',
                            buttonText: 'Shop Collection',
                            bottom: MediaQuery.sizeOf(context).height * 0.015,
                            right: MediaQuery.sizeOf(context).width * 0.09,
                            left: MediaQuery.sizeOf(context).width * 0.09,
                            top: MediaQuery.sizeOf(context).height * 0.05,
                            onPressed: () {
                              // handle button press
                            },
                            image:
                                value.banners!.data![i].image?.toString() ?? '',
                            isButton2: false,
                          );
                        },
                        options: CarouselOptions(
                          height: MediaQuery.sizeOf(context).height * 0.3,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          autoPlayCurve: Curves.linear,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 400),
                          viewportFraction: 1,
                        ),
                      ));
                    }
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.02,
                  right: MediaQuery.sizeOf(context).width * 0.02,
                  top: MediaQuery.sizeOf(context).height * 0.03,
                  bottom: MediaQuery.sizeOf(context).height * 0.02,
                  // bottom: MediaQuery.sizeOf(context).height * 0.03,
                ),
                child: Text(
                  'ORANGIC & FRESH PRODUCTS',
                  style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Custom_Grid(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.41,
                  axisDirection: Axis.horizontal,
                  crossAxisCount: 1,
                  childAspectRatio: 7 / 4,
                  mainAxisSpacing: 11,
                  crossAxisSpacing: 10),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.027,
                  right: MediaQuery.sizeOf(context).width * 0.027,
                  top: MediaQuery.sizeOf(context).height * 0.02,
                ),
                child: Stack(
                  children: [
                    Image(
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      width: MediaQuery.sizeOf(context).width,
                      image: const AssetImage('assets/banner.png'),
                    ),
                    Positioned(
                      left: MediaQuery.sizeOf(context).width * 0.65,
                      top: MediaQuery.sizeOf(context).height * 0.35,
                      bottom: MediaQuery.sizeOf(context).height * 0.02,
                      right: MediaQuery.sizeOf(context).width * 0.04,
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.sizeOf(context).width * 0.01),
                        child: const Text(
                          'FINEST QUALITY',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.02),
                child: Text(
                  'OUR BEST PRODUCTS',
                  style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Custom_Tab_Bar(),
              Custom_Button_Homepage(
                height: MediaQuery.sizeOf(context).height * 0.04,
                minWidth: MediaQuery.sizeOf(context).width * 0.06,
                text: 'LOAD MORE',
                onPressed: () {
                  Navigator.pushNamed(context, 'shop');
                },
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 50,
              ),
        
              // Categories Part
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'POPULAR CATEGORIES',
                  style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Consumer<CategoryProvider>(
                builder: (context, value, child) => Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.027,
                      vertical: MediaQuery.sizeOf(context).width * 0.02),
                  height: MediaQuery.sizeOf(context).height * 0.35,
                  width: MediaQuery.sizeOf(context).width,
                  child: value.categories != null
                      ? GridView.builder(
                          itemCount: value.categories!.data.length,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 0,
                                  childAspectRatio: 4 / 3.5,
                                  // mainAxisExtent: 2,
                                  crossAxisCount: 1),
                          itemBuilder: (context, i) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(255, 255, 249, 228),
                              ),
        
                              // color: Colors.red,
        
                              child: Custom_CategoryGrid(
                                image: value.categories!.data[i].image
                                        ?.toString() ??
                                    '',
                                text: value.categories!.data[i].title
                                        ?.toString() ??
                                    '',
                              ),
                            );
                          })
                      : Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: GridView.builder(
                  itemCount: 5, // Adjust the number of shimmer items here
                  scrollDirection: Axis.horizontal,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 0,
                    childAspectRatio: 4 / 3.5,
                    crossAxisCount: 1,
                  ),
                  itemBuilder: (context, i) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
    
                ),
              ),
        
              // Offer Part
              Container(
                alignment: Alignment.center,
                // color: Colors.amber,
                padding: const EdgeInsets.only(top: 12),
                // width: MediaQuery.sizeOf(context).width * 1,
                // height: MediaQuery.sizeOf(context).height * 0.42,
                // color: Colors.black,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/parallax.png',
                      height: MediaQuery.sizeOf(context).height * 0.4,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: MediaQuery.sizeOf(context).width * 0.1,
                      right: MediaQuery.sizeOf(context).width * 0.1,
                      top: MediaQuery.sizeOf(context).height * 0.009,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'SUPER DEALS OF THE WEEK',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          const Text(
                            '50% OFF',
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SlideCountdownSeparated(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.sizeOf(context).width * 0.04,
                                vertical: 5),
                            style: const TextStyle(
                                fontSize: 28, color: Colors.white),
                            duration: const Duration(days: 5),
                            showZeroValue: true,
                            countUp: false,
                            slideDirection: SlideDirection.down,
                            decoration: BoxDecoration(
                                color: ColorConstant.primaryColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: ColorConstant.secondaryColor)),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * 0.07,
                                ),
                                child: const Text(
                                  'Day',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * 0.14,
                                ),
                                child: const Text(
                                  'Hour',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.sizeOf(context).width * 0.1),
                                child: const Text(
                                  'Minute',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.sizeOf(context).width * 0.08,
                                    right:
                                        MediaQuery.sizeOf(context).width * 0.02),
                                child: const Text(
                                  'Seconds',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.sizeOf(context).height * 0.01),
                            child: const Text(
                              '🌟 Dive into Nutritious Delights! Enjoy a Whopping 50% OFF on our Premium Lentils this Week! 🌱 Hurry, Grab Your Super Deal Now!',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Custom_Button_Homepage(
                            text: 'SHOP NOW',
                            onPressed: () {
                              Navigator.pushNamed(context, 'shop');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Brand Part
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.02),
                child: Text(
                  'Brands',
                  style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Consumer<BrandProvider>(builder: (context, value, child) {
                if (value.brands?.data == null || value.brands!.data!.isEmpty) {
                  // Fetch data from Hive if not available from API
                  final box = Hive.box('box');
                  final brandData = box.get('brandData');
                  print("Helloo theeesse isss the brands Dataaaaa:::$brandData");
                  if (brandData != null) {
                    // Update the brand data in the provider
                          final Map<String, dynamic> brandMap =
                        Map<String, dynamic>.from(brandData);
        
                    value.brands = BrandModel.fromJson(brandMap);
                  }
                  return Center(
                      child: SizedBox(
                         height: MediaQuery.sizeOf(context).height * 0.27,
                        // color: Colors.black,
                        width: MediaQuery.sizeOf(context).width * 1,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: GridView.builder(
                            itemCount:
                                5, // Adjust the number of shimmer items here
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 0,
                              childAspectRatio: 12 / 10,
                              crossAxisCount: 1,
                            ),
                            itemBuilder: (context, i) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                }
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.027,
                      vertical: MediaQuery.sizeOf(context).height * 0.02),
                  height: MediaQuery.sizeOf(context).height * 0.27,
                  // color: Colors.black,
                  width: MediaQuery.sizeOf(context).width * 1,
                  child: value.brands != null && value.brands!.data != null
                      ? GridView.builder(
                          itemCount: value.brands!.data!.length,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 0,
                                  childAspectRatio: 12 / 10,
                                  // mainAxisExtent: 2,
                                  crossAxisCount: 1),
                          itemBuilder: (context, i) {
                            return Center(
                              child: Custom_Brand(
                                image:
                                    value.brands!.data![i].image?.toString() ?? '',
                                text:
                                    value.brands!.data![i].title?.toString() ?? '',
                              ),
                            );
                          },
                        )
                      : const CircularProgressIndicator(),
                );
              }),
            ],
          ),
        ),],
      ),
    );
  }
}
