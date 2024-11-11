import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mwaa1/Screen/Home%20Page/button_homepage.dart';
import 'package:mwaa1/Screen/History%20Page/button_historypage.dart';
import 'package:mwaa1/Screen/History%20Page/custom_history.dart';
import 'package:mwaa1/widget/theme.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, List<DocumentSnapshot>> groupedData = {};

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
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
      body: StreamBuilder<QuerySnapshot>(
        // Mengambil semua dokumen dari koleksi ESP32 dan mengurutkannya berdasarkan waktu
        stream: FirebaseFirestore.instance
            .collection('ESP32')
            .orderBy('waktu', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Tidak ada data'));
          }

          // Debug: Print jumlah dokumen
          print('Number of documents: ${snapshot.data!.docs.length}');

          // Group data by month
          groupedData.clear();
          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;

            // Skip if waktu field doesn't exist
            if (!data.containsKey('waktu')) continue;

            final timestamp = (data['waktu'] as Timestamp).toDate();
            final monthKey = DateFormat('MMMM', 'id_ID').format(timestamp);

            if (!groupedData.containsKey(monthKey)) {
              groupedData[monthKey] = [];
            }
            groupedData[monthKey]!.add(doc);
          }

          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 16, right: 16),
                    child: Row(
                      children: [
                        Text(
                          "Riwayat Data",
                          style: montserrat17normal.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 170),
                        ButtonHistorypage()
                      ],
                    ),
                  ),
                  // Display grouped data by month
                  ...groupedData.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBulan(bulanke: entry.key),
                        ...entry.value.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final timestamp =
                              (data['waktu'] as Timestamp).toDate();

                          // Debug: Print individual document data
                          print('Document data: $data');

                          return CustomHistory(
                            jamke: DateFormat('HH:mm').format(timestamp),
                            tanggalke:
                                DateFormat('dd MMM, yyyy').format(timestamp),
                            nilaiSuhu: (data['Suhu']?.toDouble() ?? 0.0),
                            nilaiPH: (data['pH']?.toDouble() ?? 0.0),
                            nilaiTDS: (data['TDS']?.toDouble() ?? 0.0),
                            nilaiDO: (data['DO']?.toDouble() ?? 0.0),
                          );
                        }).toList(),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}