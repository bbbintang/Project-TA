import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mwaa1/widget/button_historypage.dart';
import 'package:mwaa1/widget/custom_history.dart';
import 'package:mwaa1/widget/theme.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final databaseReference = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> historyData = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Mulai pencuplikan data setiap sepuluh menit
    startDataFetching();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startDataFetching() {
    // Timer untuk mengambil data setiap 10 menit
    timer = Timer.periodic(const Duration(minutes: 10), (timer) {
      fetchData();
    });
    // Ambil data pertama kali saat halaman dibuka
    fetchData();
  }

Future<void> fetchData() async {
  try {
    // Ambil data dari Firebase dengan path "history"
    final snapshot = await databaseReference.child('history').get();

    // Periksa apakah snapshot ada data
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        setState(() {
          historyData = data.entries
              .map((entry) => {
                    'timestamp': entry.key,
                    'values': entry.value,
                  })
              .toList();
        });
      }
    } else {
      print("No data available");
    }
  } catch (e) {
    print("Error fetching data: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        automaticallyImplyLeading: false,
        title: Container(
          width: double.infinity,
          height: 75,
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "LOGOaja.png",
                color: Colors.orange,
                height: 100,
                width: 100,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ],
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
                    SizedBox(width: 170),
                    ButtonHistorypage(),
                  ],
                ),
              ),
              for (var monthData in historyData)
                Column(
                  children: [
                    CustomBulan(bulanke: "Data Tanggal ${monthData['timestamp']}"),
                    CustomHistory(
                      jamke: monthData['values']['jam'],
                      tanggalke: monthData['values']['tanggal'],
                      nilaiSuhu: monthData['values']['suhu'],
                      nilaiPH: monthData['values']['ph'],
                      nilaiTDS: monthData['values']['tds'],
                      nilaiDO: monthData['values']['do'],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}