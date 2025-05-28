class UserAnswer {
  final int questionId;
  final int? selectedAnswerIndex;
  final bool isCorrect;

  UserAnswer({
    required this.questionId,
    this.selectedAnswerIndex,
    required this.isCorrect,
  });
}
