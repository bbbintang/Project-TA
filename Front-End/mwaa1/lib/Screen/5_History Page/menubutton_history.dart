import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mwaa1/widget/theme.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class MenubuttonHistory extends StatefulWidget {
  const MenubuttonHistory({super.key});

  @override
  State<MenubuttonHistory> createState() => _MenubuttonHistoryState();
}

class _MenubuttonHistoryState extends State<MenubuttonHistory> {
  bool _isObscure = true;
  TextEditingController dateControllerAwal = TextEditingController();
  TextEditingController dateControllerAkhir = TextEditingController();

  Future<void> downloadHistory(String startDate, String endDate) async {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);

    // Ambil data dari coll alat 1
    final alat1Snapshot = await FirebaseFirestore.instance
        .collectionGroup('Alat1')
        .where('timestamp', isGreaterThanOrEqualTo: start)
        .where('timestamp', isLessThanOrEqualTo: end)
        .get();

    // Ambil data dari coll Alat 2
    final alat2Snapshot = await FirebaseFirestore.instance
        .collection('dummy') // sesuaikan nama
        .where('timestamp', isGreaterThanOrEqualTo: start)
        .where('timestamp', isLessThanOrEqualTo: end)
        .get();

    List<Map<String, dynamic>> allData = [];

    for (var doc in alat1Snapshot.docs) {
      Map<String, dynamic> data = doc.data();
      data['device'] = 'Alat 1'; // Tambahkan info alat
      allData.add(data);
    }

    for (var doc in alat2Snapshot.docs) {
      Map<String, dynamic> data = doc.data();
      data['device'] = 'Alat 2'; // Tambahkan info alat
      allData.add(data);
    }

    // Konversi data ke format CSV
    List<List<dynamic>> rows = [
      ["Tanggal", "Jam", "Suhu", "pH", "TDS", "DO", "Alat"] // Header CSV
    ];

    for (var data in allData) {
      DateTime timestamp = (data['timestamp'] as Timestamp).toDate();
      rows.add([
        DateFormat('yyyy-MM-dd').format(timestamp),
        DateFormat('HH:mm').format(timestamp),
        data['temperature'] ?? '',
        data['pH'] ?? '',
        data['TDS'] ?? '',
        data['DO'] ?? '',
        data['device'] ?? 'Unknown'
      ]);
    }

    // Buat file CSV
    String csv = const ListToCsvConverter().convert(rows);

    // Simpan file ke perangkat
    Directory? directory;
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');
      // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
      // ignore: avoid_slow_async_io
      if (!await directory.exists())
        directory = await getExternalStorageDirectory();
    }
    final path =
        "${directory!.path}/history_${startDate}_to_${endDate}-${DateTime.now().millisecondsSinceEpoch}.csv";
    final file = File(path);
    await file.writeAsString(csv);

    // Notifikasi bahwa file sudah disimpan
    print("File disimpan di: $path");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("File berhasil diunduh: $path")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 8,
          ),
          Center(
            child: Text(
              "Periode Riwayat",
              style: opensans17normal.copyWith(
                color: blueriwayat,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Dari Tanggal",
              style: poppin15normal.copyWith(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
            child: TextField(
              readOnly: true,
              controller: dateControllerAwal,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Date',
                  suffixIcon: Icon(Icons.calendar_month_rounded)),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2099));
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyy-MM-dd').format(pickedDate);
                  dateControllerAwal.text = formattedDate;
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Sampai Tanggal",
              style: poppin15normal.copyWith(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
            child: TextField(
              readOnly: true,
              controller: dateControllerAkhir,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Date',
                  suffixIcon: Icon(Icons.calendar_month_rounded)),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2099));
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyy-MM-dd').format(pickedDate);
                  dateControllerAkhir.text = formattedDate;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ElevatedButton(
                onPressed: () async {
                  if (dateControllerAwal.text.isEmpty ||
                      dateControllerAkhir.text.isEmpty) {
                    // Tampilkan pop-up peringatan
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Peringatan"),
                          content: Text(
                              "Silakan pilih kedua tanggal terlebih dahulu!"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup pop-up
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  // Ambil tanggal awal dan akhir
                  String startDate = dateControllerAwal.text;
                  String endDate = dateControllerAkhir.text;

                  if (DateTime.parse(startDate)
                      .isAfter(DateTime.parse(endDate))) {
                    // Tampilkan pop-up
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Peringatan"),
                          content: Text(
                              "Tanggal awal tidak boleh lebih dari tanggal akhir!"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup pop-up
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  // proses download
                  await downloadHistory(startDate, endDate);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 30),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: bluelogin),
                child: Text(
                  "Download",
                  style: outfit15normal.copyWith(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
