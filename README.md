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

Here's a few example uses for this package to get you up and running!

```dart
import 'package:handy/handy.dart';

enum Temperature {
  hot
}

void main() {
  print(Temperature.hot.toShortString()); // hot
}
```

```dart
import 'package:handy/handy.dart';

void main() {
  final oneToTen = Range(1, 10);
  final outOfRange = 13;

  print(oneToTen.contains(outOfRange)); // false
  print(oneToTen.clamp(outOfRange)); // 10
  print(oneToTen.random()); // A random number between one and ten
}
```

```dart
import 'package:handy/handy.dart';

void main() {
  final title = "rayman 2: the great escape";

  print(title.toTitleCase()); // Rayman 2: The Great Escape
  print(title.capitalize()); // Rayman 2: the great escape
}
```