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

  List<Point2D> get points => _points;
  List<Point2D> _closestPoints = [Point2D.zero, Point2D.zero];
  List<Point2D> get closestPoints => _closestPoints;

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
    if (_points.length < 2) {
      _closestDistance = 0;
      _closestPoints = [_points.first, _points.first];
      return;
    }

    double minDistance = double.maxFinite;
    for (int i = 0; i < _points.length; i++) {
      for (int j = 0; j < _points.length; j++) {
        if (i == j) continue;
        final newDistance = _points[i].distanceTo(_points[j]);
        minDistance = min(minDistance, newDistance);
        if (minDistance == newDistance) {
          _closestPoints = [_points[i], _points[j]];
        }
      }
    }

    _closestDistance = minDistance;
  }
}
