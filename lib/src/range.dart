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
