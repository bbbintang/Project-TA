import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class MenubuttonHistory extends StatelessWidget {
  const MenubuttonHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Center(
            child: Text(
              "Riwayat",
              style: opensans17normal.copyWith(
                  color: blueriwayat,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text("Periode Riwayat",
              style: poppin15normal.copyWith(color: Colors.black))
        ],
      ),
    );
  }
}
