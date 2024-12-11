import 'package:flutter/material.dart';
import 'package:mwaa1/Screen/History%20Page/button_historypage.dart';
import 'package:mwaa1/Screen/History%20Page/grafik_fix.dart';

class GrafikPage extends StatelessWidget {
  const GrafikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GrafikFix()
          ],
        ),
      ),
    );
  }
}
