import 'package:duration_spinbox/src/duration_spinbox.dart';

/// Format to display in the [DurationSpinbox] label
/// 
/// The logic for this formats is the following:
/// - All the double letters represent the unit capped by
/// their maximum value. E.g. For 68 minutes, if the mmss
/// format is selected then the result will be 08:00, 
/// because the extra 60 minutes make an hour.
/// - The triple letter represent the unit without the cap,
/// meaning the 68 minutes with the format mmmss will
/// result in 68:00.
enum DurationFormat{

  /// Seconds and milliseconds. E.g:
  /// 
  /// ```dart
  /// Duration(milliseconds: 1);      
  /// // 00.001
  /// Duration(milliseconds: 1, seconds: 10);
  /// // 10.001
  /// Duration(seconds: 40);
  /// // 40.000
  /// Duration(seconds: 89, milliseconds: 999);
  /// // 29.999
  /// ```
  ssll,
  ///
  mmss,
  ///
  mmssll,
  ///
  hhmm,
  ///
  hhmmss,
  ///
  hhmmssll,
  ///
  ddhh,
  ///
  ddhhmm,
  ///
  ddhhmmss,
  ///
  ddhhmmssll,

  ///
  sssll,
  ///
  mmmss,
  ///
  mmmssll,
  ///
  hhhmm,
  ///
  hhhmmss,
  ///
  hhhmmssll,

}
