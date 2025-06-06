// providers/quiz_provider.dart
import 'package:flutter/material.dart';
import 'package:tugas_akhir/database/database_helper.dart';
import 'package:tugas_akhir/models/quiz_subject.dart';

import '../models/question.dart';
import '../models/user_answer.dart';

class QuizProvider with ChangeNotifier {
  // List pertanyaan yang akan digunakan dalam kuis
  List<Question> _questions = [];

  // List jawaban yang diberikan oleh pengguna
  List<UserAnswer> _userAnswers = [];

  // Indeks pertanyaan saat ini
  int _currentQuestionIndex = 0;

  // Menyimpan status apakah kuis telah selesai
  bool _quizCompleted = false;

  // Menyimpan semua mata pelajaran kuis dari database
  List<QuizSubject> _getAllSubjects = [];

  // Status pemuatan data subject
  bool _isLoadingQuizSubject = false;

  // Getter untuk mengetahui apakah data subject sedang dimuat
  bool get isLoadingQuizSubject => _isLoadingQuizSubject;

  // Getter untuk list pertanyaan kuis
  List<Question> get questions => _questions;

  // Getter untuk list jawaban pengguna
  List<UserAnswer> get userAnswers => _userAnswers;

  // Getter untuk list semua subject dari database
  List<QuizSubject> get getAllSubjects => _getAllSubjects;

  // Getter untuk indeks pertanyaan saat ini
  int get currentQuestionIndex => _currentQuestionIndex;

  // Getter untuk mengetahui apakah kuis telah selesai
  bool get quizCompleted => _quizCompleted;

  // Getter untuk mengecek apakah semua pertanyaan telah dijawab
  bool get allQuestionsAnswered =>
      _userAnswers.every((answer) => answer.selectedAnswerIndex != null);

  // Menginisialisasi kuis dengan list pertanyaan
  void initializeQuiz(List<Question> questions) {
    _questions = questions;
    _userAnswers =
        questions
            .map(
              (q) => UserAnswer(
                questionId: q.id!,
                selectedAnswerIndex: null,
                isCorrect: false,
              ),
            )
            .toList();
    _currentQuestionIndex = 0;
    _quizCompleted = false;
    notifyListeners();
  }

  // Menyimpan jawaban yang dipilih oleh pengguna
  void selectAnswer(int answerIndex) {
    /// Jika indeks pertanyaan saat ini tidak valid, hentikan proses
    if (_currentQuestionIndex >= _questions.length) return;

    /// Ambil data pertanyaan berdasarkan indeks saat ini
    final question = _questions[_currentQuestionIndex];

    /// Periksa apakah jawaban pengguna sesuai dengan jawaban benar
    final isCorrect = answerIndex == question.correctAnswerIndex;

    /// Simpan jawaban pengguna ke dalam list userAnswers
    _userAnswers[_currentQuestionIndex] = UserAnswer(
      questionId: question.id!,
      selectedAnswerIndex: answerIndex,
      isCorrect: isCorrect,
    );

    notifyListeners();
  }

  // Berpindah ke pertanyaan berikutnya
  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // Kembali ke pertanyaan sebelumnya
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  // Pindah ke pertanyaan tertentu berdasarkan index
  void goToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }

  // Menandai kuis telah selesai dikerjakan
  void completeQuiz() {
    _quizCompleted = true;
    notifyListeners();
  }

  // Menghitung dan mengembalikan hasil kuis
  Map<String, dynamic> getResults() {
    // Menghitung jumlah jawaban yang benar dari list jawaban pengguna
    final correctAnswers = _userAnswers.where((a) => a.isCorrect).length;

    // Menghitung jumlah jawaban yang salah dengan mengurangkan jumlah jawaban benar dari total jawaban
    final wrongAnswers = _userAnswers.length - correctAnswers;

    // Menghitung skor akhir dengan skala 10, lalu dibulatkan ke angka terdekat
    final score = (correctAnswers / _userAnswers.length * 10).round();

    return {
      'correct': correctAnswers, // jumlah jawaban benar
      'wrong': wrongAnswers, // jumlah jawaban salah
      'score': score, // skor akhir (skala 10)
    };
  }

  // Mengambil semua data subject dari database
  void getDataQuizSubject() async {
    _isLoadingQuizSubject = true;
    notifyListeners();

    _getAllSubjects = await DatabaseHelper.instance.getAllSubjects();

    _isLoadingQuizSubject = false;
    notifyListeners();
  }

  // Mengambil list pertanyaan berdasarkan ID subject
  Future<List<Question>> getQuestionsForSubject(int subjectId) async {
    final result = await DatabaseHelper.instance.getQuestionsBySubject(
      subjectId,
    );
    return result;
  }
}
