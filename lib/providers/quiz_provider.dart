// providers/quiz_provider.dart
import 'package:flutter/material.dart';
import 'package:tugas_akhir/database/database_helper.dart';
import 'package:tugas_akhir/models/quiz_subject.dart';

import '../models/question.dart';
import '../models/user_answer.dart';

class QuizProvider with ChangeNotifier {
  List<Question> _questions = [];
  List<UserAnswer> _userAnswers = [];
  int _currentQuestionIndex = 0;
  bool _quizCompleted = false;
  List<QuizSubject> _getAllSubjects = [];

  bool _isLoadingQuizSubject = false;

  bool get isLoadingQuizSubject => _isLoadingQuizSubject;

  List<Question> get questions => _questions;
  List<UserAnswer> get userAnswers => _userAnswers;
  List<QuizSubject> get getAllSubjects => _getAllSubjects;
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get quizCompleted => _quizCompleted;
  bool get allQuestionsAnswered =>
      _userAnswers.every((answer) => answer.selectedAnswerIndex != null);

  void initializeQuiz(List<Question> questions) {
    _questions = questions;
    _userAnswers =
        questions
            .map(
              (q) => UserAnswer(
                questionId: q.id,
                selectedAnswerIndex: null,
                isCorrect: false,
              ),
            )
            .toList();
    _currentQuestionIndex = 0;
    _quizCompleted = false;
    notifyListeners();
  }

  void selectAnswer(int answerIndex) {
    if (_currentQuestionIndex >= _questions.length) return;

    final question = _questions[_currentQuestionIndex];
    final isCorrect = answerIndex == question.correctAnswerIndex;

    _userAnswers[_currentQuestionIndex] = UserAnswer(
      questionId: question.id,
      selectedAnswerIndex: answerIndex,
      isCorrect: isCorrect,
    );

    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  // Add this new method to change question by index
  void goToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }

  void completeQuiz() {
    _quizCompleted = true;
    notifyListeners();
  }

  Map<String, dynamic> getResults() {
    final correctAnswers = _userAnswers.where((a) => a.isCorrect).length;
    final wrongAnswers = _userAnswers.length - correctAnswers;
    final score = (correctAnswers / _userAnswers.length * 10).round();

    return {'correct': correctAnswers, 'wrong': wrongAnswers, 'score': score};
  }

  getDataQuizSubject() async {
    _isLoadingQuizSubject = true;
    notifyListeners();
    _getAllSubjects = await DatabaseHelper.instance.getAllSubjects();
    _isLoadingQuizSubject = false;
    notifyListeners();
  }
}
