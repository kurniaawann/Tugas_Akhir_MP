class QuizSubject {
  final int id;
  final String name;

  QuizSubject({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
