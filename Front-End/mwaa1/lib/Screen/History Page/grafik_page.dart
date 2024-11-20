import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/History%20Page/button_historypage.dart';
import 'package:mwaa1/widget/theme.dart';

class GrafikPage extends StatelessWidget {
  const GrafikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 50,),
                ButtonHistorypage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
