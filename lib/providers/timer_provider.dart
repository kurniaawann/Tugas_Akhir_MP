import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  int _remainingSeconds = 1800; // 30 menit
  bool _timeIsUp = false;

  int get remainingSeconds => _remainingSeconds;
  bool get timeIsUp => _timeIsUp;

  String get formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void startTimer() {
    _timeIsUp = false;
    _remainingSeconds = 1800;
    notifyListeners();
  }

  void tick() {
    if (_remainingSeconds > 0) {
      _remainingSeconds--;
      notifyListeners();
    } else {
      _timeIsUp = true;
      notifyListeners();
    }
  }
}
