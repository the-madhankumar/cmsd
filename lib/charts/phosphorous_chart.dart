import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

final gradientList = <List<Color>>[
  [
    const Color.fromRGBO(223, 250, 92, 1),
    const Color.fromRGBO(129, 250, 112, 1),
  ],
  [
    const Color.fromRGBO(129, 182, 205, 1),
    const Color.fromRGBO(91, 253, 199, 1),
  ],
  [
    const Color.fromRGBO(175, 63, 62, 1.0),
    const Color.fromRGBO(254, 154, 92, 1),
  ]
];

void main() {
  runApp(const PhosphoChartApp());
}

class PhosphoChartApp extends StatelessWidget {
  const PhosphoChartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PhosphoChartApp(),
    );
  }
}

class PhosphoChart extends StatefulWidget {
  const PhosphoChart({super.key});

  @override
  State<PhosphoChart> createState() => _PhosphoChartState();
}

class _PhosphoChartState extends State<PhosphoChart> {
  Map<String, double> dataMap = {
    'GOOD': 50,
    'SAFE': 30,
    'BAD': 20,
  };

  List<Color> colorList = [Colors.red, Colors.blue, Colors.green];

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Phosphorous Data'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100.0),
                child: const Text(
                  'Phosphorous',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 80.0),
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: const Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  colorList: colorList,
                  gradientList: gradientList,
                  emptyColorGradient: const [
                    Color(0xff6c5ce7),
                    Colors.blue,
                  ],
                  initialAngleInDegree: 0,
                  chartType: ChartType.disc,
                  ringStrokeWidth: 0,
                  centerText: "NUTRIENT VALUE",
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.bottom,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: true,
                    decimalPlaces: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
