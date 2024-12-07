import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: poppin15normal.copyWith(fontSize: 17, color: Colors.black),
          ),
        ],
      ),
    );
  }
}