/// A handy extensions for enums.
extension HandyEnum on Enum {
  /// Returns the name of the enum without the preceding enum type name.
  String toShortString() {
    return toString().split('.').last;
  }
}
