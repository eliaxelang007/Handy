This package is a collection of otherwise unrelated utilities that proved
to be helpful to while creating Dart programs and Flutter apps.

## Features

Among the utilities implemented as of now, here are some of the notable ones:

* Get the name of the enum without the preceding enum type name.
* Added string utility methods like [toTitleCase] and [capitalize].
* A cleaner class that performs cleanup on objects that need it.
* A range class the encapsulates minimum and maximum values.
* Generate inclusive random numbers between any range.
* A Cache class that caches outputs for inputs.
* <, <=, >, >= operators on the DateTime class.
* Truncate values from a DateTime instance.

## Usage

Here's some example usage of this package.

```dart
import 'package:handy/handy.dart';

enum SampleEnum {
  hello,
  world,
  exclamationPoint
}

void main() {
  String helloWorld = "hello, world!";

  print(helloWorld * 3);           // hello, world!hello, world!hello, world!
  print(helloWorld.toTitleCase()); // Hello, World!
  print(helloWorld.capitalize());  // Hello, world!

  print(SampleEnum.exclamationPoint.toShortString()); // exclamationPoint
  print(SampleEnum.world.toShortString());            // world

  Range<int> oneTen = Range<int>(1, 10);

  DateTime now = DateTime.now(); // 2022-03-02 12:01:24.684

  print(now.rightTruncate(TimePrecision.hour)); // 2022-03-02 00:00:00.000

  print(oneTen.random());       // *3
  print(oneTen.randomDouble()); // *7.633

  print(oneTen.clamp(0.9)); // 1
  print(oneTen.clamp(100)); // 10
}
```