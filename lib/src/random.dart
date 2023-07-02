import 'dart:math';

import 'range.dart';

final Random _random = Random();

/// Gives functionality for generating random integers within an integer range.
extension RangeInt on Range<int> {
  /// Returns a random integer in the inclusive range of [least] and [most].
  int random() {
    return _random.nextInt(most + 1 - least) + least;
  }
}

/// Gives functionality for generating random floating point numbers within any range.
extension RangeExtension<T extends num> on Range<T> {
  /// Returns a random double in the inclusive range of [least] and [most]. Change the [precision] to get numbers with more decimal digits.
  double randomDouble({int precision = 1217 /* Some random prime number */}) {
    Range<int> generator = Range<int>(0, precision);

    return least + ((most - least) * (generator.random() / generator.most));
  }
}

/// Returns a random true or false value.
bool randomBool() => _random.nextBool();
