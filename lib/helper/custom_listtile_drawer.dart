import 'package:flutter/material.dart';

class Custom_Listtile_Drawer extends StatelessWidget {
  final IconData iconn;
  final String text;
  final void Function() onTap;
  const Custom_Listtile_Drawer({
    super.key,
    required this.iconn,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconn),
      title: Text(
        text,
        style: TextStyle(overflow: TextOverflow.ellipsis),
        maxLines: 1,
      ),
      onTap: onTap,
    );
  }
}
