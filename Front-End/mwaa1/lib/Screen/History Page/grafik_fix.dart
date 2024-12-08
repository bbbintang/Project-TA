import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GrafikFix extends StatefulWidget {
  const GrafikFix({super.key});

  @override
  _GrafikFixState createState() => _GrafikFixState();
}

class _GrafikFixState extends State<GrafikFix> {
  List<FlSpot> spots = [];

  @override
  void initState() {
    super.initState(); 
    }

  // Fungsi untuk mendengarkan perubahan data secara real-time
  Stream<List<FlSpot>> _listenToSensorData() {
    return FirebaseFirestore.instance
        .collection('Alat1') // Koleksi di Firestore
        .snapshots() // Menggunakan snapshots agar data selalu update
        .asyncMap((QuerySnapshot snapshot) async {
          List<FlSpot> allSpots = [];

          // Loop melalui semua dokumen di koleksi 'Alat1'
          for (var doc in snapshot.docs) {
            QuerySnapshot subSnapshot = await FirebaseFirestore.instance
                .collection('Alat1')
                .doc(doc.id) // Dokumen spesifik
                .collection('temperature') // Sub-koleksi 'temperature'
                .orderBy('timestamp', descending: false) // Urutkan berdasarkan timestamp
                .get();
          for (var subDoc in subSnapshot.docs) {
            final data = subDoc.data() as Map<String, dynamic>;   
          
          if (data.containsKey('x') && data.containsKey('y')) {
                // Mengambil nilai x (timestamp) dan y (nilai data, misalnya suhu)
                var timestamp = (data['y'] as Timestamp).toDate(); // Konversi Timestamp ke DateTime
                double xValue = timestamp.millisecondsSinceEpoch.toDouble(); // Waktu dalam milidetik
                double yValue = (data['x'] as num).toDouble(); // Nilai suhu atau data lainnya

                // Tambahkan titik ke daftar allSpots
                allSpots.add(FlSpot(xValue, yValue));
          }
          }
          }
          // Mengurutkan spots berdasarkan nilai x (waktu)
          allSpots.sort((a, b) => a.x.compareTo(b.x)); // Urutkan berdasarkan x (waktu)
          return allSpots; // Kembalikan daftar titik untuk grafik
        });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafik'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Grafik Suhu Realtime",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<FlSpot>>(
                stream: _listenToSensorData(), // Menggunakan StreamBuilder untuk data real-time
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Terjadi kesalahan'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Tidak ada data'));
                  }

                  // Mendapatkan data titik dari Firestore
                  List<FlSpot> spots = snapshot.data!;
                  print("Spots: $spots");

                  return CustomCard(
                child: LineChart(
                  _dekorasiChart(spots, LineData().bottomTitleSuhu, LineData().leftTitleSuhu),
                  ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget? child;

  const CustomCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.7)),
      child: child);
  }
}

Widget _isiContainer(
    String title, Map<int, String> bottomTitles, Map<int, String> leftTitles, List<FlSpot> spots) {
  return SizedBox(
    height: 200,
    width: double.infinity,
    child: CustomCard(
        child: Column(
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Outfit')),
        SizedBox(
          height: 20,
        ),
        Expanded(child: LineChart(_dekorasiChart(spots, bottomTitles, leftTitles),),)
      ],
    )),
  );
}

LineChartData _dekorasiChart(
    List<FlSpot> spots, Map<int, String> bottomTitles, Map<int, String> leftTitles) {
  return LineChartData(
    minX: spots.isNotEmpty ? spots.first.x : 0,
    maxX: spots.isNotEmpty ? spots.last.x : 120,
    minY: spots.isNotEmpty ? spots.map((e) => e.y).reduce((a, b) => a < b ? a : b) : -5,
    maxY: spots.isNotEmpty ? spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) : 105,
    gridData: FlGridData(show: false),
    borderData: FlBorderData(show: false),
    titlesData: _ketentuanData(bottomTitles, leftTitles),
    lineBarsData: [
      LineChartBarData(
        isCurved: true,
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 120, 163, 235),
              Color.fromARGB(255, 21, 255, 33),
            ],),
            barWidth: 5,
            belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 120, 163, 235).withOpacity(0.5),
                      Color.fromARGB(255, 21, 255, 33).withOpacity(0.3),
                    ])),
            spots: spots, ),
      ]);
}

FlTitlesData _ketentuanData(
    Map<int, String> bottomTitles, Map<int, String> leftTitles) {
  return FlTitlesData(
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) =>
                  _TitleWidget(bottomTitles, value))),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        interval: 1,
        getTitlesWidget: (value, meta) => _TitleWidget(leftTitles, value),
      )));
}

Widget _TitleWidget(Map<int, String> titles, double value) {
  return titles[value.toInt()] != null
      ? Text(
          titles[value.toInt()]!,
          style: TextStyle(fontSize: 10, color: Colors.black),
        )
      : SizedBox();
}

class LineData {
  final leftTitleSuhu = {
    0: '0°C',
    20: '20°C',
    40: '40°C',
    60: '60°C',
    80: '80°C',
    100: '100°C'
  };

  final bottomTitleSuhu = {
    0: '00:00',
    10: '01:00',
    20: '02:00',
    30: '03:00',
    40: '04:00',
    50: '05:00',
    60: '06:00',
    70: '07:00',
    80: '08:00',
    90: '09:00',
    100: '10:00',
    110: '11:00',
    120: '12:00',
    130: '13:00',
    140: '14:00',
  };
}
