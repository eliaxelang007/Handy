import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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
      expect(oneTen.clamp(greater), equals(oneTen.most));
      expect(oneTen.clamp(lesser), equals(oneTen.least));
      expect(oneTen.clamp(wholeBetween), equals(wholeBetween));
      expect(oneTen.clamp(decimalBetween), equals(decimalBetween));
    });

    test(".call(...)", () {
      expect(oneTen.contains(greater), equals(false));
      expect(oneTen.contains(lesser), equals(false));
      expect(oneTen.contains(wholeBetween), equals(true));
      expect(oneTen.contains(decimalBetween), equals(true));
    });
  });

  group("extension HandyEnum", () {
    test(".toShortString(...)", () {
      expect(_TestEnum.helloWorld.toShortString(), equals("helloWorld"));
    });
  });

  group("extension RandomRange", () {
    Range<int> oneTen = Range<int>(1, 10);

    test(".random(...)", () {
      for (int i = 0; i < 20; i++) {
        expect(oneTen.contains(oneTen.random()), equals(true));
      }
    });

    test(".randomDouble(...)", () {
      for (int i = 0; i < 20; i++) {
        expect(oneTen.contains(oneTen.randomDouble()), equals(true));
      }
    });

    test("randomBool(...)", () {
      for (int i = 0; i < 20; i++) {
        expect(randomBool().runtimeType, equals(bool));
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

      expect(clock.isActive && grandfatherClock.isActive, equals(true));
    });

    test(".remove(...)", () {
      streamCleaner.remove(grandfatherClock);
      grandfatherClock.cancel();

      expect(clock.isActive && !grandfatherClock.isActive, equals(true));
    });

    test(".cleanup(...)", () {
      streamCleaner.cleanup();
      expect(!clock.isActive && !grandfatherClock.isActive, equals(true));
    });
  });

  group("extension HandyDateTime", () {
    DateTime testTime = DateTime.parse("2022-02-23 07:04:24.190");

    test(".truncate(...)", () {
      DateTime truncated = testTime.truncate();

      expect(truncated.isAtSameMomentAs(DateTime(0)), equals(true));
    });

    test(".rightTruncate(...)", () {
      DateTime truncated = testTime.rightTruncate(TimePrecision.hour);

      expect(
          truncated.isAtSameMomentAs(
              DateTime(testTime.year, testTime.month, testTime.day)),
          equals(true));
    });

    test(".leftTruncate(...)", () {
      DateTime truncated = testTime.leftTruncate(TimePrecision.minute);

      expect(
          truncated.isAtSameMomentAs(DateTime(0, 1, 1, 0, testTime.minute,
              testTime.second, testTime.millisecond, testTime.microsecond)),
          equals(true));
    });

    test(".copyWith(...)", () {
      int twosYear = 2222;
      DateTime modified = testTime.copyWith(year: twosYear);

      expect(
          modified.isAtSameMomentAs(DateTime(
              twosYear,
              testTime.month,
              testTime.day,
              testTime.hour,
              testTime.minute,
              testTime.second,
              testTime.millisecond,
              testTime.microsecond)),
          equals(true));
    });

    test(".value(...)", () {
      expect(testTime.year, equals(testTime.value(TimePrecision.year)));
      expect(testTime.month, equals(testTime.value(TimePrecision.month)));
      expect(testTime.day, equals(testTime.value(TimePrecision.day)));
      expect(testTime.hour, equals(testTime.value(TimePrecision.hour)));
      expect(testTime.minute, equals(testTime.value(TimePrecision.minute)));
      expect(testTime.second, equals(testTime.value(TimePrecision.second)));
      expect(testTime.millisecond,
          equals(testTime.value(TimePrecision.millisecond)));
      expect(
        testTime.microsecond,
        equals(testTime.value(TimePrecision.microsecond)),
      );
    });

    test(".timeTillNext(...)", () {
      DateTime nextMonth = DateTime(testTime.year, testTime.month + 1);

      expect(testTime.timeTillNext(TimePrecision.month),
          equals(nextMonth.difference(testTime)));
    });

    test(".timeFromLast(...)", () {
      DateTime lastMonth = DateTime(testTime.year, testTime.month);

      expect(testTime.timeFromLast(TimePrecision.month),
          equals(testTime.difference(lastMonth)));
    });

    DateTime before = testTime.subtract(const Duration(milliseconds: 1024));
    DateTime after = testTime.add(const Duration(milliseconds: 1024));

    test("operator <(other)", () {
      expect(before < testTime, equals(true));
      expect(testTime < testTime, equals(false));
      expect(after < testTime, equals(false));
    });

    test("operator >(other)", () {
      expect(after > testTime, equals(true));
      expect(testTime > testTime, equals(false));
      expect(before > testTime, equals(false));
    });

    test("operator <=(other)", () {
      expect(before <= testTime, equals(true));
      expect(testTime <= testTime, equals(true));
      expect(after <= testTime, equals(false));
    });

    test("operator >=(other)", () {
      expect(after >= testTime, equals(true));
      expect(testTime >= testTime, equals(true));
      expect(before >= testTime, equals(false));
    });
  });

  group("class $Cache", () {
    test(".call(...)", () {
      const List<String> testWords = [
        "This",
        "is",
        "a",
        "cool",
        "package,",
        "I",
        "should",
        "use",
        "it",
        "in",
        "my",
        "project!",
        ":)"
      ];

      Cache<int, int, int> crc8Cache = Cache<int, int, int>((int byte) {
        int crc = 0;

        for (int i = 0; i < 8; i++) {
          int mix = (crc ^ byte) & 0x1;

          crc >>= 1;

          if (mix != 0) crc ^= 0x8C;

          byte >>= 1;
        }

        return crc;
      }, sanitizer: (int byte) => byte & 0xff);

      int tableCrc8(Uint8List buffer) {
        int crc = 0x77;

        for (int byte in buffer) {
          crc = crc8MaximDallasTable[crc ^ byte];
        }

        return crc;
      }

      int cachedCrc8(Uint8List buffer) {
        int crc = 0x77;

        for (int byte in buffer) {
          crc = crc8Cache(crc ^ byte);
        }

        return crc;
      }

      for (String word in testWords) {
        Uint8List encodedWord = Uint8List.fromList(utf8.encode(word));

        expect(tableCrc8(encodedWord), equals(cachedCrc8(encodedWord)));
      }
    });
  });

  group("extension HandyString", () {
    String testString = "hello, world!";

    test(
        "operator *",
        () => expect(
            "hello, world!hello, world!hello, world!", equals(testString * 3)));

    test(".capitalize(...)",
        () => expect("Hello, world!", equals(testString.capitalize())));

    test(".toTitleCase(...)",
        () => expect("Hello, World!", equals(testString.toTitleCase())));

    test(".center(...)", () {
      expect(
          "----hello, world!----", equals(testString.center(21, filler: "-")));
      expect(
          "----hello, world!---", equals(testString.center(20, filler: "-")));
    });

    test(".appearances(...)",
        () => expect(testString.appearances("l"), equals(3)));
  });

  group("extension HandyIterable", () {
    test(".inBetween(...)", () {
      const expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

      expect(
          [0, 2, 4, 6, 8, 10]
              .inBetween((index) => index, outer: false)
              .toList(),
          equals(expected));
      expect([1, 3, 5, 7, 9].inBetween((index) => index, outer: true).toList(),
          equals(expected));

      expect(
          [1].inBetween((index) => index, outer: false).toList(), equals([1]));
      expect([1].inBetween((index) => index, outer: true).toList(),
          equals([0, 1, 2]));

      expect([].inBetween((index) => index, outer: false).toList(), equals([]));
      expect([].inBetween((index) => index, outer: true).toList(), equals([]));
    });
  });

  group("extension RangeIterable", () {
    test(".iter(...)", () {
      const expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      final zeroToTen = Range(0, 10);

      expect(expected, equals(zeroToTen.iter().toList()));
    });
  });
}

