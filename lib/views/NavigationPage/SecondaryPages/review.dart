import 'package:eccomerce/constant/color_constant.dart';
import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 12, bottom: 12),
              child: Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 30,
                    child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 41, 194, 166),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        )),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 30,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 41, 194, 166),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 30,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 41, 194, 166),
                      child: Text(
                        '1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Shipping',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 75),
                  child: Text(
                    'Payment',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90),
                  child: Text(
                    'Review',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 22, top: 20),
                  // decoration: BoxDecoration(color: Colors.grey),
                  child: Image.asset(
                    'assets/lentil.png',
                    height: 80,
                    width: 50,
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
                          'FRANCE AUTHENTIC JERSEY 2018 (L) (HOME)',
                          maxLines: 3,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Text(
                          'NIKE',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 80,
                  ),
                  child: Text(
                    'Qty: 1',
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Text(
                    '\$165',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20, bottom: 10),
              child: Text(
                'Order confirmation sent to',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Text('arnav@gmail.com')),
            Container(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Text(
                  'Shipping to:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            Container(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Francisco Roman Alarcon'),
                  Text('1060 W Addison St #13'),
                  Text('Chicago,IL 60613'),
                  Text('(123) 456-7890'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'Payment Method:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    height: 40,
                    width: 40,
                    image: AssetImage('assets/visa.png'),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Text('ending in 8765')),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  'Billing Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            Container(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Text('Same as shipping address')),
            const Divider(
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 205,
              width: 360,
              // color: Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 12),
                        child: Text(
                          'Subtotal',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12, top: 20),
                        child: Text(
                          '\$165',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 12),
                        child: Text(
                          'Shipping',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12, top: 20),
                        child: Text(
                          'FREE',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 12),
                        child: Text(
                          'Expected Delivery',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12, top: 20),
                        child: Text(
                          'Apr 20 - 28',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 12),
                        child: Text(
                          'Taxes',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12, top: 20),
                        child: Text(
                          '\$11.55',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 12),
                        child: Text(
                          'Total',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12, top: 20),
                        child: Text(
                          '\$685',
                          style: TextStyle(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 15),
                  height: 70,
                  width: 250,
                  padding: EdgeInsets.only(left: 50, top: 20),
                  child: MaterialButton(
                    height: 50,
                    elevation: 0,
                    onPressed: () {
                      Navigator.pushNamed(context, 'bottomnavbar');
                    },
                    color: ColorConstant.secondaryColor,
                    splashColor: ColorConstant.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Finish Checkout',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
