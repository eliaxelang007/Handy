import 'dart:async';

import 'package:handy/handy.dart';

enum TestEnum {
  grouping,
  singleTest,
}

void main() async {
  print(TestEnum.grouping.toShortString());

  print(DateTime.now().rightTruncate(TimePrecision.hour));

  Range<int> oneTen = Range<int>(1, 10);

  print(oneTen.random());
  print(oneTen.randomDouble());

  print(oneTen.clamp(0.9));
  print(oneTen.clamp(100));

  print(randomBool());

  Timer handle =
      Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
    print(timer.tick);
  });

  Cleaner<Timer> cleaner = Cleaner<Timer>((Timer timer) {
    timer.cancel();
  });

  cleaner.add(handle);

  Future.delayed(const Duration(seconds: 2));

  cleaner.cleanup();
}
