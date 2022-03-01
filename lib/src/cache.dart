/// Stores a map of inputs and outputs.
class Cache<I, O, C> {
  final Map<C, O> _cache = {};
  final O Function(I) _generator;
  final C Function(I) _sanitizer;

  Cache(this._generator, {required C Function(I) sanitizer})
      : _sanitizer = sanitizer;

  /// If the sanitized [input] is in the cache, it will return the corresponding output. If it isn't, it will calculate the appropriate output and then cache it.
  O call(I input) {
    C sanitized = _sanitizer(input);

    O? cachedOutput = _cache[sanitized];

    if (cachedOutput != null) return cachedOutput;

    return _recalculate(input, sanitized);
  }

  O _recalculate(I input, C sanitized) {
    O result = _generator(input);

    _cache[sanitized] = result;

    return result;
  }

  /// If an output for an [input] isn't valid anymore, usually because of a state change, this method can be used to recalculate an output for a given [input].
  /// If you don't want to store the result in the cache, the better method to use would be [calculate].
  O recalculate(I input) {
    return _recalculate(input, _sanitizer(input));
  }

  /// Returns the output for a given [input] without storing it in the cache.
  O calculate(I input) => _generator(input);
}
