import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MenubuttonHistory extends StatefulWidget {
  const MenubuttonHistory({super.key});

  @override
  State<MenubuttonHistory> createState() => _MenubuttonHistoryState();
}

class _MenubuttonHistoryState extends State<MenubuttonHistory> {
  TextEditingController dateControllerAwal = TextEditingController();
  TextEditingController dateControllerAkhir = TextEditingController();

  Future<void> downloadHistory(String startDate, String endDate) async {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);

    try {
      // Ambil data dari alat 1
      final alat1Snapshot = await FirebaseFirestore.instance
          .collection('Alat1') // Ganti dengan nama koleksi alat 1
          .where('timestamp', isGreaterThanOrEqualTo: start)
          .where('timestamp', isLessThanOrEqualTo: end)
          .get();

      // Ambil data dari alat 2
      final alat2Snapshot = await FirebaseFirestore.instance
          .collection('Dummy') // Ganti dengan nama koleksi alat 2
          .where('timestamp', isGreaterThanOrEqualTo: start)
          .where('timestamp', isLessThanOrEqualTo: end)
          .get();

      // Header CSV
      List<List<dynamic>> rows = [
        ["Tanggal", "Jam", "Suhu", "pH", "TDS", "DO", "Alat"]
      ];

      // Tambahkan data alat 1 ke dalam CSV
      for (var doc in alat1Snapshot.docs) {
        var data = doc.data();
        DateTime timestamp = (data['timestamp'] as Timestamp).toDate();
        rows.add([
          DateFormat('yyyy-MM-dd').format(timestamp),
          DateFormat('HH:mm:ss').format(timestamp),
          data['Suhu'] ?? '',
          data['pH'] ?? '',
          data['TDS'] ?? '',
          data['DO'] ?? '',
          'Alat 1'
        ]);
      }

      // Tambahkan data alat 2 ke dalam CSV
      for (var doc in alat2Snapshot.docs) {
        var data = doc.data();
        DateTime timestamp = (data['timestamp'] as Timestamp).toDate();
        rows.add([
          DateFormat('yyyy-MM-dd').format(timestamp),
          DateFormat('HH:mm:ss').format(timestamp),
          data['Suhu'] ?? '',
          data['pH'] ?? '',
          data['TDS'] ?? '',
          data['DO'] ?? '',
          'Alat 2'
        ]);
      }

      // Konversi data ke format CSV
      String csv = const ListToCsvConverter().convert(rows);

      // Simpan file ke perangkat
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/history_${startDate}_to_${endDate}.csv';
      final file = File(path);
      await file.writeAsString(csv);

      // Tampilkan notifikasi sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File berhasil diunduh di: $path")),
      );
    } catch (e) {
      // Tampilkan pesan error jika gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              "Periode Riwayat",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller: dateControllerAwal,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Dari Tanggal',
              suffixIcon: Icon(Icons.calendar_month),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2099),
              );
              if (pickedDate != null) {
                dateControllerAwal.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
              }
            },
          ),
          SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller: dateControllerAkhir,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Sampai Tanggal',
              suffixIcon: Icon(Icons.calendar_month),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2099),
              );
              if (pickedDate != null) {
                dateControllerAkhir.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
              }
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (dateControllerAwal.text.isEmpty ||
                  dateControllerAkhir.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Peringatan"),
                      content: Text("Silakan pilih kedua tanggal terlebih dahulu!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
                return;
              }

              String startDate = dateControllerAwal.text;
              String endDate = dateControllerAkhir.text;

              if (DateTime.parse(startDate).isAfter(DateTime.parse(endDate))) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Peringatan"),
                      content: Text("Tanggal awal tidak boleh lebih dari tanggal akhir!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
                return;
              }

              await downloadHistory(startDate, endDate);
            },
            child: Text("Unduh"),
          ),
        ],
      ),
    );
  }
}
