import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tugas_akhir/sample/all_sample_.dart';

// import 'package:tugas_akhir/sample/metematika.dart';

import '../models/question.dart';
import '../models/quiz_subject.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quiz_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE subjects (
        id INTEGER PRIMARY KEY,
        name TEXT,
      )
    ''');

    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY,
        subjectId INTEGER,
        questionText TEXT,
        options TEXT,
        correctAnswerIndex INTEGER,
        FOREIGN KEY (subjectId) REFERENCES subjects (id)
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  Future _insertSampleData(Database db) async {
    // Insert subjects
    final subjects = [
      QuizSubject(id: 1, name: 'Matematika'),
      QuizSubject(id: 2, name: 'Bahasa Indonesia'),
      QuizSubject(id: 3, name: 'IPA'),
    ];

    for (var subject in subjects) {
      await db.insert('subjects', subject.toMap());
    }

    // Insert questions for Matematika
    final quizMatematika = sampeQuizMatematika();

    for (var question in quizMatematika) {
      await db.insert('questions', question.toMap());
    }
  }

  Future<List<QuizSubject>> getAllSubjects() async {
    final db = await instance.database;
    final maps = await db.query('subjects');
    return List.generate(maps.length, (i) {
      return QuizSubject(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] as String,
      );
    });
  }

  Future<List<Question>> getQuestionsBySubject(int subjectId) async {
    final db = await instance.database;
    final maps = await db.query(
      'questions',
      where: 'subjectId = ?',
      whereArgs: [subjectId],
    );

    return List.generate(maps.length, (i) {
      return Question(
        id: maps[i]['id'] as int,
        subjectId: maps[i]['subjectId'] as int,
        questionText: maps[i]['questionText'] as String,
        options: (maps[i]['options'] as String).split('|'),
        correctAnswerIndex: maps[i]['correctAnswerIndex'] as int,
      );
    });
  }
}
