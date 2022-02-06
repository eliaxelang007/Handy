import '_tester.dart';

class Range<Number extends num> {
  final Number least;
  final Number most;

  const Range(this.least, this.most);

  static Range fromList<Element>(List<Element> list) {
    return Range(0, list.length - 1);
  }

  num clamp<Value extends num>(Value number) =>
      (number >= most) ? most : ((number <= least) ? least : number);

  bool call<Value extends num>(Value number) =>
      number <= most && number >= least;
}
