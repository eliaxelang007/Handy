extension HandyEnum on Enum {
  String toShortString() {
    return toString().split('.').last;
  }
}
