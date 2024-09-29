import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mwaa1/widget/theme.dart';

class CustomParameter extends StatelessWidget {
  final String imagePath;
  final String title;
  const CustomParameter({
    super.key,
    required this.imagePath,
    required this.title,
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
            color: Colors.white.withOpacity(0.5),
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
                      height: 10,
                    ),
                    Text(
                      title,
                      style: outfit15normal.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "...",
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
