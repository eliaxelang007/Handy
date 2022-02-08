extension HandyEnum on Enum {
  /// Returns the name of the enum without the preceeding enum type name.
  String toShortString() {
    return toString().split('.').last;
  }
}
