class UpcomingQuiz {
  final int id;
  final String title;
  final List<String> qms;
  final DateTime date;
  final String registrationLink;

  UpcomingQuiz({
    required this.id,
    required this.title,
    required this.qms,
    required this.date,
    required this.registrationLink,
  });

  factory UpcomingQuiz.fromJson(Map<String, dynamic> json) {
  return UpcomingQuiz(
    id: json['id'] as int,
    title: json['title'] as String,
    qms: (json['QMs'] is List) 
        ? List<String>.from(json['QMs']) 
        : [], // Provide a fallback empty list
    date: DateTime.parse(json['date']),
    registrationLink: json['registration_link'] as String,
  );
}

}
