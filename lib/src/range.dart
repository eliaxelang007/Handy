/// A class that encapsulates minimum and maximum values.
class Range<N extends num> {
  /// The minimum value of the [Range]
  final N least;

  /// The maximum value of the [Range]
  final N most;

  /// Creates a [Range] starting from [least] to [most].
  const Range(this.least, this.most)
      : assert(least < most, "[least] must be less than [most]");

  /// Constrains the [number] parameter to be between [least] and [most].
  num clamp<V extends num>(V number) =>
      (number >= most) ? most : ((number <= least) ? least : number);

  /// Checks if the [number] parameter is between [least] and [most].
  bool contains<V extends num>(V number) => number <= most && number >= least;
}
