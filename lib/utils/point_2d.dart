import 'dart:math';

import 'assert.dart';

main(List<String> args) {
  final p1 = Point2D(3, -4);
  final p2 = Point2D(6, 0);

  Assert.equal(p1 + p2, Point2D(9, -4));

  Assert.equal(p1 - p2, Point2D(-3, -4));
  Assert.equal(p2 - p1, Point2D(3, 4));
  Assert.equal(p1 - p1, Point2D.zero);

  Assert.equal(p1.distanceTo(p2), 5);
}

class Point2D {
  static final zero = Point2D(0, 0);
  final double _x;
  final double _y;

  Point2D(this._x, this._y) {
    if (x == null || y == null)
      throw ArgumentError.notNull('Coordinates cannot be null');
    if (x.isInfinite || y.isInfinite)
      throw ArgumentError('Coordinates must be finite');
    if (x.isNaN || y.isNaN) throw ArgumentError('Coordinates cannot be NaN');
  }

  get x => _x;
  get y => _y;

  bool operator ==(Object other) {
    if (other is Point2D) {
      return x == other.x && y == other.y;
    }
    return false;
  }

  double distanceTo(Point2D other) {
    final dPoint = this - other;
    return sqrt(dPoint.x * dPoint.x + dPoint.y * dPoint.y);
  }

  Point2D operator -(covariant other) {
    return Point2D(x - other.x, y - other.y);
  }

  Point2D operator +(covariant other) {
    return Point2D(x + other.x, y + other.y);
  }

  @override
  String toString() => 'Point($x, $y)';

  @override
  int get hashCode {
    int hash1 = x.hashCode;
    int hash2 = y.hashCode;
    return 31 * hash1 + hash2;
  }
}
