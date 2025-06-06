import 'package:tugas_akhir/models/question.dart';

List<Question> sampeQuizMatematika() {
  return [
    Question(
      id: 1,
      subjectId: 1,
      questionText: 'Hasil dari 2 + 2 = ?',
      options: ['3', '4', '5', '6'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 2,
      subjectId: 1,
      questionText: 'Hasil dari 5 × 3 = ?',
      options: ['8', '15', '10', '20'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 3,
      subjectId: 1,
      questionText: 'Hasil dari 12 : 4 =?',
      options: ['2', '3', '4', '5'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 4,
      subjectId: 1,
      questionText: 'Hasil dari 10 × 5 = ?',
      options: ['6', '7', '30', '50'],
      correctAnswerIndex: 3,
    ),
    Question(
      id: 5,
      subjectId: 1,
      questionText: 'Hasil dari 10 - 6  = ?',
      options: ['2', '3', '4', '5'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 6,
      subjectId: 1,
      questionText: 'Hasil dari 7 + 8 = ?',
      options: ['14', '15', '16', '13'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 7,
      subjectId: 1,
      questionText: 'Hasil dari 9 × 1 = ?',
      options: ['7', '8', '9', '10'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 8,
      subjectId: 1,
      questionText: 'Hasil dari 6 + 2 = ?',
      options: ['6', '8', '7', '9'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 9,
      subjectId: 1,
      questionText: 'Hasil dari 5 × 5 = ?',
      options: ['10', '15', '25', '20'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 10,
      subjectId: 1,
      questionText: 'Hasil dari 100 - 25 = ?',
      options: ['75', '65', '85', '90'],
      correctAnswerIndex: 0,
    ),
  ];
}
