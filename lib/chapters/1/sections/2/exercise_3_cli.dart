// Instruction: Write an Interval2D client that takes command-line arguments
// N, min, and max and generates N random 2D intervals whose width and height
// are uniformly distributed between min and max in the unit square. Draw them
// on StdDraw and print the number of pairs of intervals that intersect and the
// number of intervals that are contained in one another

import 'dart:math' as math;

import 'package:algo/utils/interval_1d.dart';
import 'package:algo/utils/interval_2d.dart';

main(List<String> args) {
  if (args == null || args.length != 3) {
    throw ArgumentError('Invalid parameters. Please provide n, min, max');
  }

  int n = int.tryParse(args[0]);
  int min = int.tryParse(args[1]);
  int max = int.tryParse(args[2]);

  if (n == null ||
      min == null ||
      max == null ||
      n <= 0 ||
      min < 0 ||
      max < min) {
    throw ArgumentError('n, min and max must be valid integers');
  }

  final answer = Answer3.fromArgs(n: n, min: min, max: max);
  print('Intervals: ${answer.intervals}');
  print('Intersected: ${answer.intersected}');
  print('Contained: ${answer.contained}');
}

class IntervalInfo {
  final Interval2D interval;
  bool isIntersected = false;
  bool isContained = false;

  IntervalInfo(this.interval);
}

class Answer3 {
  List<Interval2D> _intersected;
  List<Interval2D> _contained;
  final List<IntervalInfo> _intervals;

  Answer3._(this._intervals) {
    calculateIntersectedIntervals();
    calculateContainedIntervals();
  }

  factory Answer3.fromArgs({int n, int min, int max}) {
    final intervals =
        List.generate(n, (_) => IntervalInfo(_randomInterval2D(min, max)));

    return Answer3._(intervals);
  }

  List<IntervalInfo> get intervals => _intervals;

  void calculateIntersectedIntervals() {
    if (intersected != null) return;
    _intersected = [];

    for (int i = 0; i < intervals.length; i++) {
      for (int j = 0; j < intervals.length; j++) {
        if (i == j) continue;

        var thisInterval = intervals[i];
        var thatInterval = intervals[j];

        if (thisInterval.interval.intersects(thatInterval.interval)) {
          _intersected.add(thisInterval.interval);
          thisInterval.isIntersected = true;
          break;
        }
      }
    }
  }

  void calculateContainedIntervals() {
    if (contained != null) return;
    if (intersected == null) calculateIntersectedIntervals();

    _contained = [];

    for (int i = 0; i < intervals.length; i++) {
      if (!intervals[i].isIntersected) continue;

      for (int j = 0; j < intervals.length; j++) {
        if (i == j) continue;
        if (!intervals[j].isIntersected) continue;

        var thisInterval = intervals[i];
        var otherInterval = intervals[j];

        if (thisInterval.interval.containsInterval(otherInterval.interval)) {
          _contained.add(otherInterval.interval);
          otherInterval.isContained = true;
          break;
        }
      }
    }
  }

  List<Interval2D> get intersected => _intersected;
  List<Interval2D> get contained => _contained;

  static final _random = math.Random();
  static double _randomInt(min, max) =>
      (min + _random.nextInt(max - min + 1)).toDouble();
  static Interval1D _randomInterval1D(min, max) {
    double a = _randomInt(min, max);
    double b = _randomInt(min, max);
    return Interval1D(math.min(a, b), math.max(a, b));
  }

  static Interval2D _randomInterval2D(int min, int max) {
    return Interval2D(_randomInterval1D(min, max), _randomInterval1D(min, max));
  }
}
