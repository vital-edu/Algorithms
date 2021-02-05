// Instruction: Write a Point2D client that takes an integer value N from the
// command line, generates N random points in the unit square, and computes the
// distance separating the closest pair of points.

import 'dart:math';

import 'package:algo/utils/point_2d.dart';

Random random = Random();

main(List<String> args) {
  if (args == null || args.length != 1)
    throw ArgumentError('an int argument be provided');

  int n = int.tryParse(args.first);
  if (n == null) throw ArgumentError('argument must be an integer');

  List<Point2D> points = List.generate(n, (_) => _randomPoint2D());

  final minimumPoint = Point2D.zero;
  points.sort((first, second) {
    final firstDistance = first.distanceTo(minimumPoint);
    final secondDistance = second.distanceTo(minimumPoint);
    return secondDistance.compareTo(firstDistance);
  });

  double minDistance = double.maxFinite;
  for (int i = 1; i < n; i++) {
    final newDistance = points[i - 1].distanceTo(points[i]);
    minDistance = min(minDistance, newDistance);
  }

  print('Closet Distance: ${minDistance.toStringAsExponential()}');
}

Point2D _randomPoint2D() => Point2D(random.nextDouble(), random.nextDouble());
