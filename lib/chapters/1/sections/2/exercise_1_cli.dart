// Instruction: Write a Point2D client that takes an integer value N from the
// command line, generates N random points in the unit square, and computes the
// distance separating the closest pair of points.

import 'dart:math';

import 'package:algo/utils/point_2d.dart';

main(List<String> args) {
  if (args == null || args.length != 1)
    throw ArgumentError('an int argument be provided');

  int n = int.tryParse(args.first);
  if (n == null) throw ArgumentError('argument must be an integer');

  double result =
      PointsClosestDistanceCalculator.generatePoints(n).closestDistance;
  print('Closest Distance: $result');
}

class PointsClosestDistanceCalculator {
  final List<Point2D> _points;
  double _closestDistance;

  PointsClosestDistanceCalculator(this._points);

  factory PointsClosestDistanceCalculator.generatePoints(int n) {
    Random random = Random();
    List<Point2D> points = List.generate(
      n,
      (_) => Point2D(random.nextDouble(), random.nextDouble()),
    );
    return PointsClosestDistanceCalculator(points);
  }

  double get closestDistance {
    if (_closestDistance == null) _calculate();
    return _closestDistance;
  }

  _calculate() {
    final minimumPoint = Point2D.zero;
    _points.sort((first, second) {
      final firstDistance = first.distanceTo(minimumPoint);
      final secondDistance = second.distanceTo(minimumPoint);
      return secondDistance.compareTo(firstDistance);
    });

    double minDistance = double.maxFinite;
    for (int i = 1; i < _points.length; i++) {
      final newDistance = _points[i - 1].distanceTo(_points[i]);
      minDistance = min(minDistance, newDistance);
    }

    _closestDistance = minDistance;
  }
}
