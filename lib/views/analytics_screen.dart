import 'package:flutter/material.dart';
import 'package:cigarette_tracker/services/local_storage_service.dart';
import 'package:cigarette_tracker/services/analytics_service.dart';
import 'package:cigarette_tracker/models/cigarette_log.dart';
import 'package:fl_chart/fl_chart.dart';

enum AnalyticsPeriod {
  daily,
  weekly,
  monthly,
  yearly,
}

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final LocalStorageService _localStorageService = LocalStorageService();
  final AnalyticsService _analyticsService = AnalyticsService();
  List<CigaretteLog> _logs = [];
  AnalyticsPeriod _selectedPeriod = AnalyticsPeriod.daily;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    _logs = await _localStorageService.getCigaretteLogs();
    setState(() {});
  }

  Map<String, int> _getCountsForPeriod() {
    switch (_selectedPeriod) {
      case AnalyticsPeriod.daily:
        return _analyticsService.getDailyCounts(_logs);
      case AnalyticsPeriod.weekly:
        return _analyticsService.getWeeklyCounts(_logs);
      case AnalyticsPeriod.monthly:
        return _analyticsService.getMonthlyCounts(_logs);
      case AnalyticsPeriod.yearly:
        return _analyticsService.getYearlyCounts(_logs);
    }
  }

  @override
  Widget build(BuildContext context) {
    final counts = _getCountsForPeriod();
    final sortedKeys = counts.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton<AnalyticsPeriod>(
              value: _selectedPeriod,
              onChanged: (AnalyticsPeriod? newValue) {
                setState(() {
                  _selectedPeriod = newValue!;
                });
              },
              items: const <DropdownMenuItem<AnalyticsPeriod>>[
                DropdownMenuItem(
                  value: AnalyticsPeriod.daily,
                  child: Text('Daily'),
                ),
                DropdownMenuItem(
                  value: AnalyticsPeriod.weekly,
                  child: Text('Weekly'),
                ),
                DropdownMenuItem(
                  value: AnalyticsPeriod.monthly,
                  child: Text('Monthly'),
                ),
                DropdownMenuItem(
                  value: AnalyticsPeriod.yearly,
                  child: Text('Yearly'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Total Cigarettes: ${_logs.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: sortedKeys.length,
                itemBuilder: (context, index) {
                  final key = sortedKeys[index];
                  final value = counts[key];
                  return ListTile(
                    title: Text('$key: $value cigarettes'),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: counts.entries.map((entry) {
                    return BarChartGroupData(
                      x: sortedKeys.indexOf(entry.key),
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.toDouble(),
                          color: Colors.blueAccent,
                          width: 15,
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(sortedKeys[value.toInt()]),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

