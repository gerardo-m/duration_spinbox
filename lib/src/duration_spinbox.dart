import 'package:flutter/material.dart';

/// {@template duration_spinbox}
/// A duration widget for Flutter, heavily inspired by flutter_spinbox
/// {@endtemplate}
/// 
/// 
class DurationSpinbox extends StatefulWidget {

  /// {@macro duration_spinbox}
  const DurationSpinbox({required this.value, super.key});

  /// The duration value represented by this widget
  final Duration value;

  @override
  State<DurationSpinbox> createState() => _DurationSpinboxState();
}

class _DurationSpinboxState extends State<DurationSpinbox> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        IconButton(onPressed: null, icon: Icon(Icons.remove)),
        Expanded(child: Center(child: Text('Test'))),
        IconButton(onPressed: null, icon: Icon(Icons.add)),
      ],
    );
  }
}
