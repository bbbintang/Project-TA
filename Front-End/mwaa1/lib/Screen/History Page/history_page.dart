import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mwaa1/Screen/History%20Page/button_historypage.dart';
import 'package:mwaa1/Screen/History%20Page/custom_BulanTanggal.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedMonth; // Variable to store selected month
  List<String> months = [
    'Semua Bulan',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
    selectedMonth = months[0]; // Default selection for the dropdown
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dropdown for selecting month
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.6)),
                  child: DropdownButton<String>(
                    value: selectedMonth,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue;
                      });
                    },
                    items: months.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                ButtonHistorypage()
              ],
            ),
          ),
          // Display the history data
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Alat1')
                  .orderBy('timestamp', descending: true)
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

                // Filter data based on selectedMonth
                List<DocumentSnapshot> filteredData =
                    snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  if (!data.containsKey('timestamp')) return false;

                  final timestamp = (data['timestamp'] as Timestamp).toDate();
                  final monthKey =
                      DateFormat('MMMM', 'id_ID').format(timestamp);

                  // Jika "Semua Bulan" dipilih, tampilkan semua data
                  if (selectedMonth == 'Semua Bulan') {
                    return true;
                  }
                  return monthKey == selectedMonth;
                }).toList();

                // Jika tidak ada data setelah filter
                if (filteredData.isEmpty) {
                  return Center(
                    child: Text(
                      "Tidak ada data di bulan ini",
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  );
                }

                // Group data by month
                Map<String, List<DocumentSnapshot>> groupedData = {};
                for (var doc in filteredData) {
                  final data = doc.data() as Map<String, dynamic>;
                  final timestamp = (data['timestamp'] as Timestamp).toDate();
                  final monthKey =
                      DateFormat('MMMM', 'id_ID').format(timestamp);

                  if (!groupedData.containsKey(monthKey)) {
                    groupedData[monthKey] = [];
                  }
                  groupedData[monthKey]!.add(doc);
                }

                // Display grouped data
                return SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: groupedData.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomBulan(
                                bulanke: entry.key), // Display month header
                            ...entry.value.map((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              final timestamp =
                                  (data['timestamp'] as Timestamp).toDate();

                              return CustomHistory(
                                jamke: DateFormat('HH:mm').format(timestamp),
                                tanggalke: DateFormat('dd MMM, yyyy')
                                    .format(timestamp),
                                nilaiSuhu: (data['Suhu']?.toDouble() ?? 0.0),
                                nilaiPH: (data['pH']?.toDouble() ?? 0.0),
                                nilaiTDS: (data['TDS']?.toDouble() ?? 0.0),
                                nilaiDO: (data['DO']?.toDouble() ?? 0.0),
                              );
                            }).toList(),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
