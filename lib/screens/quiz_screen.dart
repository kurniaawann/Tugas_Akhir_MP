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
      _dialogShown = false;
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
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.orange[200]!, Colors.pink[200]!],
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer_off, size: 60, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    'Waktu Habis!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Waktu pengerjaan kuis telah habis.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
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
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Quiz'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          widget.subjectName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[400]!, Colors.purple[400]!],
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer, color: Colors.white, size: 20),
                const SizedBox(width: 5),
                Text(
                  timerProvider.formattedTime,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value:
                  (quizProvider.currentQuestionIndex + 1) /
                  quizProvider.questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[300]!),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 16),

            // Question counter
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Color(0xFFF564A9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Soal ${quizProvider.currentQuestionIndex + 1}/${quizProvider.questions.length}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            // Question card
            Expanded(
              child: Card(
                color: Colors.blue[300],
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentQuestion.questionText,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
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

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      quizProvider.selectAnswer(index);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color:
                                            currentAnswer
                                                        ?.selectedAnswerIndex ==
                                                    index
                                                ? Colors.blue[50]
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color:
                                              currentAnswer
                                                          ?.selectedAnswerIndex ==
                                                      index
                                                  ? Colors.blue[300]!
                                                  : Colors.grey[300]!,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 28,
                                            height: 28,
                                            decoration: BoxDecoration(
                                              color:
                                                  currentAnswer
                                                              ?.selectedAnswerIndex ==
                                                          index
                                                      ? Colors.blue[400]
                                                      : Colors.grey[200],
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                optionLetter,
                                                style: TextStyle(
                                                  color:
                                                      currentAnswer
                                                                  ?.selectedAnswerIndex ==
                                                              index
                                                          ? Colors.white
                                                          : Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              option,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          if (currentAnswer
                                                  ?.selectedAnswerIndex ==
                                              index)
                                            const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Navigation controls
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Question bubbles
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
                          onTap: () => quizProvider.goToQuestion(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color:
                                  isCurrent
                                      ? Colors.blue[400]
                                      : isAnswered
                                      ? Color(0xFFF564A9)
                                      : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow:
                                  isCurrent
                                      ? [
                                        BoxShadow(
                                          color: Colors.blue.withOpacity(0.4),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                      : null,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color:
                                      isCurrent || isAnswered
                                          ? Colors.white
                                          : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),

                    // Navigation buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // disabledBackgroundColor: Colors.white,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            shape:
                                quizProvider.currentQuestionIndex > 0
                                    ? RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    )
                                    : RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            elevation: 0,
                          ),
                          onPressed:
                              quizProvider.currentQuestionIndex > 0
                                  ? () => quizProvider.previousQuestion()
                                  : null,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_back_ios),
                              SizedBox(width: 8),
                              Text('Sebelumnya'),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            shape:
                                quizProvider.currentQuestionIndex <
                                        quizProvider.questions.length - 1
                                    ? RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    )
                                    : RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            elevation: 0,
                          ),
                          onPressed:
                              quizProvider.currentQuestionIndex <
                                      quizProvider.questions.length - 1
                                  ? () => quizProvider.nextQuestion()
                                  : null,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Selanjutnya'),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Submit button (only shown on last question)
            if (quizProvider.currentQuestionIndex ==
                    quizProvider.questions.length - 1 &&
                quizProvider.allQuestionsAnswered)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 2,
                ),
                onPressed: () {
                  quizProvider.completeQuiz();
                  final results = quizProvider.getResults();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ResultScreen(
                            questionCount: quizProvider.questions.length,
                            correctAnswers: results['correct'],
                            wrongAnswers: results['wrong'],
                            score: results['score'],
                          ),
                    ),
                  );
                },
                child: const Text(
                  'Selesai',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
