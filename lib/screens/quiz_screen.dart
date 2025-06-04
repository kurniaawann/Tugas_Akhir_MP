import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_akhir/models/question.dart';

import '../providers/quiz_provider.dart';
import '../providers/timer_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String subjectName;
  final List<Question> questions;

  const QuizScreen({
    super.key,
    required this.subjectName,
    required this.questions,
  });

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  late TimerProvider _timerProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timerProvider = Provider.of<TimerProvider>(context, listen: false);
      _timerProvider.startTimer();

      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      quizProvider.initializeQuiz(widget.questions);

      // Start timer
      _startCountdown();
    });
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      _timerProvider.tick();

      if (_timerProvider.timeIsUp) {
        _showTimeUpDialog();
        return false;
      }
      return true;
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text('Waktu Habis'),
            content: Text('Waktu pengerjaan kuis telah habis.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final timerProvider = Provider.of<TimerProvider>(context);

    if (timerProvider.timeIsUp) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showTimeUpDialog();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                timerProvider.formattedTime,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Soal ${quizProvider.currentQuestionIndex + 1}/${quizProvider.questions.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(child: _buildQuestionCard(context)),
            SizedBox(height: 16),
            _buildQuestionNavigation(context),
            SizedBox(height: 16),
            if (quizProvider.currentQuestionIndex ==
                    quizProvider.questions.length - 1 &&
                quizProvider.allQuestionsAnswered)
              ElevatedButton(
                onPressed: () {
                  quizProvider.completeQuiz();
                  final results = quizProvider.getResults();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ResultScreen(
                            correctAnswers: results['correct'],
                            wrongAnswers: results['wrong'],
                            score: results['score'],
                          ),
                    ),
                  );
                },
                child: Text('Selesai'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final currentQuestion =
        quizProvider.questions[quizProvider.currentQuestionIndex];
    final currentAnswer =
        quizProvider.userAnswers[quizProvider.currentQuestionIndex];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentQuestion.questionText, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Column(
              children:
                  currentQuestion.options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    final optionLetter = String.fromCharCode(
                      65 + index,
                    ); // A, B, C, D

                    return RadioListTile<int>(
                      title: Text('$optionLetter. $option'),
                      value: index,
                      groupValue: currentAnswer.selectedAnswerIndex,
                      onChanged: (value) {
                        quizProvider.selectAnswer(value!);
                      },
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionNavigation(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(quizProvider.questions.length, (index) {
                final isAnswered =
                    quizProvider.userAnswers[index].selectedAnswerIndex != null;
                final isCurrent = index == quizProvider.currentQuestionIndex;

                return GestureDetector(
                  onTap: () {
                    quizProvider.goToQuestion(
                      index,
                    ); // Now using the proper method
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color:
                          isCurrent
                              ? Colors.blue
                              : isAnswered
                              ? Colors.green
                              : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isCurrent ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed:
                      quizProvider.currentQuestionIndex > 0
                          ? () => quizProvider.previousQuestion()
                          : null,
                  child: Text('Sebelumnya'),
                ),
                ElevatedButton(
                  onPressed:
                      quizProvider.currentQuestionIndex <
                              quizProvider.questions.length - 1
                          ? () => quizProvider.nextQuestion()
                          : null,
                  child: Text('Selanjutnya'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
