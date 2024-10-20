import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mwaa1/widget/button_homepage.dart';
import 'package:mwaa1/widget/button_historypage.dart';
import 'package:mwaa1/widget/custom_history.dart';
import 'package:mwaa1/widget/theme.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.3,
        title: Center(
          child: Image.asset(
            "LOGOaja.png",
            color: Colors.orange,
            height: 100,
            width: 100,
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
              child: Row(
                children: [
                  Text(
                    "Riwayat Data",
                    style: montserrat17normal.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 170,
                  ),
                  ButtonHistorypage()
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CustomBulan(bulanke: "Januari"),
            CustomHistory(
              jamke: "00.01",
              tanggalke: "dd mm, yyyy",
              nilaiSuhu: 222,
              nilaiPH: 222,
              nilaiTDS: 222,
              nilaiDO: 222,
            ),
            CustomHistory(
              jamke: "00.01",
              tanggalke: "dd mm, yyyy",
              nilaiSuhu: 222,
              nilaiPH: 222,
              nilaiTDS: 222,
              nilaiDO: 222,
            ),
            CustomBulan(bulanke: "Februari"),
            CustomHistory(
              jamke: "00.01",
              tanggalke: "dd mm, yyyy",
              nilaiSuhu: 222,
              nilaiPH: 222,
              nilaiTDS: 222,
              nilaiDO: 222,
            ),
          ],
        )),
      ),
    );
  }
}