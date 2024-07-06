// ignore_for_file: prefer_const_constructors

import 'package:duration_spinbox/duration_spinbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const defaultIncrementButton = Icons.add_circle;
  const defaultDecrementButton = Icons.remove_circle;

  group('DurationSpinbox', () {
    test('can be instantiated', () {
      expect(DurationSpinbox(value: Duration.zero), isNotNull);
    });

    testWidgets(
      'structure',
      (widgetTester) async {
        const widget = MaterialApp(
          home: DurationSpinbox(value: Duration.zero),
        );
        await widgetTester.pumpWidget(widget);
        expect(find.byType(DurationSpinbox), findsOneWidget);
        expect(find.byType(Text), findsOneWidget);
        expect(find.byType(IconButton), findsWidgets);
        expect(find.byIcon(defaultIncrementButton), findsOneWidget);
        expect(find.byIcon(defaultDecrementButton), findsOneWidget);
      },
    );

    group('display', () {
      testWidgets(
        'displays only minutes',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(value: Duration(minutes: 1)),
          );
          await widgetTester.pumpWidget(widget);
          expect(find.text('01:00'), findsOne);
        },
      );

      testWidgets(
        'display only seconds',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(value: Duration(seconds: 1)),
          );
          await widgetTester.pumpWidget(widget);
          expect(find.text('00:01'), findsOne);
        },
      );

      testWidgets(
        'display minutes and seconds',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(value: Duration(minutes: 1, seconds: 1)),
          );
          await widgetTester.pumpWidget(widget);
          expect(find.text('01:01'), findsOne);
        },
      );

      testWidgets(
        'display overflowing seconds',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(value: Duration(seconds: 70)),
          );
          await widgetTester.pumpWidget(widget);
          expect(find.text('01:10'), findsOne);
        },
      );
    });

    group('basic actions', () {
      testWidgets(
        'increase',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 1),
              stepValue: Duration(seconds: 30),
            ),
          );
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultIncrementButton));
          await widgetTester.pump();
          expect(find.text('01:30'), findsOne);
        },
      );

      testWidgets(
        'decrease',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 1),
              stepValue: Duration(seconds: 30),
            ),
          );
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultDecrementButton));
          await widgetTester.pump();
          expect(find.text('00:30'), findsOne);
        },
      );
    });

    group('min and max', () {
      testWidgets(
        'min',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 1, seconds: 20),
              stepValue: Duration(seconds: 10),
              min: Duration(minutes: 1),
            ),
          );
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultDecrementButton));
          await widgetTester.pump();
          expect(find.text('01:10'), findsOne);
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultDecrementButton));
          await widgetTester.pump();
          expect(find.text('01:00'), findsOne);
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultDecrementButton));
          await widgetTester.pump();
          expect(find.text('01:00'), findsOne);
        },
      );

      testWidgets(
        'max',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 1),
              stepValue: Duration(seconds: 10),
              max: Duration(minutes: 1, seconds: 20),
            ),
          );
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultIncrementButton));
          await widgetTester.pump();
          expect(find.text('01:10'), findsOne);
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultIncrementButton));
          await widgetTester.pump();
          expect(find.text('01:20'), findsOne);
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultIncrementButton));
          await widgetTester.pump();
          expect(find.text('01:20'), findsOne);
        },
      );

      testWidgets(
        'min disabled button',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 1),
              stepValue: Duration(seconds: 10),
              min: Duration(minutes: 1),
            ),
          );
          await widgetTester.pumpWidget(widget);
          final finder = find.ancestor(
            of: find.byIcon(defaultDecrementButton),
            matching: find.byType(IconButton),
          );
          expect(widgetTester.widget<IconButton>(finder).onPressed, isNull);
        },
      );

      testWidgets(
        'max disabled button',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 1),
              stepValue: Duration(seconds: 10),
              max: Duration(minutes: 1),
            ),
          );
          await widgetTester.pumpWidget(widget);
          final finder = find.ancestor(
            of: find.byIcon(defaultIncrementButton),
            matching: find.byType(IconButton),
          );
          expect(widgetTester.widget<IconButton>(finder).onPressed, isNull);
        },
      );

      testWidgets(
        'if value is less than min, it should throw an exception',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 1),
              stepValue: Duration(seconds: 10),
              min: Duration(minutes: 2),
            ),
          );
          await widgetTester.pumpWidget(widget);
          expect(widgetTester.takeException(), isA<ArgumentError>());
        },
      );

      testWidgets(
        'if value is greater than max, it should throw an exception',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 3),
              stepValue: Duration(seconds: 10),
              max: Duration(minutes: 2),
            ),
          );
          await widgetTester.pumpWidget(widget);
          expect(widgetTester.takeException(), isA<ArgumentError>());
        },
      );

      testWidgets(
        'if max is less than min, it should throw an exception',
        (widgetTester) async {
          const widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 2),
              stepValue: Duration(seconds: 10),
              min: Duration(minutes: 2),
              max: Duration(minutes: 1),
            ),
          );
          await widgetTester.pumpWidget(widget);
          expect(widgetTester.takeException(), isA<ArgumentError>());
        },
      );

    });

    group('onChanged callback', () {
      testWidgets(
        'if onChanged is not null, should be called when pressing the '
        'increment button',
        (widgetTester) async {
          var a = 0;
          final widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 1),
              onChanged: (value) {
                a = 1;
              },
            ),
          );
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultIncrementButton));
          await widgetTester.pump();
          expect(a, equals(1));
        },
      );

      testWidgets(
        'if onChanged is not null, should be called when pressing the '
        'decrement button',
        (widgetTester) async {
          var a = 0;
          final widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 1),
              onChanged: (value) {
                a = 1;
              },
            ),
          );
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultDecrementButton));
          await widgetTester.pump();
          expect(a, equals(1));
        },
      );

      testWidgets(
        'if onChanged is not null, when the decrement button is pressed '
        'the value in the callback should be decreased by the stepValue',
        (widgetTester) async {
          Duration? a;
          final widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 2),
              stepValue: Duration(minutes: 1),
              onChanged: (value) {
                a = value;
              },
            ),
          );
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultDecrementButton));
          await widgetTester.pump();
          expect(a, equals(Duration(minutes: 1)));
        },
      );

      testWidgets(
        'if onChanged is not null, when the increment button is pressed '
        'the value in the callback should be increased by the stepValue',
        (widgetTester) async {
          Duration? a;
          final widget = MaterialApp(
            home: DurationSpinbox(
              value: Duration(minutes: 2),
              stepValue: Duration(minutes: 1),
              onChanged: (value) {
                a = value;
              },
            ),
          );
          await widgetTester.pumpWidget(widget);
          await widgetTester.tap(find.byIcon(defaultIncrementButton));
          await widgetTester.pump();
          expect(a, equals(Duration(minutes: 3)));
        },
      );
    },);
  });
}
