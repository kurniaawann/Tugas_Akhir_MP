class QuizSubject {
  final int id;
  final String name;
  final String icon;

  QuizSubject({required this.id, required this.name, required this.icon});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'icon': icon};
  }
}
