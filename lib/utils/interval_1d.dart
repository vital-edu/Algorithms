import 'dart:core';

import 'std_out.dart';

class Interval1D {
  static const Comparator<Interval1D> MIN_ENDPOINT_ORDER =
      _minEndpointComparator;
  static const Comparator<Interval1D> MAX_ENDPOINT_ORDER =
      _maxEndpointComparator;
  static const Comparator<Interval1D> LENGTH_ORDER = _lengthComparator;

  final double _min;
  final double _max;
  Interval1D(double min, double max)
      : this._min = min,
        this._max = max {
    if (min.isInfinite || max.isInfinite)
      throw new ArgumentError("Endpoints must be finite");
    if (min.isNaN || max.isNaN)
      throw new ArgumentError("Endpoints cannot be NaN");

    if (min > max) {
      throw new ArgumentError("Illegal interval");
    }
  }

  double get min => _min;
  double get max => _max;

  bool intersects(Interval1D that) {
    if (this.max < that.min) return false;
    if (that.max < this.min) return false;
    return true;
  }

  bool contains(double x) {
    return (min <= x) && (x <= max);
  }

  double get length => max - min;

  @override
  String toString() {
    return '[$min, $max]';
  }

  bool operator ==(covariant other) {
    if (other == this) return true;
    if (other == null) return false;
    if (other.runtimeType != this.runtimeType) return false;
    return this.min == other.min && this.max == other.max;
  }

  @override
  int get hashCode {
    int hash1 = min.hashCode;
    int hash2 = max.hashCode;
    return 31 * hash1 + hash2;
  }

  static int _minEndpointComparator(Interval1D a, Interval1D b) {
    if (a.min < b.min)
      return -1;
    else if (a.min > b.min)
      return 1;
    else if (a.max < b.max)
      return -1;
    else if (a.max > b.max)
      return 1;
    else
      return 0;
  }

  static int _maxEndpointComparator(Interval1D a, Interval1D b) {
    if (a.max < b.max)
      return -1;
    else if (a.max > b.max)
      return 1;
    else if (a.min < b.min)
      return -1;
    else if (a.min > b.min)
      return 1;
    else
      return 0;
  }

  static int _lengthComparator(Interval1D a, Interval1D b) {
    double alen = a.length;
    double blen = b.length;
    if (alen < blen)
      return -1;
    else if (alen > blen)
      return 1;
    else
      return 0;
  }
}

void main(List<String> args) {
  List<Interval1D> intervals = List(4);
  intervals[0] = Interval1D(15.0, 33.0);
  intervals[1] = Interval1D(45.0, 60.0);
  intervals[2] = Interval1D(20.0, 70.0);
  intervals[3] = Interval1D(46.0, 55.0);

  StdOut.println('Unsorted');
  for (int i = 0; i < intervals.length; i++) StdOut.println(intervals[i]);
  StdOut.println();

  StdOut.println('Sort by min endpoint');
  intervals.sort(Interval1D.MIN_ENDPOINT_ORDER);
  for (int i = 0; i < intervals.length; i++) StdOut.println(intervals[i]);
  StdOut.println();

  StdOut.println('Sort by max endpoint');
  intervals.sort(Interval1D.MAX_ENDPOINT_ORDER);
  for (int i = 0; i < intervals.length; i++) StdOut.println(intervals[i]);
  StdOut.println();

  StdOut.println('Sort by length');
  intervals.sort(Interval1D.LENGTH_ORDER);
  for (int i = 0; i < intervals.length; i++) StdOut.println(intervals[i]);
  StdOut.println();
}
