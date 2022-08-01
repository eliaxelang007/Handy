extension HandyList<T> on List<T> {
  /// Returns a new iterable where new elements are inserted between the elements of the current list.
  /// Example: [0, 2, 4, 6, 8, 10].inBetween((index) => index) == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /// If you set [outer] to true, it will add an element at the beginning and end of the list too.
  /// Example: [1, 3, 5, 7, 9].inBetween((index) => index, outer: true) == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  Iterable<T> inBetween(T Function(int index) between, {bool outer = false}) sync* {
    var offset = 0;

    if (outer) {
      yield between(0);
      offset++;
    }

    final lastIndex = length - 1;

    for (var i = 0; i < lastIndex; i++) {
      yield this[i];
      yield between((i * 2) + 1 + offset);
    }

    yield this[lastIndex];

    if (outer) yield between((length * 2) - (1 - offset));
  }
}
