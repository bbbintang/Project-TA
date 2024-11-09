import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mwaa1/widget/theme.dart';

class CustomCategory extends StatelessWidget {
  final String name1;
  final String name2;
  const CustomCategory({
    super.key,
    required this.name1,
    required this.name2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
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
              name1,
              style: GoogleFonts.outfit(
                  fontSize: 14, 
                  color: darkblue,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              name2,
              style: GoogleFonts.outfit(
                  fontSize: 14, 
                  color: darkblue,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
