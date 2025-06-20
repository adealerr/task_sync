import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:task_sync/core/colors.dart';
import 'package:task_sync/utils/platform_helper.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBackgroundSecondary,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: lightBackground,
            ),
            onPressed: Navigator.of(context).pop,
          ),
          backgroundColor: lightPrimary,
          title: const Text('Отчетность', style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const ReportView());
  }
}

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = !PlatformHelper.runningPlatform.isDesktop;

    final Map<String, int> userTaskCount = {
      'Иван Иванов': 5,
      'Мария Смирнова': 3,
      'Олег Кузнецов': 7,
      'Павел Орлов': 2,
    };

    return Padding(
      padding: const EdgeInsets.all(16.0) + const EdgeInsets.only(top: 24),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(
              axisNameSize: 56,
              axisNameWidget: Padding(
                padding: EdgeInsets.only(bottom: 36),
                  child: Text('Количество задач'),),
              sideTitles: SideTitles(
                reservedSize: 56,
                showTitles: false,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) => Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                reservedSize: 24,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 56,
                getTitlesWidget: (value, meta) {
                  final name = userTaskCount.keys.elementAt(value.toInt());
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(name, style: const TextStyle(fontSize: 12)),
                  );
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
              userTaskCount.length,
              (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: userTaskCount.values.elementAt(index).toDouble(),
                        width: 20,
                        color: lightPrimary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  )),
        ),
      ),
    );
  }
}
