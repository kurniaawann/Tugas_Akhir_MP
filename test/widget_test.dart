import 'package:flutter_test/flutter_test.dart';

class Calculator {
  int add(int a, int b) {
    return a + b;
  }

  int subtract(int a, int b) {
    return a - b;
  }
}

void main() {
  group('Calculator Test', () {
    final calculator = Calculator();

    test('Penjumlahan dua angka', () {
      expect(calculator.add(3, 5), 8);
    });

    test('Pengurangan dua angka', () {
      expect(calculator.subtract(10, 4), 6);
    });
  });
}