const List<int> crc8MaximDallasTable = [
  0x00,
  0x5e,
  0xbc,
  0xe2,
  0x61,
  0x3f,
  0xdd,
  0x83,
  0xc2,
  0x9c,
  0x7e,
  0x20,
  0xa3,
  0xfd,
  0x1f,
  0x41,
  0x9d,
  0xc3,
  0x21,
  0x7f,
  0xfc,
  0xa2,
  0x40,
  0x1e,
  0x5f,
  0x01,
  0xe3,
  0xbd,
  0x3e,
  0x60,
  0x82,
  0xdc,
  0x23,
  0x7d,
  0x9f,
  0xc1,
  0x42,
  0x1c,
  0xfe,
  0xa0,
  0xe1,
  0xbf,
  0x5d,
  0x03,
  0x80,
  0xde,
  0x3c,
  0x62,
  0xbe,
  0xe0,
  0x02,
  0x5c,
  0xdf,
  0x81,
  0x63,
  0x3d,
  0x7c,
  0x22,
  0xc0,
  0x9e,
  0x1d,
  0x43,
  0xa1,
  0xff,
  0x46,
  0x18,
  0xfa,
  0xa4,
  0x27,
  0x79,
  0x9b,
  0xc5,
  0x84,
  0xda,
  0x38,
  0x66,
  0xe5,
  0xbb,
  0x59,
  0x07,
  0xdb,
  0x85,
  0x67,
  0x39,
  0xba,
  0xe4,
  0x06,
  0x58,
  0x19,
  0x47,
  0xa5,
  0xfb,
  0x78,
  0x26,
  0xc4,
  0x9a,
  0x65,
  0x3b,
  0xd9,
  0x87,
  0x04,
  0x5a,
  0xb8,
  0xe6,
  0xa7,
  0xf9,
  0x1b,
  0x45,
  0xc6,
  0x98,
  0x7a,
  0x24,
  0xf8,
  0xa6,
  0x44,
  0x1a,
  0x99,
  0xc7,
  0x25,
  0x7b,
  0x3a,
  0x64,
  0x86,
  0xd8,
  0x5b,
  0x05,
  0xe7,
  0xb9,
  0x8c,
  0xd2,
  0x30,
  0x6e,
  0xed,
  0xb3,
  0x51,
  0x0f,
  0x4e,
  0x10,
  0xf2,
  0xac,
  0x2f,
  0x71,
  0x93,
  0xcd,
  0x11,
  0x4f,
  0xad,
  0xf3,
  0x70,
  0x2e,
  0xcc,
  0x92,
  0xd3,
  0x8d,
  0x6f,
  0x31,
  0xb2,
  0xec,
  0x0e,
  0x50,
  0xaf,
  0xf1,
  0x13,
  0x4d,
  0xce,
  0x90,
  0x72,
  0x2c,
  0x6d,
  0x33,
  0xd1,
  0x8f,
  0x0c,
  0x52,
  0xb0,
  0xee,
  0x32,
  0x6c,
  0x8e,
  0xd0,
  0x53,
  0x0d,
  0xef,
  0xb1,
  0xf0,
  0xae,
  0x4c,
  0x12,
  0x91,
  0xcf,
  0x2d,
  0x73,
  0xca,
  0x94,
  0x76,
  0x28,
  0xab,
  0xf5,
  0x17,
  0x49,
  0x08,
  0x56,
  0xb4,
  0xea,
  0x69,
  0x37,
  0xd5,
  0x8b,
  0x57,
  0x09,
  0xeb,
  0xb5,
  0x36,
  0x68,
  0x8a,
  0xd4,
  0x95,
  0xcb,
  0x29,
  0x77,
  0xf4,
  0xaa,
  0x48,
  0x16,
  0xe9,
  0xb7,
  0x55,
  0x0b,
  0x88,
  0xd6,
  0x34,
  0x6a,
  0x2b,
  0x75,
  0x97,
  0xc9,
  0x4a,
  0x14,
  0xf6,
  0xa8,
  0x74,
  0x2a,
  0xc8,
  0x96,
  0x15,
  0x4b,
  0xa9,
  0xf7,
  0xb6,
  0xe8,
  0x0a,
  0x54,
  0xd7,
  0x89,
  0x6b,
  0x35
];
