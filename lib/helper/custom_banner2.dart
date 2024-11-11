import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/constant/color_constant.dart';
import 'package:flutter/material.dart';

class Custom_Banner2 extends StatelessWidget {
  final String text;
  final String text2;
  final String text3;
  final String image;
  const Custom_Banner2({
    super.key,
    required this.text,
    required this.text2,
    required this.text3,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.027,
        right: MediaQuery.of(context).size.width * 0.027,
        top: MediaQuery.of(context).size.height * 0.015,
      ),

      // bottom: MediaQuery.of(context).viewInsets.bottom + 10

      child: Stack(
        children: [
          Image(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover,
              image: NetworkImage(AppUrl.baseUrl + image)),
          Container(
            padding: EdgeInsets.only(top: 20, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  text,
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
                Text(
                  text2,
                  style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  maxLines: 3,
                ),
                MaterialButton(
                  color: Colors.transparent,
                  splashColor: ColorConstant.primaryColor,
                  elevation: 0,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        width: 3.0,
                        color: ColorConstant.primaryColor,
                        style: BorderStyle.solid,
                      )),
                  child: Text(
                    text3,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
