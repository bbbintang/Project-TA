import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrafikFix extends StatelessWidget {
  final data = LineData();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 6000,
          width: 5000,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: _isiContainer(
                        'Suhu', data.bottomTitleSuhu, data.leftTitleSuhu),
                  )
                ],
              ),
            ),
          ),
        )
      ],
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
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 253, 241, 216).withOpacity(0.5)),
      child: child);
  }
}

Widget _isiContainer(
    String title, Map<int, String> bottomTitles, Map<int, String> leftTitles) {
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
        Expanded(child: LineChart(_dekorasiChart(bottomTitles, leftTitles)))
      ],
    )),
  );
}

LineChartData _dekorasiChart(
    Map<int, String> bottomTitles, Map<int, String> leftTitles) {
  return LineChartData(
      minX: 0,
      maxX: 120,
      minY: -5,
      maxY: 105,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(
        show: false,
      ),
      titlesData: _ketentuanData(bottomTitles, leftTitles),
      lineBarsData: [
        LineChartBarData(
            isCurved: true,
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 120, 163, 235),
              Color.fromARGB(255, 251, 194, 235),
            ]),
            barWidth: 5,
            belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 120, 163, 235).withOpacity(0.5),
                      Color.fromARGB(255, 251, 194, 235).withOpacity(0.3),
                    ])),
            spots: LineData().spots),
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
  final spots = [
    FlSpot(1.68, 21.04),
    FlSpot(2.84, 26.23),
    FlSpot(5.19, 19.82),
    FlSpot(6.01, 24.49),
    FlSpot(7.81, 19.82),
    FlSpot(9.49, 23.50),
    FlSpot(12.26, 19.57),
    FlSpot(15.63, 20.90),
    FlSpot(20.39, 39.20),
    FlSpot(23.69, 75.62),
    FlSpot(26.21, 46.58),
    FlSpot(29.87, 42.97),
    FlSpot(32.49, 46.54),
    FlSpot(35.09, 40.72),
    FlSpot(38.74, 43.18),
  ];

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

  final leftTitleAir = {
    0: '0ml',
    20: '200ml',
    40: '400ml',
    60: '600ml',
    80: '800ml',
    100: '1000ml'
  };

  final bottomTitleAir = {
    0: '00:00',
    10: '01:00',
    20: '02:00',
    30: '03:00',
    40: '04:00',
    50: '05:00',
  };
}
