import 'package:eccomerce/constant/app_urls.dart';
import 'package:eccomerce/constant/color_constant.dart';
import 'package:flutter/material.dart';

class Custom_CategoryGrid extends StatelessWidget {
  final String image;
  final String text;
  const Custom_CategoryGrid({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.02),
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(AppUrl.baseUrl + image),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.02),
            child: Text(
              text,
              style: TextStyle(
                  color: ColorConstant.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
