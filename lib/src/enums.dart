import 'package:test/test.dart';

extension HandyEnum on Enum {
  /// Returns the name of the enum without the preceeding enum type name.
  String toShortString() {
    return toString().split('.').last;
  }
}

enum _TestEnum { helloWorld }

void testEnum() {
  group("Testing for the HandyEnum extension", () {
    test(".toShortString(...)", () {
      expect(_TestEnum.helloWorld.toShortString() == "helloWorld", true);
    });
  });
}
