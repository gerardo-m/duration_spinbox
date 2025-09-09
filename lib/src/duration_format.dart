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
  /// Minutes and seconds. E.g:
  /// 
  /// ```dart
  /// Duration(minutes: 1);      
  /// // 01:00
  /// Duration(minutes: 1, seconds: 30);
  /// // 01:30
  /// Duration(minutes: 5);
  /// // 05:00
  /// Duration(minutes: 68, seconds: 30);
  /// // 08:30 (68 minutes = 1h 8m, capped at 59:59)
  /// ```
  mmss,
  /// Minutes, seconds and milliseconds. E.g:
  /// 
  /// ```dart
  /// Duration(minutes: 1, milliseconds: 500);      
  /// // 01:00.500
  /// Duration(minutes: 1, seconds: 30, milliseconds: 250);
  /// // 01:30.250
  /// Duration(minutes: 5);
  /// // 05:00.000
  /// Duration(minutes: 68, seconds: 30, milliseconds: 999);
  /// // 08:30.999 (68 minutes = 1h 8m, capped at 59:59.999)
  /// ```
  mmssll,
  /// Hours and minutes. E.g:
  /// 
  /// ```dart
  /// Duration(hours: 1);      
  /// // 01:00
  /// Duration(hours: 1, minutes: 30);
  /// // 01:30
  /// Duration(hours: 5);
  /// // 05:00
  /// Duration(hours: 25, minutes: 30);
  /// // 01:30 (25 hours = 1d 1h, capped at 23:59)
  /// ```
  hhmm,
  /// Hours, minutes and seconds. E.g:
  /// 
  /// ```dart
  /// Duration(hours: 1, seconds: 30);      
  /// // 01:00:30
  /// Duration(hours: 1, minutes: 30, seconds: 45);
  /// // 01:30:45
  /// Duration(hours: 5);
  /// // 05:00:00
  /// Duration(hours: 25, minutes: 30, seconds: 45);
  /// // 01:30:45 (25 hours = 1d 1h, capped at 23:59:59)
  /// ```
  hhmmss,
  /// Hours, minutes, seconds and milliseconds. E.g:
  /// 
  /// ```dart
  /// Duration(hours: 1, milliseconds: 500);      
  /// // 01:00:00.500
  /// Duration(hours: 1, minutes: 30, seconds: 45, milliseconds: 250);
  /// // 01:30:45.250
  /// Duration(hours: 5);
  /// // 05:00:00.000
  /// Duration(hours: 25, minutes: 30, seconds: 45, milliseconds: 999);
  /// // 01:30:45.999 (25 hours = 1d 1h, capped at 23:59:59.999)
  /// ```
  hhmmssll,
  /// Days and hours. E.g:
  /// 
  /// ```dart
  /// Duration(days: 1);      
  /// // 1d00
  /// Duration(days: 1, hours: 12);
  /// // 1d12
  /// Duration(days: 5);
  /// // 5d00
  /// Duration(days: 30, hours: 12);
  /// // 30d12 (days are not capped)
  /// ```
  ddhh,
  /// Days, hours and minutes. E.g:
  /// 
  /// ```dart
  /// Duration(days: 1, minutes: 30);      
  /// // 1d00:30
  /// Duration(days: 1, hours: 12, minutes: 45);
  /// // 1d12:45
  /// Duration(days: 5);
  /// // 5d00:00
  /// Duration(days: 30, hours: 12, minutes: 30);
  /// // 30d12:30 (days are not capped)
  /// ```
  ddhhmm,
  /// Days, hours, minutes and seconds. E.g:
  /// 
  /// ```dart
  /// Duration(days: 1, seconds: 30);      
  /// // 1d00:00:30
  /// Duration(days: 1, hours: 12, minutes: 45, seconds: 30);
  /// // 1d12:45:30
  /// Duration(days: 5);
  /// // 5d00:00:00
  /// Duration(days: 30, hours: 12, minutes: 30, seconds: 45);
  /// // 30d12:30:45 (days are not capped)
  /// ```
  ddhhmmss,
  /// Days, hours, minutes, seconds and milliseconds. E.g:
  /// 
  /// ```dart
  /// Duration(days: 1, milliseconds: 500);      
  /// // 1d00:00:00.500
  /// Duration(days: 1, hours: 12, minutes: 45, seconds: 30, milliseconds: 250);
  /// // 1d12:45:30.250
  /// Duration(days: 5);
  /// // 5d00:00:00.000
  /// Duration(days: 30, hours: 12, minutes: 30, seconds: 45, milliseconds: 999);
  /// // 30d12:30:45.999 (days are not capped)
  /// ```
  ddhhmmssll,

  /// Seconds and milliseconds (uncapped). E.g:
  /// 
  /// ```dart
  /// Duration(milliseconds: 1);      
  /// // 00.001
  /// Duration(milliseconds: 1, seconds: 10);
  /// // 10.001
  /// Duration(seconds: 40);
  /// // 40.000
  /// Duration(seconds: 89, milliseconds: 999);
  /// // 89.999 (uncapped, shows full 89 seconds)
  /// ```
  sssll,
  /// Minutes and seconds (uncapped). E.g:
  /// 
  /// ```dart
  /// Duration(minutes: 1);      
  /// // 01:00
  /// Duration(minutes: 1, seconds: 30);
  /// // 01:30
  /// Duration(minutes: 5);
  /// // 05:00
  /// Duration(minutes: 68, seconds: 30);
  /// // 68:30 (uncapped, shows full 68 minutes)
  /// ```
  mmmss,
  /// Minutes, seconds and milliseconds (uncapped). E.g:
  /// 
  /// ```dart
  /// Duration(minutes: 1, milliseconds: 500);      
  /// // 01:00.500
  /// Duration(minutes: 1, seconds: 30, milliseconds: 250);
  /// // 01:30.250
  /// Duration(minutes: 5);
  /// // 05:00.000
  /// Duration(minutes: 68, seconds: 30, milliseconds: 999);
  /// // 68:30.999 (uncapped, shows full 68 minutes)
  /// ```
  mmmssll,
  /// Hours and minutes (uncapped). E.g:
  /// 
  /// ```dart
  /// Duration(hours: 1);      
  /// // 01:00
  /// Duration(hours: 1, minutes: 30);
  /// // 01:30
  /// Duration(hours: 5);
  /// // 05:00
  /// Duration(hours: 25, minutes: 30);
  /// // 25:30 (uncapped, shows full 25 hours)
  /// ```
  hhhmm,
  /// Hours, minutes and seconds (uncapped). E.g:
  /// 
  /// ```dart
  /// Duration(hours: 1, seconds: 30);      
  /// // 01:00:30
  /// Duration(hours: 1, minutes: 30, seconds: 45);
  /// // 01:30:45
  /// Duration(hours: 5);
  /// // 05:00:00
  /// Duration(hours: 25, minutes: 30, seconds: 45);
  /// // 25:30:45 (uncapped, shows full 25 hours)
  /// ```
  hhhmmss,
  /// Hours, minutes, seconds and milliseconds (uncapped). E.g:
  /// 
  /// ```dart
  /// Duration(hours: 1, milliseconds: 500);      
  /// // 01:00:00.500
  /// Duration(hours: 1, minutes: 30, seconds: 45, milliseconds: 250);
  /// // 01:30:45.250
  /// Duration(hours: 5);
  /// // 05:00:00.000
  /// Duration(hours: 25, minutes: 30, seconds: 45, milliseconds: 999);
  /// // 25:30:45.999 (uncapped, shows full 25 hours)
  /// ```
  hhhmmssll,

}
