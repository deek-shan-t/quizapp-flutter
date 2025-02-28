// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/past_quiz.dart';
import '../models/leaderboard_entry.dart';
import '../models/featured_member.dart';
import '../models/upcoming_quiz.dart';

class ApiService {
  static const String baseUrl =
      'https://quiz-backend-production-113d.up.railway.app/api';

  // Fetch upcoming quizzes
  static Future<List<UpcomingQuiz>> getUpcomingQuizzes() async {
    final response = await http.get(Uri.parse('$baseUrl/upcoming_quizzes'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((quiz) => UpcomingQuiz.fromJson(quiz)).toList();
    } else {
      throw Exception('Failed to load upcoming quizzes');
    }
  }

  // Fetch past quizzes
  static Future<List<PastQuiz>> getPastQuizzes() async {
    final response = await http.get(Uri.parse('$baseUrl/past_quizzes'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((quiz) => PastQuiz.fromJson(quiz)).toList();
    } else {
      throw Exception('Failed to load past quizzes');
    }
  }

  // Fetch featured members
  static Future<List<FeaturedMember>> getFeaturedMembers() async {
    final response = await http.get(Uri.parse('$baseUrl/featured_members'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((member) => FeaturedMember.fromJson(member)).toList();
    } else {
      throw Exception('Failed to load featured members');
    }
  }

  // Fetch leaderboard data
  static Future<List<LeaderboardEntry>> getLeaderboard() async {
    final response = await http.get(Uri.parse('$baseUrl/leaderboard'));
    if (response.statusCode == 200) {
      print('API Response: ${response.body}'); // Debugging line
      List<dynamic> data = jsonDecode(response.body);
      return data.map((entry) => LeaderboardEntry.fromJson(entry)).toList();
    } else {
      throw Exception('Failed to load leaderboard');
    }
  }
}
