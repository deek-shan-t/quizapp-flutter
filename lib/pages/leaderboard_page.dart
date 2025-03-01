import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/leaderboard_entry.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<LeaderboardEntry>>(
          future: ApiService.getLeaderboard(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No leaderboard data available.'),
              );
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 24,
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey[200]!,
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Quiz Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Mordor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Rivendell',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'HelmsDeep',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Edoras',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                  rows:
                      snapshot.data!.map((entry) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                entry.quizName,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.mordor?.toString() ?? '0',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.rivendell?.toString() ?? '0',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.helmsDeep?.toString() ?? '0',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.edoras?.toString() ?? '0',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
