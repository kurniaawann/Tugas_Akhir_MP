import 'package:tugas_akhir/models/question.dart';

List<Question> sampeQuizMatematika() {
  return [
    Question(
      id: 1,
      subjectId: 1,
      questionText: 'Berapa hasil dari 2 + 2?',
      options: ['3', '4', '5', '6'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 2,
      subjectId: 1,
      questionText: 'Hasil dari 5 × 3 adalah?',
      options: ['8', '15', '10', '20'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 3,
      subjectId: 1,
      questionText: '12 dibagi 4 sama dengan?',
      options: ['2', '3', '4', '5'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 4,
      subjectId: 1,
      questionText: 'Akar dari 49 adalah?',
      options: ['6', '7', '8', '9'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 5,
      subjectId: 1,
      questionText: 'Nilai dari 10 - 6 adalah?',
      options: ['2', '3', '4', '5'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 6,
      subjectId: 1,
      questionText: '7 + 8 = ?',
      options: ['14', '15', '16', '13'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 7,
      subjectId: 1,
      questionText: '9 × 1 = ?',
      options: ['7', '8', '9', '10'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 8,
      subjectId: 1,
      questionText: 'Berapa hasil dari 6 + 2?',
      options: ['6', '8', '7', '9'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 9,
      subjectId: 1,
      questionText: '5 × 5 = ?',
      options: ['10', '15', '25', '20'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 10,
      subjectId: 1,
      questionText: '100 - 25 = ?',
      options: ['75', '65', '85', '90'],
      correctAnswerIndex: 0,
    ),
  ];
}
