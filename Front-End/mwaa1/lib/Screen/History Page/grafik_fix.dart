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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: _isiContainer(
                        'PH', data.bottomTitleDO, data.leftTitleDO),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: _isiContainer(
                        'TDS', data.bottomTitleDO, data.leftTitleDO),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: _isiContainer(
                        'DO', data.bottomTitleDO, data.leftTitleDO),
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
                      Color.fromARGB(255, 120, 163, 235)
                          .withAlpha((0.5 * 255).toInt()),
                      Color.fromARGB(255, 251, 194, 235)
                          .withAlpha((0.3 * 255).toInt()),
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
        reservedSize: 50,
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
    FlSpot(1.68, 28.04),
    FlSpot(30.84, 30.23),
    FlSpot(40.19, 27.82),
    FlSpot(50.01, 26.49),
    FlSpot(60.81, 35.82),
    FlSpot(70.49, 25.50),
    FlSpot(80.26, 30.57),
    FlSpot(90.26, 30.57),
    FlSpot(100.26, 32.57),
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

  final leftTitleDO = {
    0: '0 mg/L',
    20: '2 mg/L',
    40: '4 mg/L',
    60: '6 mg/L',
    80: '8 mg/L',
    100: '10 mg/L'
  };

  final bottomTitleDO = {
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
