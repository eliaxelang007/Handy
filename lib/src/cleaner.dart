/// Stores objects that need cleanup and then cleans them when [cleanup] is called.
class Cleaner<T> {
  final Set<T> _inUse;
  final void Function(T) _cleaner;

  /// The [cleaner] you pass in will be called on all the objects you want cleaned when [cleanup] is called.
  /// The optional [inUse] parameter can be used to specify the starting objects that need to be cleaned up.
  Cleaner(void Function(T) cleaner, {Set<T>? inUse})
      : _inUse = inUse ?? {},
        _cleaner = cleaner;

  /// Stores an object in the set of objects that needs cleanup.
  /// The object will then be cleaned with [_cleaner] when [cleanup] is called.
  /// Returns true if the object wasn't in the set yet and vice versa.
  bool add(T inUse) {
    return _inUse.add(inUse);
  }

  /// Removes an object from the set of objects that need cleanup.
  /// Returns true if the object was in the set and vice versa.
  bool remove(T unused) {
    return _inUse.remove(unused);
  }

  /// Calls [_cleaner] on all the stored objects.
  void cleanup() {
    for (T used in _inUse) {
      _cleaner(used);
    }
  }
}
