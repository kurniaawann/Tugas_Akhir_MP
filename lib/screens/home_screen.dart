import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir/providers/quiz_provider.dart';
import 'package:tugas_akhir/screens/quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false).getDataQuizSubject();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context);

    if (provider.isLoadingQuizSubject) {
      return Scaffold(
        appBar: AppBar(title: Text('Pilih Pelajaran')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final subjects = provider.getAllSubjects;

    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Pelajaran')),
      body:
          subjects.isEmpty
              ? const Center(child: Text('Tidak ada data.'))
              : ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(subject.name),
                      onTap: () async {
                        // First get the questions asynchronously
                        final questions = await provider.getQuestionsForSubject(
                          subject.id,
                        );

                        // Then check if widget is still mounted
                        if (!context.mounted) return;

                        // Finally navigate with the obtained questions
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => QuizScreen(
                                  subjectName: subject.name,
                                  questions:
                                      questions, // Use the pre-fetched questions here
                                ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
