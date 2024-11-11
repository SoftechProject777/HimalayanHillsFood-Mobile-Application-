import 'package:eccomerce/Models/product_model.dart';
import 'package:eccomerce/constant/color_constant.dart';
import 'package:eccomerce/provider/allproduct_provider.dart';
import 'package:eccomerce/provider/cartPost_provider.dart';
import 'package:eccomerce/provider/loggeduser_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';


class CashOnDelivery extends StatefulWidget {
  const CashOnDelivery({super.key});

  @override
  State<CashOnDelivery> createState() => _CashOnDeliveryState();
}

class _CashOnDeliveryState extends State<CashOnDelivery> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LoggedUserProvider>(context, listen: false).fetchLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('box');
    List? cartItems = box.get('cart') ?? [];
    // Create a map to store the quantity of each item
    Map<int, int> itemCounts = {};
    for (var itemId in cartItems!) {
      itemCounts[itemId] = (itemCounts[itemId] ?? 0) + 1;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: const Text(
          'Cash On Delivery',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        leading: InkWell(
          child: const Icon(Icons.arrow_back, color: Colors.white,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                height: MediaQuery.sizeOf(context).height * 0.8,
                width: MediaQuery.sizeOf(context).width,
                image: const AssetImage("assets/QR.jpg"),
              ),
              const Text(
                "Shipping Address",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Custom_CheckOutTextFormField(
                text: 'Full Name',
              ),
              const SizedBox(
                height: 10,
              ),
              const Custom_CheckOutTextFormField(
                text: 'Address 1',
              ),
              const SizedBox(
                height: 10,
              ),
              const Custom_CheckOutTextFormField(
                text: 'Address 2',
              ),
              const SizedBox(
                height: 10,
              ),
              const Custom_CheckOutTextNumberField(
                text: 'Contact No.',
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Billing Address",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Custom_CheckOutTextFormField(
                text: 'Full Name',
              ),
              const SizedBox(
                height: 10,
              ),
              const Custom_CheckOutTextFormField(
                text: 'Address 1',
              ),
              const SizedBox(
                height: 10,
              ),
              const Custom_CheckOutTextFormField(
                text: 'Address 2',
              ),
              const SizedBox(
                height: 10,
              ),
              const Custom_CheckOutTextNumberField(
                text: 'Contact No.',
              ),
              const SizedBox(
                height: 10,
              ),
           
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
              
                  Consumer3<AllproductProvider, LoggedUserProvider, CartPostProvider>(
  builder: (context, productValue, loggedValue, cartValue, child) {
    List<ProductData> products = productValue.products.data ?? [];
    double totalAmount = 0;
    final userId = loggedValue.loggedUsers?.user?.id;
    List<Map<String, String>> cartItems = [];

    for (var itemId in itemCounts.keys) {
      var quantity = itemCounts[itemId];
      var product = products.firstWhere(
        (p) => p.id == itemId,
        orElse: () => ProductData(
          title: 'Unknown Product',
          price: '0',
          discount: '0',
          qty: '',
        ),
      );
      double price = double.tryParse(product.price) ?? 0;
      double discountPercentage = double.tryParse(product.discount!) ?? 0;

      // Calculate the discounted price
      double discountedPrice = price - (price * discountPercentage / 100);

      double itemTotal = discountedPrice * quantity!;
      totalAmount += itemTotal;

      // Add cart item to the list
      var cartItem = {
        "unique_id": product.uniqueId!,
        "product_id": product.id.toString(),
        "user_id": userId.toString(),
        "title": product.title,
        "image": product.image!,
        "link": "https://www.youtube.com/",
        "org_price": price.toStringAsFixed(2),
        "after_discount": discountedPrice.toStringAsFixed(2),
        "quantity": quantity.toString(),
        "total_amount": itemTotal.toStringAsFixed(2),
      };
      cartItems.add(cartItem);

      // Print the cart item
      print("Hello parrot$cartItem");
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 60,
      width: 250,
      padding: const EdgeInsets.only(left: 50, top: 20),
      child: MaterialButton(
        height: 50,
        elevation: 0,
        onPressed: () async {
           await cartValue.postCart(cartItems);
          if (cartValue.successregister == true) {
            //Clearing the cart in Hive
            box.put('cart', []);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Success! Order has been made.'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushNamed(context, 'bottomnavbar');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to add items to cart.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        color: ColorConstant.secondaryColor,
        splashColor: ColorConstant.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Continue to Payment',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
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
  }
}
class Custom_CheckOutTextFormField extends StatelessWidget {
  final String text;
  const Custom_CheckOutTextFormField({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.02),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class Custom_CheckOutTextNumberField extends StatelessWidget {
  final String text;
  const Custom_CheckOutTextNumberField({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.02),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
