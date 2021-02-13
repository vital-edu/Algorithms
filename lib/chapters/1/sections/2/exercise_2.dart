import 'dart:io';

import 'package:algo/utils/interval_1d.dart';

main(List<String> args) async {
  List<Interval1D> intervals = [];
  if (args == null || args.length < 1) {
    intervals = _exampleInput;
  } else {
    int n = int.tryParse(args[0]);
    if (n == null || n <= 0)
      throw ArgumentError('n must be an integer greater than 0');
    intervals = _readUserInput(n);
  }

  for (int i = 0; i < intervals.length; i++) {
    for (int j = 0; j < intervals.length; j++) {
      if (i == j) continue;
      if (intervals[i].intersects(intervals[j])) {
        print(intervals[i]);

        intervals[i] = intervals[i] + intervals[j];
        if (j > j) {
          intervals.removeAt(j);
        }
        break;
      }
    }
  }
}

List<Interval1D> _readUserInput(int n) {
  List<Interval1D> intervals = [];
  for (int i = 0; i < n; i++) {
    final entry = stdin
        .readLineSync()
        .split(' ')
        .map((e) => double.tryParse(e))
        .where((element) => element != null);
    intervals.add(Interval1D.fromIterable(entry));
  }
  return intervals;
}

List<Interval1D> _exampleInput = [
  Interval1D(10, 20),
  Interval1D(1, 2),
  Interval1D(10, 12),
  Interval1D(7, 9),
  Interval1D(0, 4),
  Interval1D(10, 29),
  Interval1D(30, 45),
  Interval1D(4, 5),
  Interval1D(13, 20),
  Interval1D(50, 100),
];
