import 'dart:math';

import 'range.dart';

final Random _random = Random();

extension RangeInt on Range<int> {
  /// Returns a random integer in the inclusive range of [least] and [most].
  int random() {
    return _random.nextInt(most + 1 - least) + least;
  }
}

extension RangeExtension<T extends num> on Range<T> {
  /// Returns a random double in the inclusive range of [least] and [most]. Increase the [precision] to get numbers with more deciml digits.
  double randomDouble({int precision = 1000}) {
    Range<int> generator = Range<int>(0, precision);

    return least + ((most - least) * (generator.random() / generator.most));
  }
}

/// Returns a random true or false value.
bool randomBool() => _random.nextBool();
