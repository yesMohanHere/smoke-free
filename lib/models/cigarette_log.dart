class CigaretteLog {
  final DateTime timestamp;

  CigaretteLog({required this.timestamp});

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
      };

  factory CigaretteLog.fromJson(Map<String, dynamic> json) => CigaretteLog(
        timestamp: DateTime.parse(json['timestamp']),
      );
}

