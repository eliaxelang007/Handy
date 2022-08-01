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
