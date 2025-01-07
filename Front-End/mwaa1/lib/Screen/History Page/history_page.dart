import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mwaa1/Screen/History%20Page/button_historypage.dart';
import 'package:mwaa1/Screen/History%20Page/custom_BulanTanggal.dart';
import 'package:rxdart/rxdart.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedMonth; // Variable to store selected month
  String? selectedDevice;
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
  List<String> devices = [
    'Semua Alat',
    'Alat 1',
    'Alat 2',
  ];
  Stream<List<Map<String, dynamic>>> getCombinedStream() {
    final alat1Stream = FirebaseFirestore.instance
        .collection('Alat1')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              data['device'] = 'Alat 1'; // Tambahkan properti device
              return data;
            }).toList());

    final alat2Stream = FirebaseFirestore.instance
        .collection('Alat2')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              data['device'] = 'Alat 2'; // Tambahkan properti device
              return data;
            }).toList());

    return Rx.combineLatest2<List<Map<String, dynamic>>,
        List<Map<String, dynamic>>, List<Map<String, dynamic>>>(
      alat1Stream,
      alat2Stream,
      (alat1Data, alat2Data) => [...alat1Data, ...alat2Data],
    );
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
    selectedMonth = months[0]; // Default selection buat dropdown bulan
    selectedDevice = devices[0]; // Default selection buat dropdown alat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dropdown for selecting month
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white.withOpacity(0.6)),
                  child: DropdownButton<String>(
                    value: selectedDevice,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDevice = newValue;
                      });
                    },
                    items:
                        devices.map<DropdownMenuItem<String>>((String value) {
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
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: getCombinedStream(),
              builder: (context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada data'));
                }

                // Debug: Print jumlah dokumen
                print('Number of documents: ${snapshot.data!.length}');

                // Filter data based on selectedMonth
                final filteredData = snapshot.data!.where((data) {
                  final timestamp = (data['timestamp'] as Timestamp).toDate();
                  final monthKey =
                      DateFormat('MMMM', 'id_ID').format(timestamp);

                  // Filter by month
                  final matchesMonth = selectedMonth == 'Semua Bulan' ||
                      monthKey == selectedMonth;

                  // Filter by device
                  final matchesDevice = selectedDevice == 'Semua Alat' ||
                      data['device'] == selectedDevice;

                  return matchesMonth && matchesDevice;
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
                final groupedData = <String, List<Map<String, dynamic>>>{};
                for (var data in filteredData) {
                  final timestamp = (data['timestamp'] as Timestamp).toDate();
                  final monthKey =
                      DateFormat('MMMM', 'id_ID').format(timestamp);

                  groupedData.putIfAbsent(monthKey, () => []).add(data);
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
                            ...entry.value.map((data) {
                              final timestamp =
                                  (data['timestamp'] as Timestamp).toDate();
                              // Menampilkan data dari masing-masing alat
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (data['device'] == 'Alat 1') ...[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 17,
                                          top: 10), // Geser sedikit ke kanan
                                      child: Text(
                                        "Alat 1",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    CustomHistory(
                                      nilaiSuhu: data['temperature'].toDouble(),
                                      nilaiPH: (data['pH']?.toDouble() ?? 0.0),
                                      nilaiTDS:
                                          (data['TDS']?.toDouble() ?? 0.0),
                                      nilaiDO: (data['DO']?.toDouble() ?? 0.0),
                                      jamke:
                                          DateFormat('HH:mm').format(timestamp),
                                      tanggalke: DateFormat('dd MMM, yyyy')
                                          .format(timestamp),
                                    ),
                                  ],
                                  if (data['device'] == 'Alat 2') ...[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 17,
                                          top: 10), // Geser sedikit ke kanan
                                      child: Text(
                                        "Alat 2",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    CustomHistory(
                                      nilaiSuhu:
                                          data['temperature'].toDouble() ,
                                      nilaiPH: (data['pH']?.toDouble() ?? 0.0),
                                      nilaiTDS:
                                          (data['TDS']?.toDouble() ?? 0.0),
                                      nilaiDO: (data['DO']?.toDouble() ?? 0.0),
                                      jamke:
                                          DateFormat('HH:mm').format(timestamp),
                                      tanggalke: DateFormat('dd MMM, yyyy')
                                          .format(timestamp),
                                    ),
                                  ],
                                ],
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
