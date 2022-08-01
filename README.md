This package is a collection of otherwise unrelated utilities that proved
to be helpful to while creating Dart programs and Flutter apps.

## Features

Among the utilities implemented as of now, here are some of the notable ones:

* Added string utility methods like [toTitleCase] and [capitalize].
* A cleaner class that performs cleanup on objects that need it.
* Get the name of the enum without the preceding enum type name.
* A range class the encapsulates minimum and maximum values.
* Generate inclusive random numbers between any range.
* <, <=, >, >= operators on the DateTime class.
* A Cache class that caches outputs for inputs.
* Truncate values from a DateTime instance.

## Usage

Here's some example usage of this package.

```dart
import 'package:handy/handy.dart';

enum Heat {
  cold(Range(0, 36.66)),
  lukewarm(Range(36.67, 37.78)),
  hot(Range(37.79, 50));

  const Heat(this.celsiusRange);

  final Range<double> celsiusRange;
}

void main() {
  final title = "comments on bathwater heat".toTitleCase();
  print(title); // Comments On Bathwater Heat

  for (int i = 0; i < 4; i++) {
    final waterHeat = Range<double>(0, 50).randomDouble();

    print("The water is $waterHeat degrees celsius.");

    const cold = Heat.cold;

    if (cold.celsiusRange(waterHeat)) {
      print(cold.toShortString()); // cold
    }

    const lukewarm = Heat.lukewarm;

    if (lukewarm.celsiusRange(waterHeat)) {
      print("${lukewarm.toShortString()}...".capitalize()); // Lukewarm...
    }

    const hot = Heat.hot;

    if (hot.celsiusRange(waterHeat)) {
      print("${hot.toShortString()}! " * 3); // hot! hot! hot!
    }
  }
}
```