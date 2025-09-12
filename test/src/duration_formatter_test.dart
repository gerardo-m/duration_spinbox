// ignore_for_file: prefer_const_constructors

import 'package:duration_spinbox/duration_spinbox.dart';
import 'package:duration_spinbox/src/duration_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DurationFormatter', () {
    group('format method', () {
      test('formats mmss correctly', () {
        final duration = Duration(minutes: 5, seconds: 30);
        final result = DurationFormatter.format(duration, DurationFormat.mmss);
        expect(result, equals('05:30'));
      });

      test('formats mmss with overflow seconds', () {
        final duration = Duration(seconds: 90);
        final result = DurationFormatter.format(duration, DurationFormat.mmss);
        expect(result, equals('01:30'));
      });

      test('formats hhmmss correctly', () {
        final duration = Duration(hours: 2, minutes: 15, seconds: 45);
        final result =
            DurationFormatter.format(duration, DurationFormat.hhmmss);
        expect(result, equals('02:15:45'));
      });

      test('formats hhmmss with overflow', () {
        final duration = Duration(hours: 1, minutes: 65, seconds: 70);
        final result =
            DurationFormatter.format(duration, DurationFormat.hhmmss);
        expect(result, equals('02:06:10'));
      });

      test('formats mmssll correctly', () {
        final duration = Duration(minutes: 3, seconds: 25, milliseconds: 500);
        final result =
            DurationFormatter.format(duration, DurationFormat.mmssll);
        expect(result, equals('03:25.500'));
      });

      test('formats mmssll with overflow', () {
        final duration = Duration(seconds: 125, milliseconds: 123);
        final result =
            DurationFormatter.format(duration, DurationFormat.mmssll);
        expect(result, equals('02:05.123'));
      });

      test('formats ssll correctly', () {
        final duration = Duration(seconds: 45, milliseconds: 250);
        final result = DurationFormatter.format(duration, DurationFormat.ssll);
        expect(result, equals('45.250'));
      });

      test('formats ssll with overflow seconds', () {
        final duration = Duration(seconds: 75, milliseconds: 999);
        final result = DurationFormatter.format(duration, DurationFormat.ssll);
        expect(result, equals('15.999'));
      });

      test('formats hhmm correctly', () {
        final duration = Duration(hours: 4, minutes: 20);
        final result = DurationFormatter.format(duration, DurationFormat.hhmm);
        expect(result, equals('04:20'));
      });

      test('formats hhmm with overflow', () {
        final duration = Duration(hours: 2, minutes: 75);
        final result = DurationFormatter.format(duration, DurationFormat.hhmm);
        expect(result, equals('03:15'));
      });

      test('formats hhmmssll correctly', () {
        final duration =
            Duration(hours: 1, minutes: 30, seconds: 15, milliseconds: 750);
        final result =
            DurationFormatter.format(duration, DurationFormat.hhmmssll);
        expect(result, equals('01:30:15.750'));
      });

      test('formats hhmmssll with overflow', () {
        final duration = Duration(
          hours: 2,
          minutes: 75,
          seconds: 30,
          milliseconds: 500,
        );
        final result = DurationFormatter.format(
          duration,
          DurationFormat.hhmmssll,
        );
        expect(result, equals('03:15:30.500'));
      });

      test('formats ddhh correctly', () {
        final duration = Duration(days: 3, hours: 12);
        final result = DurationFormatter.format(duration, DurationFormat.ddhh);
        expect(result, equals('3d12'));
      });

      test('formats ddhhmm correctly', () {
        final duration = Duration(days: 2, hours: 8, minutes: 45);
        final result =
            DurationFormatter.format(duration, DurationFormat.ddhhmm);
        expect(result, equals('2d08:45'));
      });

      test('formats ddhhmmss correctly', () {
        final duration = Duration(days: 1, hours: 6, minutes: 30, seconds: 20);
        final result =
            DurationFormatter.format(duration, DurationFormat.ddhhmmss);
        expect(result, equals('1d06:30:20'));
      });

      test('formats ddhhmmssll correctly', () {
        final duration = Duration(
          days: 5,
          hours: 10,
          minutes: 15,
          seconds: 30,
          milliseconds: 500,
        );
        final result =
            DurationFormatter.format(duration, DurationFormat.ddhhmmssll);
        expect(result, equals('5d10:15:30.500'));
      });

      test('formats sssll correctly', () {
        final duration = Duration(seconds: 125, milliseconds: 750);
        final result = DurationFormatter.format(duration, DurationFormat.sssll);
        expect(result, equals('125.750'));
      });

      test('formats mmmss correctly', () {
        final duration = Duration(minutes: 90, seconds: 30);
        final result = DurationFormatter.format(duration, DurationFormat.mmmss);
        expect(result, equals('90:30'));
      });

      test('formats mmmssll correctly', () {
        final duration = Duration(minutes: 120, seconds: 45, milliseconds: 250);
        final result =
            DurationFormatter.format(duration, DurationFormat.mmmssll);
        expect(result, equals('120:45.250'));
      });

      test('formats hhhmm correctly', () {
        final duration = Duration(hours: 25, minutes: 30);
        final result = DurationFormatter.format(duration, DurationFormat.hhhmm);
        expect(result, equals('25:30'));
      });

      test('formats hhhmmss correctly', () {
        final duration = Duration(hours: 48, minutes: 15, seconds: 45);
        final result =
            DurationFormatter.format(duration, DurationFormat.hhhmmss);
        expect(result, equals('48:15:45'));
      });

      test('formats hhhmmssll correctly', () {
        final duration =
            Duration(hours: 72, minutes: 30, seconds: 20, milliseconds: 100);
        final result =
            DurationFormatter.format(duration, DurationFormat.hhhmmssll);
        expect(result, equals('72:30:20.100'));
      });
    });

    group('individual format methods', () {
      test('ll method formats milliseconds correctly', () {
        final duration = Duration(milliseconds: 1234);
        final result = DurationFormatter.ll(duration);
        expect(result, equals('234'));
      });

      test('ll method pads with zeros', () {
        final duration = Duration(milliseconds: 5);
        final result = DurationFormatter.ll(duration);
        expect(result, equals('005'));
      });

      test('ss method formats seconds correctly', () {
        final duration = Duration(seconds: 75);
        final result = DurationFormatter.ss(duration);
        expect(result, equals('15'));
      });

      test('ss method pads with zeros', () {
        final duration = Duration(seconds: 5);
        final result = DurationFormatter.ss(duration);
        expect(result, equals('05'));
      });

      test('mm method formats minutes correctly', () {
        final duration = Duration(minutes: 75);
        final result = DurationFormatter.mm(duration);
        expect(result, equals('15'));
      });

      test('mm method pads with zeros', () {
        final duration = Duration(minutes: 5);
        final result = DurationFormatter.mm(duration);
        expect(result, equals('05'));
      });

      test('hh method formats hours correctly', () {
        final duration = Duration(hours: 25);
        final result = DurationFormatter.hh(duration);
        expect(result, equals('01'));
      });

      test('hh method pads with zeros', () {
        final duration = Duration(hours: 5);
        final result = DurationFormatter.hh(duration);
        expect(result, equals('05'));
      });

      test('dd method formats days correctly', () {
        final duration = Duration(days: 5);
        final result = DurationFormatter.dd(duration);
        expect(result, equals('5'));
      });

      test('sss method formats total seconds correctly', () {
        final duration = Duration(minutes: 2, seconds: 30);
        final result = DurationFormatter.sss(duration);
        expect(result, equals('150'));
      });

      test('sss method pads with zeros', () {
        final duration = Duration(seconds: 5);
        final result = DurationFormatter.sss(duration);
        expect(result, equals('05'));
      });

      test('mmm method formats total minutes correctly', () {
        final duration = Duration(hours: 2, minutes: 30);
        final result = DurationFormatter.mmm(duration);
        expect(result, equals('150'));
      });

      test('mmm method pads with zeros', () {
        final duration = Duration(minutes: 5);
        final result = DurationFormatter.mmm(duration);
        expect(result, equals('05'));
      });

      test('hhh method formats total hours correctly', () {
        final duration = Duration(days: 2, hours: 5);
        final result = DurationFormatter.hhh(duration);
        expect(result, equals('53'));
      });

      test('hhh method pads with zeros', () {
        final duration = Duration(hours: 5);
        final result = DurationFormatter.hhh(duration);
        expect(result, equals('05'));
      });
    });

    group('edge cases', () {
      test('handles zero duration', () {
        const duration = Duration.zero;
        final result = DurationFormatter.format(duration, DurationFormat.mmss);
        expect(result, equals('00:00'));
      });

      test('handles very large duration', () {
        final duration = Duration(
          days: 365,
          hours: 12,
          minutes: 30,
          seconds: 45,
          milliseconds: 500,
        );
        final result =
            DurationFormatter.format(duration, DurationFormat.ddhhmmssll);
        expect(result, equals('365d12:30:45.500'));
      });
    });
  });

  group('Widget and Formatter consistency', () {
    testWidgets(
        'widget displays same text as DurationFormatter for all formats',
        (widgetTester) async {
      final testDurations = [
        Duration.zero,
        Duration(milliseconds: 500),
        Duration(seconds: 30),
        Duration(minutes: 5, seconds: 30),
        Duration(hours: 2, minutes: 15, seconds: 45),
        Duration(hours: 1, minutes: 30, seconds: 15, milliseconds: 750),
        Duration(days: 3, hours: 12),
        Duration(days: 2, hours: 8, minutes: 45),
        Duration(days: 1, hours: 6, minutes: 30, seconds: 20),
        Duration(
          days: 5,
          hours: 10,
          minutes: 15,
          seconds: 30,
          milliseconds: 500,
        ),
        Duration(seconds: 125, milliseconds: 750),
        Duration(minutes: 90, seconds: 30),
        Duration(minutes: 120, seconds: 45, milliseconds: 250),
        Duration(hours: 25, minutes: 30),
        Duration(hours: 48, minutes: 15, seconds: 45),
        Duration(hours: 72, minutes: 30, seconds: 20, milliseconds: 100),
      ];

      for (final format in DurationFormat.values) {
        for (final duration in testDurations) {
          final formatterText = DurationFormatter.format(duration, format);

          final widget = MaterialApp(
            home: DurationSpinbox(
              value: duration,
              format: format,
            ),
          );

          await widgetTester.pumpWidget(widget);

          expect(
            find.text(formatterText),
            findsOneWidget,
            reason: 'Format $format with duration $duration '
                'should display "$formatterText"',
          );
        }
      }
    });
  });
}
