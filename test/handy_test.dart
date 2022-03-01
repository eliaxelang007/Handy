import 'dart:async';

import 'package:handy/handy.dart';
import 'package:test/test.dart';

enum _TestEnum { helloWorld }

void main() {
  group("class $Range", () {
    Range<int> oneTen = Range<int>(1, 10);

    int greater = 11;
    double lesser = 0.743;

    int wholeBetween = 3;
    double decimalBetween = 7.333;

    test(".clamp(...)", () {
      expect(oneTen.clamp(greater) == oneTen.most, true);
      expect(oneTen.clamp(lesser) == oneTen.least, true);
      expect(oneTen.clamp(wholeBetween) == wholeBetween, true);
      expect(oneTen.clamp(decimalBetween) == decimalBetween, true);
    });

    test(".call(...)", () {
      expect(oneTen(greater), false);
      expect(oneTen(lesser), false);
      expect(oneTen(wholeBetween), true);
      expect(oneTen(decimalBetween), true);
    });
  });

  group("extension HandyEnum", () {
    test(".toShortString(...)", () {
      expect(_TestEnum.helloWorld.toShortString() == "helloWorld", true);
    });
  });

  group("extension RandomRange", () {
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

  group("class $Cleaner", () {
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

  group("extension HandyDateTime", () {
    DateTime testTime = DateTime.parse("2022-02-23 07:04:24.190");

    test(".truncate(...)", () {
      DateTime truncated = testTime.truncate();

      truncated.isAtSameMomentAs(DateTime(0));
    });

    test(".rightTruncate(...)", () {
      DateTime truncated = testTime.rightTruncate(TimePrecision.hour);

      expect(
          truncated.isAtSameMomentAs(
              DateTime(testTime.year, testTime.month, testTime.day)),
          true);
    });

    test(".leftTruncate(...)", () {
      DateTime truncated = testTime.leftTruncate(TimePrecision.minute);

      expect(
          truncated ==
              DateTime(0, 1, 1, 0, testTime.minute, testTime.second,
                  testTime.millisecond, testTime.microsecond),
          true);
    });

    test(".copyWith(...)", () {
      int twosYear = 2222;
      DateTime modified = testTime.copyWith(year: twosYear);

      expect(
          modified ==
              DateTime(
                  twosYear,
                  testTime.month,
                  testTime.day,
                  testTime.hour,
                  testTime.minute,
                  testTime.second,
                  testTime.millisecond,
                  testTime.microsecond),
          true);
    });

    test(".value(...)", () {
      expect(testTime.year == testTime.value(TimePrecision.year), true);
      expect(testTime.month == testTime.value(TimePrecision.month), true);
      expect(testTime.day == testTime.value(TimePrecision.day), true);
      expect(testTime.hour == testTime.value(TimePrecision.hour), true);
      expect(testTime.minute == testTime.value(TimePrecision.minute), true);
      expect(testTime.second == testTime.value(TimePrecision.second), true);
      expect(testTime.millisecond == testTime.value(TimePrecision.millisecond),
          true);
      expect(testTime.microsecond == testTime.value(TimePrecision.microsecond),
          true);
    });

    test(".timeTillNext(...)", () {
      DateTime nextMonth = DateTime(testTime.year, testTime.month + 1);

      expect(
          testTime.timeTillNext(TimePrecision.month) ==
              nextMonth.difference(testTime),
          true);
    });

    test(".timeFromLast(...)", () {
      DateTime lastMonth = DateTime(testTime.year, testTime.month - 1);

      expect(
          testTime.timeFromLast(TimePrecision.month) ==
              testTime.difference(lastMonth),
          true);
    });

    DateTime before = testTime.subtract(const Duration(milliseconds: 1024));
    DateTime after = testTime.add(const Duration(milliseconds: 1024));

    test("operator <(other)", () {
      expect(before < testTime, true);
      expect(testTime < testTime, false);
      expect(after < testTime, false);
    });

    test("operator >(other)", () {
      expect(after > testTime, true);
      expect(testTime > testTime, false);
      expect(before > testTime, false);
    });

    test("operator <=(other)", () {
      expect(before <= testTime, true);
      expect(testTime <= testTime, true);
      expect(after <= testTime, false);
    });

    test("operator >=(other)", () {
      expect(after >= testTime, true);
      expect(testTime >= testTime, true);
      expect(before >= testTime, false);
    });
  });
}
