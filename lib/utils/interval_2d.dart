import 'interval_1d.dart';
import 'point_2d.dart';

class Interval2D {
  final Interval1D _x;
  final Interval1D _y;

  Interval1D get x => _x;
  Interval1D get y => _y;

  Interval2D(Interval1D x, Interval1D y)
      : this._x = x,
        this._y = y;

  bool intersects(Interval2D that) {
    if (!this.x.intersects(that.x)) return false;
    if (!this.y.intersects(that.y)) return false;
    return true;
  }

  bool contains(Point2D p) {
    return x.contains(p.x()) && y.contains(p.y());
  }

  bool containsInterval(Interval2D other) {
    return x.containsInterval(other.x) && y.containsInterval(other.y);
  }

  double get area => x.length * y.length;

  @override
  String toString() => '$x x $y';

  bool operator ==(covariant Interval2D other) {
    if (other == this) return true;
    if (other == null) return false;
    return this.x == other.x && this.y == other.y;
  }

  int get hashCode {
    int hash1 = x.hashCode;
    int hash2 = y.hashCode;
    return 31 * hash1 + hash2;
  }
}
