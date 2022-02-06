class Tester {
  static final Map<int, void Function()> _tests = {};

  void test() {
    for (Function test in _tests.values) {
      test();
    }
  }

  void register(void Function() test) {
    _tests[test.hashCode] = test;
  }

  void deregister(void Function() test) {
    _tests.remove(test.hashCode);
  }

  Tester._();
}
