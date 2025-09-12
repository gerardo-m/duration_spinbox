import 'package:duration_spinbox/src/duration_format.dart';

/// Internal utility class for formatting durations according to [DurationFormat] patterns.
/// 
abstract class DurationFormatter{

  /// Formats a [Duration] according to the specified [DurationFormat].
  /// 
  /// Returns a formatted string representation of the duration using
  /// the appropriate separators and padding for the given format.
  static String format(Duration duration, DurationFormat format){
    final d = duration;
    switch (format) {
      case DurationFormat.mmss:
        return '${mm(d)}:${ss(d)}';
      case DurationFormat.hhmmss:
        return '${hh(d)}:${mm(d)}:${ss(d)}';
      case DurationFormat.mmssll:
        return '${mm(d)}:${ss(d)}.${ll(d)}';
      case DurationFormat.ssll:
        return '${ss(d)}.${ll(d)}';
      case DurationFormat.hhmm:
        return '${hh(d)}:${mm(d)}';
      case DurationFormat.hhmmssll:
        return '${hh(d)}:${mm(d)}:${ss(d)}.${ll(d)}';
      case DurationFormat.ddhh:
        return '${dd(d)}d${hh(d)}';
      case DurationFormat.ddhhmm:
        return '${dd(d)}d${hh(d)}:${mm(d)}';
      case DurationFormat.ddhhmmss:
        return '${dd(d)}d${hh(d)}:${mm(d)}:${ss(d)}';
      case DurationFormat.ddhhmmssll:
        return '${dd(d)}d${hh(d)}:${mm(d)}:${ss(d)}.${ll(d)}';
      case DurationFormat.sssll:
        return '${sss(d)}.${ll(d)}';
      case DurationFormat.mmmss:
        return '${mmm(d)}:${ss(d)}';
      case DurationFormat.mmmssll:
        return '${mmm(d)}:${ss(d)}.${ll(d)}';
      case DurationFormat.hhhmm:
        return '${hhh(d)}:${mm(d)}';
      case DurationFormat.hhhmmss:
        return '${hhh(d)}:${mm(d)}:${ss(d)}';
      case DurationFormat.hhhmmssll:
        return '${hhh(d)}:${mm(d)}:${ss(d)}.${ll(d)}';
    }
  }

  /// Returns milliseconds component (000-999) with 3-digit padding.
  static String ll(Duration duration){
    return duration.inMilliseconds.remainder(1000).toString().padLeft(3, '0');
  }

  /// Returns seconds component (00-59) with 2-digit padding.
  static String ss(Duration duration){
    return duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  }

  /// Returns minutes component (00-59) with 2-digit padding.
  static String mm(Duration duration){
    return duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  }

  /// Returns hours component (00-23) with 2-digit padding.
  static String hh(Duration duration){
    return duration.inHours.remainder(24).toString().padLeft(2,'0');
  }

  /// Returns days component without padding.
  static String dd(Duration duration){
    return duration.inDays.toString();
  }

  /// Returns total seconds (uncapped) with 2-digit padding.
  static String sss(Duration duration){
    return duration.inSeconds.toString().padLeft(2, '0');
  }

  /// Returns total minutes (uncapped) with 2-digit padding.
  static String mmm(Duration duration){
    return duration.inMinutes.toString().padLeft(2, '0');
  }

  /// Returns total hours (uncapped) with 2-digit padding.
  static String hhh(Duration duration){
    return duration.inHours.toString().padLeft(2, '0');
  }

}
