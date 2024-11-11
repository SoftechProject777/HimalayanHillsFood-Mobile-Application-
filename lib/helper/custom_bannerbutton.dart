import 'package:eccomerce/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:eccomerce/constant/app_urls.dart';

class Custom_bannerbutton extends StatelessWidget {
  final String? text1;
  final String? text3;
  final void Function()? onPressed;
  final String? buttonText;
  final bool? isButton2;
  final String image;
  final String? buttonText2;
  final Color? textColor;
  final double? bottom;
  final double? right;
  final double? top;
  final double? left;
  const Custom_bannerbutton({
    super.key,
    this.text1,
    this.buttonText,
    this.bottom,
    this.right,
    this.onPressed,
    this.textColor,
    this.buttonText2,
    required this.image,
    this.isButton2,
    this.text3,
    this.top,
    this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.027,
        right: MediaQuery.of(context).size.width * 0.027,
        top: MediaQuery.of(context).size.height * 0.015,
        bottom: MediaQuery.of(context).size.height * 0.001,
      ),
      child: Stack(
        children: [
          // height: MediaQuery.sizeOf(context).height,
          // width: MediaQuery.sizeOf(context).width,
          // padding: EdgeInsets.only(
          //   left: MediaQuery.of(context).size.width * 0.027,
          //   right: MediaQuery.of(context).size.width * 0.027,
          //   top: MediaQuery.of(context).size.height * 0.015,
          // ),

          Image.network(
            AppUrl.baseUrl + image,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              // Here you return your fallback image when the network image fails to load
              return Image.asset(
                'assets/agricultural.jpg', // The path to your local asset image
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              );
            },
          ),
          // Image(
          //   height: MediaQuery.sizeOf(context).height,
          //   width: MediaQuery.sizeOf(context).width,
          //   fit: BoxFit.cover,
          //   image: NetworkImage(AppUrl.baseUrl + image),
          // ),

          Positioned(
            bottom: bottom,
            right: right,
            left: left,
            top: top,
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.2,
              // width: isButton2
              //     ? MediaQuery.sizeOf(context).width * 0.66
              //     : MediaQuery.sizeOf(context).width * 0.55,
              // height: isButton2
              //     ? MediaQuery.sizeOf(context).height * 0.12
              //     : MediaQuery.sizeOf(context).height * 0.15,
              decoration: const BoxDecoration(
                color: Colors.white60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width * 0.033,
                        vertical: MediaQuery.sizeOf(context).height * 0.01),
                    child: Text(
                      text1!,
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  MaterialButton(
                    color: ColorConstant.secondaryColor,
                    splashColor: ColorConstant.primaryColor,
                    onPressed: () => onPressed,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      buttonText!,
                      style: TextStyle(
                        color: ColorConstant.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
