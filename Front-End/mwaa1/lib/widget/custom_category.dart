import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCategory extends StatelessWidget {
  final String name;
  const CustomCategory({
    super.key,
    required this.name,
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
        child: Text(
          name,
          style: GoogleFonts.outfit(
              fontSize: 14, 
              color: Color.fromARGB(255, 28, 88, 136),
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}