import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrafikFix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('Alat1').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (snapshot.hasData) {
          final data = snapshot.data!.docs;

          return FutureBuilder<List<List<FlSpot>>>(
            future: Future.wait([
              _fetchSensorData(data, 'pH'),
              _fetchSensorData(data, 'TDS'),
              _fetchSensorData(data, 'DO'),
              _fetchSensorData(data, 'temperature'),
            ]),
            builder: (context, sensorSnapshot) {
              if (sensorSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (sensorSnapshot.hasError) {
                return Center(child: Text("Error: ${sensorSnapshot.error}"));
              }

              if (sensorSnapshot.hasData) {
                final phSpots = sensorSnapshot.data![0];
                final tdsSpots = sensorSnapshot.data![1];
                final doSpots = sensorSnapshot.data![2];
                final suhuSpots = sensorSnapshot.data![3];

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildGraph('pH', phSpots, '', 'pH'),
                        const SizedBox(height: 20),
                        _buildGraph('TDS', tdsSpots, 'ppm', 'TDS'),
                        const SizedBox(height: 20),
                        _buildGraph('DO', doSpots, 'mg/L', 'DO'),
                        const SizedBox(height: 20),
                        _buildGraph('Temperature', suhuSpots, '°C', 'temperature'),
                      ],
                    ),
                  ),
                );
              }

              return const Center(child: Text("No data available"));
            },
          );
        }

        return const Center(child: Text("No data available"));
      },
    );
  }

// Fetch data for each sensor from Firestore
Future<List<FlSpot>> _fetchSensorData(List<QueryDocumentSnapshot> docs, String sensorType) async {
  List<FlSpot> spots = [];

  final now = DateTime.now();
  final sixHoursAgo = now.subtract(const Duration(hours: 6)); // Waktu 6 jam yang lalu

  for (var doc in docs) {
    final data = doc.data() as Map<String, dynamic>;
    final timestamp = data['timestamp']?.toDate() as DateTime?;

    if (timestamp == null || timestamp.isBefore(sixHoursAgo)) {
      continue; // Lewati data yang lebih lama dari 6 jam
    }

    final value = data[sensorType]?.toDouble() ?? 0.0;

    // Mengkonversi timestamp menjadi millisecondsSinceEpoch dan menyimpannya sebagai sumbu X
    final xValue = timestamp.millisecondsSinceEpoch.toDouble();

    spots.add(FlSpot(xValue, value));
  }

  return spots;
}


  Widget _buildGraph(String title, List<FlSpot> spots, String unit, String sensorType) {
    double maxY = _getMaxYForSensor(sensorType);

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
                  minX: spots.isNotEmpty ? spots.first.x : 0,
                  maxX: spots.isNotEmpty ? spots.last.x : 1000,
                  minY: 0,
                  maxY: maxY,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: true),
                  titlesData: _buildTitles(unit),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: spots,
                      barWidth: 4,
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

// Fungsi untuk menentukan maxY berdasarkan sensor type
double _getMaxYForSensor(String sensorType) {
  switch (sensorType) {
    case 'pH':
      return 14.0;  // Batas maksimal untuk pH
    case 'TDS':
      return 500.0;  // Batas maksimal untuk TDS
    case 'DO':
      return 5000.0;  // Batas maksimal untuk DO
    case 'temperature':
      return 50.0;  // Batas maksimal untuk Temperature
    default:
      return 100.0;  // Default maxY jika sensor tidak dikenal
  }
}

  FlTitlesData _buildTitles(String unit) {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
        getTitlesWidget: (value, meta) {
          // Format timestamp menjadi format waktu 24 jam
          final timestamp = DateTime.fromMillisecondsSinceEpoch(value.toInt());
          final formattedTime = '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
          return Text(
            formattedTime,
            style: const TextStyle(fontSize: 10),
          );
        },
      ),
    ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          getTitlesWidget: (value, meta) => Text(
            '${value.toInt()} $unit',
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
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
