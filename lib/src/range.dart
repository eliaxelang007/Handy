import 'package:test/test.dart';

class Range<Number extends num> {
  /// The minimum value of the [Range]
  final Number least;

  /// The maximum value of the [Range]
  final Number most;

  /// Creates a [Range] starting from [least] to [most].
  const Range(this.least, this.most)
      : assert(least < most, "[least] must be less than [most]");

  /// Creates a [Range] starting from 0 to [list.length].
  static Range fromList<Element>(List<Element> list) {
    return Range(0, list.length - 1);
  }

  /// Constrains the [number] parameter to be between [least] and [most].
  num clamp<Value extends num>(Value number) =>
      (number >= most) ? most : ((number <= least) ? least : number);

  /// Checks if the [number] parameter is between [least] and [most].
  bool call<Value extends num>(Value number) =>
      number <= most && number >= least;
}

void testRange() {
  group("Testing for the $Range class:", () {
    Range<int> oneTen = Range<int>(1, 10);

    int greater = 11;
    double lesser = 0.743;

    int wholeBetween = 3;
    double decimalbetween = 7.333;

    test(".clamp(...)", () {
      expect(oneTen.clamp(greater) == oneTen.most, true);
      expect(oneTen.clamp(lesser) == oneTen.least, true);
      expect(oneTen.clamp(wholeBetween) == wholeBetween, true);
      expect(oneTen.clamp(decimalbetween) == decimalbetween, true);
    });

    test(".call(...)", () {
      expect(oneTen(greater), false);
      expect(oneTen(lesser), false);
      expect(oneTen(wholeBetween), true);
      expect(oneTen(decimalbetween), true);
    });
  });
}
