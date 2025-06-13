import 'package:flutter/material.dart';
import 'package:cigarette_tracker/models/cigarette_log.dart';
import 'package:cigarette_tracker/services/local_storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalStorageService _localStorageService = LocalStorageService();

  Future<void> _logCigarette() async {
    final newLog = CigaretteLog(timestamp: DateTime.now());
    await _localStorageService.addCigaretteLog(newLog);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cigarette logged!'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cigarette Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Press the button to log a cigarette:',
            ),
            ElevatedButton(
              onPressed: _logCigarette,
              child: const Text('Log Cigarette'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/analytics');
              },
              child: const Text('View Analytics'),
            ),
          ],
        ),
      ),
    );
  }
}

