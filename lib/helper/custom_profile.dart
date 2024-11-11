import 'package:flutter/material.dart';

class Custom_Profile extends StatelessWidget {
  final String text;

  const Custom_Profile({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height*0.025, left: MediaQuery.sizeOf(context).width*0.057),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}

class Custom_Profile2 extends StatelessWidget {
  final String text1;
  const Custom_Profile2({super.key, required this.text1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 199,
      padding:  EdgeInsets.only(top: MediaQuery.sizeOf(context).height*0.027, left: MediaQuery.sizeOf(context).width*0.1, right: MediaQuery.sizeOf(context).width*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            overflow: TextOverflow.ellipsis,
            maxLines: 1, //cuts the overflowing text with ...
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
