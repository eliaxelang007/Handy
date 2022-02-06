import 'package:handy/handy.dart';

enum TestEnum {
  grouping,
  singleTest,
}

void main() {
  print(TestEnum.grouping.toShortString());

  Range<int> oneTen = Range<int>(1, 10);

  print(oneTen.random());
  print(oneTen.randomDouble());

  print(oneTen.clamp(0.9));
  print(oneTen.clamp(100));

  print(randomBool());
}
