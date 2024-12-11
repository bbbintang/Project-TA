import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class CustomCategory2 extends StatelessWidget {
  final String kategori;
  const CustomCategory2({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 35,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: const Color.fromARGB(255, 220, 234, 241),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              kategori,
              style: outfit15normal.copyWith(
                  fontSize: 14,
                  color: darkblue,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}
