import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cigarette_tracker/models/cigarette_log.dart';
import 'package:cigarette_tracker/services/local_storage_service.dart';

void main() {
  group('LocalStorageService', () {
    late LocalStorageService service;

    setUp(() {
      SharedPreferences.setMockInitialValues({}); // Clear any previous data
      service = LocalStorageService();
    });

    test('getCigaretteLogs returns empty list if no logs exist', () async {
      final logs = await service.getCigaretteLogs();
      expect(logs, isEmpty);
    });

    test('saveCigaretteLogs saves logs correctly', () async {
      final log1 = CigaretteLog(timestamp: DateTime(2023, 1, 1, 10, 0, 0));
      final log2 = CigaretteLog(timestamp: DateTime(2023, 1, 1, 11, 0, 0));
      final logsToSave = [log1, log2];

      await service.saveCigaretteLogs(logsToSave);
      final retrievedLogs = await service.getCigaretteLogs();

      expect(retrievedLogs.length, 2);
      expect(retrievedLogs[0].timestamp, log1.timestamp);
      expect(retrievedLogs[1].timestamp, log2.timestamp);
    });

    test('addCigaretteLog adds a new log correctly', () async {
      final initialLog = CigaretteLog(timestamp: DateTime(2023, 1, 1, 9, 0, 0));
      await service.addCigaretteLog(initialLog);

      final newLog = CigaretteLog(timestamp: DateTime(2023, 1, 1, 12, 0, 0));
      await service.addCigaretteLog(newLog);

      final retrievedLogs = await service.getCigaretteLogs();

      expect(retrievedLogs.length, 2);
      expect(retrievedLogs[0].timestamp, initialLog.timestamp);
      expect(retrievedLogs[1].timestamp, newLog.timestamp);
    });
  });
}

