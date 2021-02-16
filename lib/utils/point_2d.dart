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
  double get r => sqrt(x * x + y * y);
  double get theta => atan2(y, x);

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

  double distanceSquaredTo(Point2D that) {
    double dx = this.x - that.x;
    double dy = this.y - that.y;
    return dx * dx + dy * dy;
  }

  double _angleTo(Point2D that) {
    double dx = that.x - this.x;
    double dy = that.y - this.y;
    return atan2(dy, dx);
  }

  int compareTo(Point2D that) {
    if (this.y < that.y) return -1;
    if (this.y > that.y) return 1;
    if (this.x < that.x) return -1;
    if (this.x > that.x) return 1;
    return 0;
  }

  static int ccw(Point2D a, Point2D b, Point2D c) {
    double area2 = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
    if (area2 < 0)
      return -1;
    else if (area2 > 0)
      return 1;
    else
      return 0;
  }

  static double area2(Point2D a, Point2D b, Point2D c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
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

  static const X_ORDER = _xOrder;
  static const Y_ORDER = _yOrder;
  static const R_ORDER = _rOrder;

  static int _xOrder(Point2D p, Point2D q) {
    if (p.x < q.x) return -1;
    if (p.x > q.x) return 1;
    return 0;
  }

  static int _yOrder(Point2D p, Point2D q) {
    if (p.y < q.y) return -1;
    if (p.y > q.y) return 1;
    return 0;
  }

  static int _rOrder(Point2D p, Point2D q) {
    double delta = (p.x * p.x + p.y * p.y) - (q.x * q.x + q.y * q.y);
    if (delta < 0) return -1;
    if (delta > 0) return 1;
    return 0;
  }

  int atan2Order(Point2D q1, Point2D q2) {
    double angle1 = _angleTo(q1);
    double angle2 = _angleTo(q2);
    if (angle1 < angle2)
      return -1;
    else if (angle1 > angle2)
      return 1;
    else
      return 0;
  }

  int polarOrder(Point2D q1, Point2D q2) {
    double dx1 = q1.x - x;
    double dy1 = q1.y - y;
    double dx2 = q2.x - x;
    double dy2 = q2.y - y;

    if (dy1 >= 0 && dy2 < 0)
      return -1;
    else if (dy2 >= 0 && dy1 < 0)
      return 1;
    else if (dy1 == 0 && dy2 == 0) {
      if (dx1 >= 0 && dx2 < 0)
        return -1;
      else if (dx2 >= 0 && dx1 < 0)
        return 1;
      else
        return 0;
    } else
      return -ccw(this, q1, q2);
  }

  int distanceToOrder(Point2D p, Point2D q) {
    double dist1 = distanceSquaredTo(p);
    double dist2 = distanceSquaredTo(q);
    if (dist1 < dist2)
      return -1;
    else if (dist1 > dist2)
      return 1;
    else
      return 0;
  }
}
