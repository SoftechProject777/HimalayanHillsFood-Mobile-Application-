import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/provider/allproduct_provider.dart';
import 'package:eccomerce/provider/banner_provider.dart';
import 'package:eccomerce/provider/bottom_nav_provider.dart';
import 'package:eccomerce/provider/brand_provider.dart';
import 'package:eccomerce/provider/cartPost_provider.dart';
import 'package:eccomerce/provider/cart_provider.dart';
import 'package:eccomerce/provider/category_provider.dart';
import 'package:eccomerce/provider/changepassword_provider.dart';
import 'package:eccomerce/provider/houseownerimage_provider.dart';
import 'package:eccomerce/provider/loggeduser_provider.dart';
import 'package:eccomerce/provider/order_provider.dart';
import 'package:eccomerce/provider/password_provider.dart';
import 'package:eccomerce/provider/product_provider.dart';
import 'package:eccomerce/provider/productimages_provider.dart';
import 'package:eccomerce/provider/resetpassword_provider.dart';
import 'package:eccomerce/provider/review_provider.dart';
import 'package:eccomerce/provider/search_provider.dart';
import 'package:eccomerce/provider/subcategory_provider.dart';
import 'package:eccomerce/provider/wishlist_provider.dart';
import 'package:eccomerce/provider/wishlistnewproduct_provider.dart';
import 'package:eccomerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  await Hive.openBox('box');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: 'test_public_key_a2f0d6b137624ca1a58c746617a99592',
      enabledDebugging: true,
      builder: (context, navKey) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PasswordProvider()),
            ChangeNotifierProvider(create: (_) => RegisteredProvider()),
            ChangeNotifierProvider(create: (_) => BottomNavProvider()),
            ChangeNotifierProvider(create: (_) => Search_provider()),
            ChangeNotifierProvider(
                create: (_) => Search_provider1(AllproductProvider())),
            ChangeNotifierProvider(create: (_) => BannerProvider()),
            ChangeNotifierProvider(create: (_) => CategoryProvider()),
            ChangeNotifierProvider(create: (_) => BrandProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => SubcategoryProvider()),
            ChangeNotifierProvider(create: (_) => ProductProvider()),
            ChangeNotifierProvider(create: (_) => AllproductProvider()),
            ChangeNotifierProvider(create: (_) => ProductImageProvider()),
            ChangeNotifierProvider(create: (_) => WishlistProvider()),
            ChangeNotifierProvider(create: (_) => ReviewProvider()),
            ChangeNotifierProvider(create: (_) => LoggedUserProvider()),
            ChangeNotifierProvider(create: (_) => WishlistAddProductProvider()),
            ChangeNotifierProvider(
                create: (_) => WishlistDeleteProductProvider()),
            ChangeNotifierProvider(create: (_) => OrderProvider()),
            ChangeNotifierProvider(create: (_) => HouseOwnerImageProvider()),
            ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
            ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
            ChangeNotifierProvider(create: (_) => CartPostProvider()),
            // ChangeNotifierProvider(create: (_)=> GoogleSignInProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Himalayan Hills Food',
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: ColorConstant.whiteColor,
              ),
              useMaterial3: true,
              colorSchemeSeed: ColorConstant.secondaryColor,
            ),
            initialRoute: 'splash',
            routes: routes,
            navigatorKey: navKey,
            localizationsDelegates: const [KhaltiLocalizations.delegate],
          ),
        );
      },
    );
  }
}
