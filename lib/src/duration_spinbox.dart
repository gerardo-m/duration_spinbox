import 'dart:math';

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
    this.stepValue = const Duration(minutes: 1),
    super.key,
    this.min = Duration.zero,
    this.max,
    this.onChanged,
  });

  /// The duration value represented by this widget
  final Duration value;

  /// Determines how much the duration represented by this widget will be
  /// increased or decreased when using the increase or decrease button.
  ///
  /// Default: Duration(minutes: 1)
  final Duration stepValue;

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

  /// Callback that is invoked right after the value is changed via the
  /// increase or decrease button
  final void Function(Duration value)? onChanged;

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
    if (minD != null && maxD != null) {
      if (maxD < minD) throw ArgumentError('max is less than min');
    }
    if (minD != null) {
      if (widget.value < minD) throw ArgumentError('value is less than min');
    }
    if (maxD != null) {
      if (widget.value > maxD) throw ArgumentError('value is greater than max');
    }
    _updateValue(widget.value);
  }

  @override
  void didUpdateWidget(covariant DurationSpinbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateValue(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SpinboxButton(
          onPressed: _decDisabled
              ? null
              : () {
                  final newDuration = _calculateNewDuration(-widget.stepValue);
                  setState(() {
                    _updateValue(newDuration);
                  });
                  widget.onChanged?.call(newDuration);
                },
          icon: const Icon(Icons.remove_circle),
        ),
        Expanded(
          child: Center(
            child: Text(_formattedDuration()),
          ),
        ),
        SpinboxButton(
          onPressed: _incDisabled
              ? null
              : () {
                  final newDuration = _calculateNewDuration(widget.stepValue);
                  setState(() {
                    _updateValue(newDuration);
                  });
                  widget.onChanged?.call(newDuration);
                },
          icon: const Icon(Icons.add_circle),
        ),
      ],
    );
  }

  /// Calculates the new duration adding the value in the selected stepUnit.
  Duration _calculateNewDuration(Duration value) {
    final curDuration = Duration(minutes: _minutes, seconds: _seconds);
    final newMillisDuration = curDuration.inMilliseconds + value.inMilliseconds;
    return _getNewDuration(newMillisDuration);
  }

  /// Updates the state of the widget with the provided Duration value.
  ///
  /// Also updates the state of the buttons
  void _updateValue(Duration newDuration) {
    final minD = widget.min;
    final maxD = widget.max;
    final newMillisDuration = newDuration.inMilliseconds;
    if (minD != null) {
      _decDisabled = minD.inMilliseconds == newMillisDuration;
    }
    if (maxD != null) {
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
  Duration _getNewDuration(int millisDuration) {
    final minD = widget.min;
    final maxD = widget.max;
    var newMillisDuration = millisDuration;
    if (minD != null) {
      newMillisDuration = max(minD.inMilliseconds, newMillisDuration);
    }
    if (maxD != null) {
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
