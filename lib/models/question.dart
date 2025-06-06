class Question {
  final int? id;
  final int subjectId;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    this.id,
    required this.subjectId,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectId': subjectId,
      'questionText': questionText,
      'options': options.join('|'),
      'correctAnswerIndex': correctAnswerIndex,
    };
  }
}
