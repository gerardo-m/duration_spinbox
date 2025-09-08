import 'package:duration_spinbox/src/duration_format.dart';

/// 
abstract class DurationFormatter{

  ///
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

  ///
  static String ll(Duration duration){
    return duration.inMilliseconds.remainder(1000).toString().padLeft(3, '0');
  }

  ///
  static String ss(Duration duration){
    return duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  }

  ///
  static String mm(Duration duration){
    return duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  }

  ///
  static String hh(Duration duration){
    return duration.inHours.remainder(24).toString().padLeft(2,'0');
  }

  ///
  static String dd(Duration duration){
    return duration.inDays.toString();
  }

  ///
  static String sss(Duration duration){
    return duration.inSeconds.toString().padLeft(2, '0');
  }

  ///
  static String mmm(Duration duration){
    return duration.inMinutes.toString().padLeft(2, '0');
  }

  ///
  static String hhh(Duration duration){
    return duration.inHours.toString().padLeft(2, '0');
  }

}
