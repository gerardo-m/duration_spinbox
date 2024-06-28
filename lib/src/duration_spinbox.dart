import 'package:duration_spinbox/src/enums.dart';
import 'package:flutter/material.dart';

/// {@template duration_spinbox}
/// A duration widget for Flutter, heavily inspired by flutter_spinbox
/// {@endtemplate}
///
///
class DurationSpinbox extends StatefulWidget {
  /// {@macro duration_spinbox}
  const DurationSpinbox({
    required this.value,
    this.stepUnit = StepUnit.seconds,
    this.stepValue = 1,
    super.key,
  });

  /// The duration value represented by this widget
  final Duration value;

  /// Determines the unit that the duration represented by this widget
  /// will be increased or decreased when using the increase or decrease
  /// button
  final StepUnit stepUnit;

  /// Determines how many units (determined by stepUnit) the duration
  /// represented by this widget will be increased or decreased when
  /// using the increase or decrease button
  final int stepValue;

  @override
  State<DurationSpinbox> createState() => _DurationSpinboxState();
}

class _DurationSpinboxState extends State<DurationSpinbox> {
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _minutes = widget.value.inSeconds ~/ 60;
    _seconds = widget.value.inSeconds % 60;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: (){
            setState(() {
              _updateValue(-widget.stepValue);
            });
          },
          icon: const Icon(Icons.remove),
        ),
        Expanded(
          child: Center(
            child: Text(_formattedDuration()),
          ),
        ),
        IconButton(
          onPressed: (){
            setState(() {
              _updateValue(widget.stepValue);
            });
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  void _updateValue(int value){
    final currDuration = Duration(minutes: _minutes, seconds: _seconds);
    int millisecondsToAdd;
    switch (widget.stepUnit) {
      case StepUnit.minutes:
        millisecondsToAdd = 60000 * value;
      case StepUnit.seconds:
        millisecondsToAdd = 1000 * value;
    }
    final newMillisDuration = currDuration.inMilliseconds + millisecondsToAdd;
    final newDuration = Duration(milliseconds: newMillisDuration);
    _minutes = newDuration.inSeconds ~/ 60;
    _seconds = newDuration.inSeconds % 60;
  }

  String _formattedDuration() {
    final minuteString = _minutes.toString().padLeft(2, '0');
    final secondsString = _seconds.toString().padLeft(2, '0');
    return '$minuteString:$secondsString';
  }
}
