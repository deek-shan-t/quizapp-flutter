class PastQuiz {
  final int id;
  final String title;
  final List<String> winners;
  final List<String> finalists;
  final List<String> participants;
  final DateTime date;

  PastQuiz({
    required this.id,
    required this.title,
    required this.winners,
    required this.finalists,
    required this.participants,
    required this.date,
  });

  factory PastQuiz.fromJson(Map<String, dynamic> json) {
    return PastQuiz(
      id: json['id'] as int,
      title: json['title'] as String,
      winners: List<String>.from(json['winners'] as List),
      finalists: List<String>.from(json['finalists'] as List),
      participants: List<String>.from(json['participants'] as List),
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'winners': winners,
      'finalists': finalists,
      'participants': participants,
      'date': date.toIso8601String(),
    };
  }
}
