import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cigarette_log.dart';

class LocalStorageService {
  static const String _kCigaretteLogs = 'cigaretteLogs';

  Future<List<CigaretteLog>> getCigaretteLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? logsString = prefs.getString(_kCigaretteLogs);
    if (logsString == null) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(logsString);
    return jsonList.map((json) => CigaretteLog.fromJson(json)).toList();
  }

  Future<void> saveCigaretteLogs(List<CigaretteLog> logs) async {
    final prefs = await SharedPreferences.getInstance();
    final String logsString = jsonEncode(logs.map((log) => log.toJson()).toList());
    await prefs.setString(_kCigaretteLogs, logsString);
  }

  Future<void> addCigaretteLog(CigaretteLog log) async {
    List<CigaretteLog> logs = await getCigaretteLogs();
    logs.add(log);
    await saveCigaretteLogs(logs);
  }
}

