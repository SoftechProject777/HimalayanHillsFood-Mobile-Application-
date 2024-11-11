import 'package:eccomerce/constant/app_urls.dart';
import 'package:flutter/material.dart';

class Custom_Brand extends StatelessWidget {
  final String image;
  final String text;
  const Custom_Brand({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.027),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 255, 242, 197)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.14,
            width: MediaQuery.sizeOf(context).width,
            child: Image(
              image: NetworkImage(AppUrl.baseUrl + image),
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2, // Allowing up to 2 lines of text
              textAlign: TextAlign.center,
              overflow:
                  TextOverflow.ellipsis, // Adding ellipsis if text overflows
            ),
          ),
        ],
      ),
    );
  }
}
