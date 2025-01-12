import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrafikFix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<List<FlSpot>>>>(
      future: Future.wait([
        _fetchAllSensorData('pameran1', FirebaseFirestore.instance),
        _fetchAllSensorData('pameran2', FirebaseFirestore.instance),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (snapshot.hasData) {
          final alat1Data = snapshot.data![0];
          final alat2Data = snapshot.data![1];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildMultiLineGraph(
                    'pH',
                    alat1Data[0],
                    alat2Data[0],
                    '',
                  ),
                  const SizedBox(height: 20),
                  _buildMultiLineGraph(
                    'TDS',
                    alat1Data[1],
                    alat2Data[1],
                    'ppm',
                  ),
                  const SizedBox(height: 20),
                  _buildMultiLineGraph(
                    'DO',
                    alat1Data[2],
                    alat2Data[2],
                    'mg/L',
                  ),
                  const SizedBox(height: 20),
                  _buildMultiLineGraph(
                    'Temperature',
                    alat1Data[3],
                    alat2Data[3],
                    '°C',
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(child: Text("No data available"));
      },
    );
  }

  Future<List<List<FlSpot>>> _fetchAllSensorData(
      String collection, FirebaseFirestore firestore) async {
    try {
      final snapshot = await firestore.collection(collection).get();
      final data = snapshot.docs;

      return Future.wait([
        _fetchSensorData(data, 'pH'),
        _fetchSensorData(data, 'TDS'),
        _fetchSensorData(data, 'DO'),
        _fetchSensorData(data, 'temperature'),
      ]);
    } catch (e) {
      print("Error fetching data from Firestore: $e");
      return [[], [], [], []]; // Return empty lists if error occurs
    }
  }

  Future<List<FlSpot>> _fetchSensorData(List<QueryDocumentSnapshot> docs, String sensorType) async {
    List<FlSpot> spots = [];
    final now = DateTime.now();
    final twentyFourHoursAgo = now.subtract(const Duration(hours: 24)); // Data dalam 24 jam terakhir

    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      final timestamp = data['timestamp']?.toDate() as DateTime?;
      final value = data[sensorType]?.toDouble();

      if (timestamp != null &&
          value != null &&
          timestamp.isAfter(twentyFourHoursAgo)) {
        // Gunakan jam (format 24 jam) sebagai X
        final xValue = timestamp.hour.toDouble() + (timestamp.minute / 60);
        spots.add(FlSpot(xValue, value));
      }
    }

    // Sort spots berdasarkan nilai X (jam)
    spots.sort((a, b) => a.x.compareTo(b.x));
    return spots;
  }

  Widget _buildMultiLineGraph(
    String title,
    List<FlSpot> alat1Spots,
    List<FlSpot> alat2Spots,
    String unit,
  ) {
    double maxY = _getMaxYForSensor(title);

    return AspectRatio(
      aspectRatio: 1.5,
      child: CustomCard(
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  minX: 0, // Mulai dari jam 00:00
                  maxX: 24, // Sampai jam 24:00
                  minY: 0,
                  maxY: maxY,
                  
                  borderData: FlBorderData(
                    show: true,
                    border: const Border.symmetric(
                      horizontal: BorderSide(width: 1),
                      vertical: BorderSide(width: 1),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        interval: 6, // Interval setiap 6 jam
                        getTitlesWidget: (value, meta) {
                          final hour = value.toInt();
                          if (hour % 6 == 0) { // Hanya menampilkan label setiap 6 jam
                            return Text(
                              '$hour:00',
                              style: const TextStyle(fontSize: 10),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        interval: maxY / 5, // Interval nilai pada sisi kiri
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}', style: const TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false), // Hilangkan angka di atas grafik
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false), // Hilangkan angka di kanan grafik
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: alat1Spots,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      color: Colors.red,
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      isCurved: true,
                      spots: alat2Spots,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      color: Colors.blue,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getMaxYForSensor(String sensorType) {
    switch (sensorType) {
      case 'pH':
        return 14.0;
      case 'TDS':
        return 900.0;
      case 'DO':
        return 3000.0;
      case 'temperature':
        return 50.0;
      default:
        return 100.0;
    }
  }
}

class CustomCard extends StatelessWidget {
  final Widget? child;

  const CustomCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 253, 241, 216).withOpacity(0.5),
      ),
      child: child,
    );
  }
}
