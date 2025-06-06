import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final int score;

  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final scorePercentage = (score / 10) * 100;
    final isExcellent = scorePercentage >= 80;
    final isGood = scorePercentage >= 60;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Trophy or Emoji based on performance
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    isExcellent
                        ? Icons.emoji_events
                        : isGood
                        ? Icons.sentiment_very_satisfied
                        : Icons.sentiment_satisfied,
                    size: 60,
                    color:
                        isExcellent
                            ? Colors.amber
                            : isGood
                            ? Colors.green
                            : Colors.orange,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title with celebration effect
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Hasil Kuis',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      foreground:
                          Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.white,
                    ),
                  ),
                  Text(
                    'Hasil Kuis',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Performance message
              Text(
                isExcellent
                    ? 'Luar Biasa!'
                    : isGood
                    ? 'Kerja Bagus!'
                    : 'Tetap Semangat!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.purple.shade700,
                ),
              ),
              const SizedBox(height: 32),

              // Score display
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Skor Kamu',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$score/10',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: score / 10,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isExcellent
                            ? Colors.green
                            : isGood
                            ? Colors.blue
                            : Colors.orange,
                      ),
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Results cards in a row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildResultCard(
                    'Benar',
                    correctAnswers,
                    Colors.green.shade400,
                    Icons.check_circle,
                  ),
                  _buildResultCard(
                    'Salah',
                    wrongAnswers,
                    Colors.red.shade400,
                    Icons.cancel,
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Home button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.blue.shade800,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Kembali ke Beranda',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(String title, int count, Color color, IconData icon) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
