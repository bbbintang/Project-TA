import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrafikFix extends StatefulWidget {
  @override
  _GrafikFixState createState() => _GrafikFixState();
}
class _GrafikFixState extends State<GrafikFix> {
  String _selectedPeriod = '24 jam terakhir'; // Default pilihan
  DateTime _periodStartDate = DateTime.now().subtract(Duration(hours: 24));

  @override
  void initState() {
    super.initState();
    _periodStartDate = DateTime.now().subtract(Duration(hours: 24));}

  void _updateStartDate() {
    final now = DateTime.now();
    setState(() {
    switch (_selectedPeriod) {
      case '24 jam terakhir':
        _periodStartDate = now.subtract(Duration(hours: 24));
        break;
      case '3 hari terakhir':
        _periodStartDate = now.subtract(Duration(days: 3));
        break;
      case '7 hari terakhir':
        _periodStartDate = now.subtract(Duration(days: 7));
        break;
      case '1 bulan terakhir':
        _periodStartDate = now.subtract(Duration(days: 30));
        break;
      default:
        _periodStartDate = now.subtract(Duration(hours: 24));
    }
    });
    print('Period Start Date Updated: $_periodStartDate');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<List<FlSpot>>>>(
      future: Future.wait([
        _fetchAllSensorData('Alat1', FirebaseFirestore.instance),
        _fetchAllSensorData('Alat2', FirebaseFirestore.instance),
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
                  DropdownButton<String>(
                    value: _selectedPeriod,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedPeriod = newValue!;
                        _updateStartDate(); // Update tanggal mulai
                      });
                    },
                    items: <String>['24 jam terakhir',
                      '3 hari terakhir',
                      '7 hari terakhir',
                      '1 bulan terakhir']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
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

    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      final timestamp = data['timestamp']?.toDate() as DateTime?;
      final value = data[sensorType]?.toDouble();

      if (timestamp != null &&
    value != null && timestamp.isAfter(_periodStartDate)) {
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
    double maxX = 24; // X-axis 24 jam untuk interval harian
    double minX = 0;

    // Sesuaikan batas X untuk rentang waktu yang lebih panjang
    if (_selectedPeriod == '3 hari terakhir') {
      maxX = 72; // 72 jam untuk 3 hari
    } else if (_selectedPeriod == '7 hari terakhir') {
      maxX = 168; // 168 jam untuk 7 hari
    } else if (_selectedPeriod == '1 bulan terakhir') {
      maxX = 720; // 720 jam untuk 1 bulan (estimasi)
    }

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
                  minX: minX, // Mulai dari jam 00:00
                  maxX: maxX, // Sampai jam 24:00
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
                        interval: maxX/6, // Interval setiap 6 jam
                        getTitlesWidget: (value, meta) {
                          final hour = value.toInt();
                          return Text(
                              '$hour:00',
                              style: const TextStyle(fontSize: 10),
                            );
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
        return 5000.0;
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
