import 'dart:math';

import 'package:duration_spinbox/src/enums.dart';
import 'package:duration_spinbox/src/spinbox_button.dart';
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
    this.min = Duration.zero,
    this.max,
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

  /// Determines the minimum value for the duration represented by this
  /// widget. 
  /// If in any step triggered by one of the buttons is less than this value
  /// the new value will be set to the [min].
  /// 
  /// Default value set to [Duration.zero] to avoid negative duration value,
  /// if you want to allow negative duration values set min to null.
  final Duration? min;

  /// Determines the maximum value for the duration represented by this
  /// widget. 
  /// If in any step triggered by one of the buttons is more than this value
  /// the new value will be set to [max].
  final Duration? max;

  @override
  State<DurationSpinbox> createState() => _DurationSpinboxState();
}

class _DurationSpinboxState extends State<DurationSpinbox> {
  int _minutes = 0;
  int _seconds = 0;
  bool _incDisabled = false;
  bool _decDisabled = false;

  @override
  void initState() {
    super.initState();
    final minD = widget.min;
    final maxD = widget.max;
    if (minD != null && maxD != null){
      if (maxD < minD) throw ArgumentError('max is less than min');
    }
    _minutes = widget.value.inSeconds ~/ 60;
    _seconds = widget.value.inSeconds % 60;
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SpinboxButton(
          onPressed: _decDisabled ? null : () {
            final newDuration = _calculateNewDuration(-widget.stepValue);
            setState(() {
              _updateValue(newDuration);
            });
          },
          icon: const Icon(Icons.remove_circle),
        ),
        Expanded(
          child: Center( 
            child: Text(_formattedDuration()),
          ),
        ),
        SpinboxButton(
          onPressed: _incDisabled ? null : () {
            final newDuration = _calculateNewDuration(widget.stepValue);
            setState(() {
              _updateValue(newDuration);
            });
          },
          icon: const Icon(Icons.add_circle),
        ),
      ],
    );
  }

  /// Calculates the new duration adding the value in the selected stepUnit.
  Duration _calculateNewDuration(int value){
    final currDuration = Duration(minutes: _minutes, seconds: _seconds);
    int millisecondsToAdd;
    switch (widget.stepUnit) {
      case StepUnit.minutes:
        millisecondsToAdd = 60000 * value;
      case StepUnit.seconds:
        millisecondsToAdd = 1000 * value;
    }
    final newMillisDuration = currDuration.inMilliseconds + millisecondsToAdd;
    return _getNewDuration(newMillisDuration);
  }

  /// Updates the state of the widget with the provided Duration value.
  /// 
  /// Also updates the state of the buttons
  void _updateValue(Duration newDuration) {
    final minD = widget.min;
    final maxD = widget.max;
    final newMillisDuration = newDuration.inMilliseconds;
    if (minD != null){
      _decDisabled = minD.inMilliseconds == newMillisDuration;
    }
    if (maxD != null){
      _incDisabled = maxD.inMilliseconds == newMillisDuration;
    }
    _minutes = newDuration.inSeconds ~/ 60;
    _seconds = newDuration.inSeconds % 60;
  }

  /// This method creates a new Duration object with the param provided as
  /// milliseconds.
  /// 
  /// This also clamp the value into the boundaries set by the min and max
  /// attributes.
  Duration _getNewDuration(int millisDuration){
    final minD = widget.min;
    final maxD = widget.max;
    var newMillisDuration = millisDuration;
    if (minD != null){
      newMillisDuration = max(minD.inMilliseconds, newMillisDuration);
    }
    if (maxD != null){
      newMillisDuration = min(maxD.inMilliseconds, newMillisDuration);
    }
    final newDuration = Duration(milliseconds: newMillisDuration);
    return newDuration;
  }

  String _formattedDuration() {
    final minuteString = _minutes.toString().padLeft(2, '0');
    final secondsString = _seconds.toString().padLeft(2, '0');
    return '$minuteString:$secondsString';
  }
}
