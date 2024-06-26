// ignore_for_file: prefer_const_constructors

import 'package:duration_spinbox/duration_spinbox.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DurationSpinbox', () {
    test('can be instantiated', () {
      expect(DurationSpinbox(value: Duration()), isNotNull);
    });
  });
}
