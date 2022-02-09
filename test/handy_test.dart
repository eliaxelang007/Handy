import 'dart:async';

import 'package:handy/handy.dart';
import 'package:test/test.dart';

enum _TestEnum { helloWorld }

void main() {
  group("Testing for the $Range class:", () {
    Range<int> oneTen = Range<int>(1, 10);

    int greater = 11;
    double lesser = 0.743;

    int wholeBetween = 3;
    double decimalbetween = 7.333;

    test(".clamp(...)", () {
      expect(oneTen.clamp(greater) == oneTen.most, true);
      expect(oneTen.clamp(lesser) == oneTen.least, true);
      expect(oneTen.clamp(wholeBetween) == wholeBetween, true);
      expect(oneTen.clamp(decimalbetween) == decimalbetween, true);
    });

    test(".call(...)", () {
      expect(oneTen(greater), false);
      expect(oneTen(lesser), false);
      expect(oneTen(wholeBetween), true);
      expect(oneTen(decimalbetween), true);
    });
  });

  group("Testing for the HandyEnum extension:", () {
    test(".toShortString(...)", () {
      expect(_TestEnum.helloWorld.toShortString() == "helloWorld", true);
    });
  });

  group("Testing for the random functions:", () {
    Range<int> oneTen = Range<int>(1, 10);

    test(".random(...)", () {
      for (int i = 0; i < 20; i++) {
        expect(oneTen(oneTen.random()), true);
      }
    });

    test(".randomDouble(...)", () {
      for (int i = 0; i < 20; i++) {
        expect(oneTen(oneTen.randomDouble()), true);
      }
    });

    test("randomBool(...)", () {
      for (int i = 0; i < 20; i++) {
        expect(randomBool().runtimeType == bool, true);
      }
    });
  });

  group("Testing for the $Cleaner class", () {
    Cleaner<Timer> streamCleaner = Cleaner<Timer>((Timer used) {
      used.cancel();
    });

    const Duration interval = Duration(milliseconds: 500);

    Timer clock = Timer.periodic(interval, (timer) {
      print("Clock: ${timer.tick}");
    });

    Timer grandfatherClock = Timer.periodic(interval, (timer) {
      print("Grandfather Clock: ${timer.tick}");
    });

    test(".add(...)", () {
      streamCleaner.add(clock);
      streamCleaner.add(grandfatherClock);

      expect(clock.isActive && grandfatherClock.isActive, true);
    });

    test(".remove(...)", () {
      streamCleaner.remove(grandfatherClock);
      grandfatherClock.cancel();

      expect(clock.isActive && !grandfatherClock.isActive, true);
    });

    test(".cleanup(...)", () {
      streamCleaner.cleanup();
      expect(!clock.isActive && !grandfatherClock.isActive, true);
    });
  });
}
