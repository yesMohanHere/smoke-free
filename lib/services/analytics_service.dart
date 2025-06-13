import 'package:cigarette_tracker/models/cigarette_log.dart';

class AnalyticsService {
  Map<String, int> getDailyCounts(List<CigaretteLog> logs) {
    Map<String, int> dailyCounts = {};
    for (var log in logs) {
      String date = log.timestamp.toLocal().toString().split(' ')[0];
      dailyCounts.update(date, (value) => value + 1, ifAbsent: () => 1);
    }
    return dailyCounts;
  }

  Map<String, int> getWeeklyCounts(List<CigaretteLog> logs) {
    Map<String, int> weeklyCounts = {};
    for (var log in logs) {
      // Simple week calculation: week of the year
      // This can be improved for more accurate week-based analytics
      int week = (log.timestamp.day / 7).ceil();
      String yearWeek = '${log.timestamp.year}-W$week';
      weeklyCounts.update(yearWeek, (value) => value + 1, ifAbsent: () => 1);
    }
    return weeklyCounts;
  }

  Map<String, int> getMonthlyCounts(List<CigaretteLog> logs) {
    Map<String, int> monthlyCounts = {};
    for (var log in logs) {
      String yearMonth = '${log.timestamp.year}-${log.timestamp.month.toString().padLeft(2, '0')}';
      monthlyCounts.update(yearMonth, (value) => value + 1, ifAbsent: () => 1);
    }
    return monthlyCounts;
  }

  Map<String, int> getYearlyCounts(List<CigaretteLog> logs) {
    Map<String, int> yearlyCounts = {};
    for (var log in logs) {
      String year = log.timestamp.year.toString();
      yearlyCounts.update(year, (value) => value + 1, ifAbsent: () => 1);
    }
    return yearlyCounts;
  }
}

