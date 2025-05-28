import 'package:flutter/material.dart';
import 'package:tugas_akhir/screens/quiz_screen.dart';

import '../database/database_helper.dart';
import '../models/quiz_subject.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Pelajaran')),
      body: FutureBuilder<List<QuizSubject>>(
        future: DatabaseHelper.instance.getAllSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final subjects = snapshot.data ?? [];

          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Text(subject.icon, style: TextStyle(fontSize: 24)),
                  title: Text(subject.name),
                  onTap: () async {
                    final questions = await DatabaseHelper.instance
                        .getQuestionsBySubject(subject.id);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => QuizScreen(
                              subjectName: subject.name,
                              questions: questions,
                            ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
