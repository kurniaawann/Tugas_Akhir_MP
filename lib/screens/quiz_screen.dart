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
  bool _dialogShown = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timerProvider = Provider.of<TimerProvider>(context, listen: false);
      _timerProvider.startTimer();

      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      quizProvider.initializeQuiz(widget.questions);

      _startCountdown();
      _dialogShown = false; // Reset dialog flag
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (_isDisposed) return false;

      _timerProvider.tick();

      if (_timerProvider.timeIsUp && !_dialogShown && mounted) {
        _dialogShown = true;
        _showTimeUpDialog();
        return false;
      }
      return true;
    });
  }

  void _showTimeUpDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Waktu Habis'),
            content: const Text('Waktu pengerjaan kuis telah habis.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Go back to previous screen
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final quizProvider = Provider.of<QuizProvider>(context);

    if (quizProvider.questions.isEmpty ||
        quizProvider.currentQuestionIndex >= quizProvider.questions.length) {
      return Scaffold(
        appBar: AppBar(title: Text('Quiz')),
        body: const Center(
          child: Text('No questions available or quiz completed'),
        ),
      );
    }

    final currentQuestion =
        quizProvider.questions[quizProvider.currentQuestionIndex];
    final currentAnswer =
        quizProvider.currentQuestionIndex < quizProvider.userAnswers.length
            ? quizProvider.userAnswers[quizProvider.currentQuestionIndex]
            : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                timerProvider.formattedTime,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Soal ${quizProvider.currentQuestionIndex + 1}/${quizProvider.questions.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentQuestion.questionText,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children:
                            currentQuestion.options.asMap().entries.map((
                              entry,
                            ) {
                              final index = entry.key;
                              final option = entry.value;
                              final optionLetter = String.fromCharCode(
                                65 + index,
                              );

                              return RadioListTile<int>(
                                title: Text('$optionLetter. $option'),
                                value: index,
                                groupValue: currentAnswer?.selectedAnswerIndex,
                                onChanged: (value) {
                                  quizProvider.selectAnswer(value!);
                                },
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(quizProvider.questions.length, (
                        index,
                      ) {
                        final isAnswered =
                            quizProvider
                                .userAnswers[index]
                                .selectedAnswerIndex !=
                            null;
                        final isCurrent =
                            index == quizProvider.currentQuestionIndex;

                        return GestureDetector(
                          onTap: () {
                            quizProvider.goToQuestion(index);
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
                                  color:
                                      isCurrent ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed:
                              quizProvider.currentQuestionIndex > 0
                                  ? () => quizProvider.previousQuestion()
                                  : null,
                          child: const Text('Sebelumnya'),
                        ),
                        ElevatedButton(
                          onPressed:
                              quizProvider.currentQuestionIndex <
                                      quizProvider.questions.length - 1
                                  ? () => quizProvider.nextQuestion()
                                  : null,
                          child: const Text('Selanjutnya'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
                child: const Text('Selesai'),
              ),
          ],
        ),
      ),
    );
  }
}
