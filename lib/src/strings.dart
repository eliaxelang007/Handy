extension HandyString on String {
  /// Multiplies a string like python does.
  /// Example: "abc" * 3 == "abcabcabc"
  String operator *(int repeats) => List.filled(repeats, this).join();

  /// Capitalizes the first letter of a string and turns all other letters lowercase.
  /// Example: "abc".capitalize() == "Abc"
  String capitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  /// Centers the string using [filler] as padding.
  /// Example: "abc".center(7, "-") == "--abc--"
  String center(int width, {String filler = " "}) {
    if (width <= length) return this;

    double halfLength = (width - length) / 2;
    int leftLength = halfLength.ceil();
    int rightLength = halfLength.floor();

    return filler * leftLength + this + filler * rightLength;
  }

  /// Counts the number of times [other] appears in the string.
  /// Example: "aaabc".count('a') == 3
  int appearances(String other) => other.allMatches(this).length;

  /// Capitalizes each word in the string.
  /// Example: "rayman 2: the great escape".toTitleCase() == "Rayman 2: The Great Escape"
  String toTitleCase() => replaceAllMapped(
      RegExp(r'\b\w+\b'), (match) => match.group(0)!.capitalize());
}
