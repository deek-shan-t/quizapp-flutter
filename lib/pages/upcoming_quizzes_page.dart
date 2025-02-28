import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../models/upcoming_quiz.dart';

class UpcomingQuizzesPage extends StatefulWidget {
  const UpcomingQuizzesPage({super.key});

  @override
  State<UpcomingQuizzesPage> createState() => _UpcomingQuizzesPageState();
}

class _UpcomingQuizzesPageState extends State<UpcomingQuizzesPage> {
  late Future<List<UpcomingQuiz>> upcomingQuizzes;

  @override
  void initState() {
    super.initState();
    upcomingQuizzes = ApiService.getUpcomingQuizzes();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming Quizzes')),
      body: FutureBuilder<List<UpcomingQuiz>>(
        future: upcomingQuizzes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No upcoming quizzes available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final quiz = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ExpansionTile(
                    title: Text(quiz.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('QMs: ${quiz.qms.join(", ")}', style: const TextStyle(fontSize: 16)),
                            Text('Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(quiz.date)}', style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () => _launchUrl(quiz.registrationLink),
                              child: const Text('Register'),
                            ),
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
