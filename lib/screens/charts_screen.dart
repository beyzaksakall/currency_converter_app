import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  static const Map<String, double> rates = {
    'TRY': 34.50,
    'EUR': 0.92,
    'GBP': 0.78,
    'JPY': 150.25,
  };

  static const Map<String, double> changes = {
    'TRY': 2.1,
    'EUR': -0.4,
    'GBP': 1.3,
    'JPY': -0.8,
  };

  List<FlSpot> _trend(double v) => [
    FlSpot(0, v * 0.85),
    FlSpot(1, v * 0.9),
    FlSpot(2, v * 0.93),
    FlSpot(3, v * 0.97),
    FlSpot(4, v),
  ];

  Widget _summaryTable() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          const Text(
            '1 USD Döviz Özeti',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...rates.keys.map((k) {
            final change = changes[k]!;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(k, style: const TextStyle(fontSize: 16)),
                  Text(rates[k]!.toStringAsFixed(2)),
                  Text(
                    '${change > 0 ? '▲' : '▼'} ${change.abs()}%',
                    style: TextStyle(
                      color: change > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _currencyCard(String code, double value) {
    final change = changes[code]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1 USD → $code',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E0219),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${change > 0 ? '▲' : '▼'} ${change.abs()}%',
                    style: TextStyle(
                      color: change > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.black87,
                    getTooltipItems: (spots) {
                      return spots.map((s) {
                        return LineTooltipItem(
                          s.y.toStringAsFixed(2),
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: _trend(value),
                    isCurved: true,
                    color: const Color(0xFF2E0219),
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF2E0219).withOpacity(0.15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('USD Karşılığı Analiz'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _summaryTable(),
            ...rates.entries.map((e) => _currencyCard(e.key, e.value)).toList(),
          ],
        ),
      ),
    );
  }
}
