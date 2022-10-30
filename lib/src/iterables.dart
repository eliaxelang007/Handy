extension HandyList<T> on Iterable<T> {
  /// Returns a new iterable where new elements are inserted between the elements of the current iterable.
  /// Example: [0, 2, 4, 6, 8, 10].inBetween((index) => index) == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  /// If you set [outer] to true, it will add an element at the beginning and end of the list too.
  /// Example: [1, 3, 5, 7, 9].inBetween((index) => index, outer: true) == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  Iterable<T> inBetween(T Function(int index) between,
      {bool outer = false}) sync* {
    var iter = iterator;

    if (!iter.moveNext()) {
      return;
    }

    var offset = 0;

    if (outer) {
      yield between(0);
      offset++;
    }

    yield iter.current;

    var index = 1;

    while (iter.moveNext()) {
      yield between(index + offset);
      yield iter.current;
      index += 2;
    }

    if (outer) yield between(index + offset);
  }
}
