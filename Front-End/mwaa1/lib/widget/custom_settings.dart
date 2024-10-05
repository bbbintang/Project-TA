import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class CustomSettings extends StatelessWidget {

  final String title;
  final IconData icon;

  const CustomSettings({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white.withOpacity(0.1)),
        child: Icon(icon, color: Colors.black,),
      ),
      title: Text(
        title,
        style: outfit17normal.copyWith(color: Colors.black),
      ),
    );
  }
}
