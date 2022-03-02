import 'enums.dart';

/// An enum of the different units of time.
enum TimePrecision {
  year,
  month,
  day,
  hour,
  minute,
  second,
  millisecond,
  microsecond,
}

/// A handy extension for the DateTimes.
extension HandyDateTime on DateTime {
  /// Returns a new [DateTime] with all its fields set to their default value.
  /// If a parameter is set to true, it keeps its current value.
  DateTime truncate(
      {bool year = false,
      bool month = false,
      bool day = false,
      bool hour = false,
      bool minute = false,
      bool second = false,
      bool millisecond = false,
      bool microsecond = false}) {
    return DateTime(
      (year) ? this.year : 0,
      (month) ? this.month : 1,
      (day) ? this.day : 1,
      (hour) ? this.hour : 0,
      (minute) ? this.minute : 0,
      (second) ? this.second : 0,
      (millisecond) ? this.millisecond : 0,
      (microsecond) ? this.microsecond : 0,
    );
  }

  /// Returns a new [DateTime] with it's fields set to their default values starting from the smallest time unit up to the largest time unit.
  DateTime rightTruncate(TimePrecision precision) {
    return Function.apply(truncate, [], {
      for (Symbol level in TimePrecision.values
          .map((Enum value) => value.toShortString())
          .toList()
          .sublist(0, precision.index)
          .map((String level) => Symbol(level)))
        level: true
    });
  }

  /// Returns a new [DateTime] with it's fields set to their default values starting from the largest time unit up to the smallest time unit.
  DateTime leftTruncate(TimePrecision precision) {
    return Function.apply(truncate, [], {
      for (Symbol level in TimePrecision.values
          .map((Enum value) => value.toShortString())
          .toList()
          .sublist(precision.index)
          .map((String level) => Symbol(level)))
        level: true
    });
  }

  /// Returns a copy of the current [DateTime] instance. If an optional parameter is set, the new [DateTime] will have that value.
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  /// Programmatically returns the value of the given [precision].
  int value(TimePrecision precision) {
    switch (precision) {
      case TimePrecision.year:
        return year;
      case TimePrecision.month:
        return month;
      case TimePrecision.day:
        return day;
      case TimePrecision.hour:
        return hour;
      case TimePrecision.minute:
        return minute;
      case TimePrecision.second:
        return second;
      case TimePrecision.millisecond:
        return millisecond;
      case TimePrecision.microsecond:
        return microsecond;
    }
  }

  /// Returns the duration till the next [precision]
  Duration timeTillNext(TimePrecision precision) {
    DateTime truncated = rightTruncate(precision);

    var copier = truncated.copyWith;

    return Function.apply(copier, [], {
      Symbol(precision.toShortString()): value(precision) + 1
    }).difference(this);
  }

  /// Returns the duration from the last [precision]
  Duration timeFromLast(TimePrecision precision) {
    if (precision == TimePrecision.values.last) return Duration.zero;
    return difference(rightTruncate(TimePrecision.values[precision.index + 1]));
  }

  /// Returns true if the current [DateTime] instance [isBefore] the [other] instance and vice versa.
  bool operator <(DateTime other) => isBefore(other);

  /// Returns true if the current [DateTime] instance [isAfter] the [other] instance and vice versa.
  bool operator >(DateTime other) => isAfter(other);

  /// Returns true if the current [DateTime] instance [isAfter] or [isAtSameMomentAs] the [other] instance and vice versa.
  bool operator >=(DateTime other) => isAfter(other) || isAtSameMomentAs(other);

  /// Returns true if the current [DateTime] instance [isBefore] or [isAtSameMomentAs] the [other] instance and vice versa.
  bool operator <=(DateTime other) =>
      isBefore(other) || isAtSameMomentAs(other);
}
