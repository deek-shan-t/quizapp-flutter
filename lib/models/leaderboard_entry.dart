class LeaderboardEntry {
  final int id;
  final String quizName;
  final DateTime quizDate;
  final int? mordor;
  final int? rivendell;
  final int? helmsDeep;
  final int? edoras;

  LeaderboardEntry({
    required this.id,
    required this.quizName,
    required this.quizDate,
    this.mordor,
    this.rivendell,
    this.helmsDeep,
    this.edoras,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: json['id'] ?? 0,
      quizName: json['quiz_name'] ?? 'Unknown Quiz',
      quizDate:
          DateTime.tryParse(json['quiz_date'] ?? '') ?? DateTime(1970, 1, 1),
      mordor: json['mordor'] as int?,
      rivendell: json['rivendell'] as int?,
      helmsDeep: json['helmsdeep'] as int?,
      edoras: json['edoras'] as int?,
    );
  }
}
