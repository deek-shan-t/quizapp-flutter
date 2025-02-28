import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/past_quiz.dart';
import 'package:intl/intl.dart';

class PastQuizzesPage extends StatefulWidget {
  const PastQuizzesPage({super.key});

  @override
  State<PastQuizzesPage> createState() => _PastQuizzesPageState();
}

class _PastQuizzesPageState extends State<PastQuizzesPage> {
  late Future<List<PastQuiz>> pastQuizzes;

  @override
  void initState() {
    super.initState();
    pastQuizzes = ApiService.getPastQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Past Quizzes')),
      body: FutureBuilder<List<PastQuiz>>(
        future: pastQuizzes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No past quizzes available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final quiz = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ExpansionTile(
                    title: Text(quiz.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(quiz.date)}',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('🏆 Winners: ${quiz.winners.join(", ")}', style: const TextStyle(fontSize: 16)),
                            Text('🥈 Finalists: ${quiz.finalists.join(", ")}', style: const TextStyle(fontSize: 16)),
                            Text('🎟️ Participants: ${quiz.participants.join(", ")}', style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
