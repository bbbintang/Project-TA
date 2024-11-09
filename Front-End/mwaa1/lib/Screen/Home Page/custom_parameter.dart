import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class CustomParameter extends StatelessWidget {
  final String imagePath;
  final String title;
  final double number;
  const CustomParameter({
    super.key,
    required this.imagePath,
    required this.title,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 100,
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.white.withOpacity(0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ),
            elevation: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset(
                        imagePath,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      title,
                      style: outfit15normal.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      number.toString(),
                      style: outfit20bold,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 10,)
        ],
      ),
    );
  }
}
