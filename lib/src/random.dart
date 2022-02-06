import 'dart:math';

import 'range.dart';

final Random _random = Random();

extension RangeInt on Range<int> {
  int random() {
    return _random.nextInt(most + 1 - least) + least;
  }
}

extension RangeExtension<T extends num> on Range<T> {
  double randomDouble({int precision = 1000}) {
    Range<int> generator = Range<int>(0, precision);

    return least + ((most - least) * (generator.random() / generator.most));
  }
}

bool randomBool() => _random.nextBool();
