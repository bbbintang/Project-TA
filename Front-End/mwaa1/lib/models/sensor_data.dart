import 'package:cloud_firestore/cloud_firestore.dart';

// Tambahkan kelas untuk model data sensor (buat file baru: lib/models/sensor_data.dart)
class SensorData {
  final double temperature;
  final double ph;
  final double tds;
  final double dissolvedOxygen;
  final DateTime timestamp;

  SensorData({
    required this.temperature,
    required this.ph,
    required this.tds,
    required this.dissolvedOxygen,
    required this.timestamp,
  });

  factory SensorData.fromFirestore(Map<String, dynamic> data) {
    return SensorData(
      temperature: data['temperature']?.toDouble() ?? 0,
      ph: data['ph']?.toDouble() ?? 0,
      tds: data['tds']?.toDouble() ?? 0,
      dissolvedOxygen: data['do']?.toDouble() ?? 0,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'ph': ph,
      'tds': tds,
      'do': dissolvedOxygen,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}