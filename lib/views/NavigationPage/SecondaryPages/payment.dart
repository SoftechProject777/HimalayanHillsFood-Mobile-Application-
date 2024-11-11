import 'package:eccomerce/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
         
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.05),
              child: Row(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.035,
                    child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 41, 194, 166),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        )),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.035,
                    child: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 41, 194, 166),
                      child: Text(
                        '1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.035,
                    child: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 194, 194, 194),
                      child: Text(
                        '1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shipping',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Payment',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    'Review',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  ),
                ],
              ),
            ),
          
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, bottom: 12),
              child: const Text(
                'Credit or Debit Card',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.05,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.027),
              child: TextFormField(
                decoration: const InputDecoration(
                    // prefix: Icon(Icons.abc),
                    prefix: Image(
                      height: 50,
                      width: 50,
                      image: AssetImage('assets/visa.png'),
                    ),
                    // prefix: Image(image: AssetImage('images/visa.png')),
                    hintText: 'XXXX - XXXX - XXXX',
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),

        
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 12),
              child: Text(
                'Enter card number, expiration date and CVV number',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
         
            custom_Payment_Method(
              text: 'PAY WITH KHALTI',
              image: 'assets/khalti.png',
              onPressed: () {
                payWithKhaltiInApp();
              },
            ),
            custom_Payment_Method(
              text: 'Cash on Delivery',
              image: 'assets/cash-on-delivery.jpg',
              onPressed: () {
                Navigator.pushNamed(context, 'checkout');
              },
            ),
           
          ],
        ),
      ),
    );
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "Product Id",
          productName: "Product Name"),
      preferences: [PaymentPreference.khalti],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Payment Successful'),
            actions: [
              SimpleDialogOption(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.pushNamed(context, 'bottomnavbar');
                },
              )
            ],
          );
        });
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }

  void onCancel() {
    debugPrint("Cancelled");
  }
}

class custom_Payment_Method extends StatelessWidget {
  final String text;
  final String image;
  final void Function()? onPressed;
  const custom_Payment_Method({
    super.key,
    required this.text,
    required this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).height * 0.012,
      ),
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.01),
      height: MediaQuery.sizeOf(context).height * 0.075,
      child: MaterialButton(
        splashColor: ColorConstant.primaryColor,
        elevation: 5,
        onPressed: onPressed,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.black)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.065,
              child: Image(
                image: AssetImage(image),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.04),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
