// Instruction: Random matches. Write a BinarySearch client that takes an int
// value T as command-line argument and runs T trials of the following
// experiment for N = 1000, 10000, 100000, and 1000000: generate two arrays of N randomly
// generated positive six-digit int values, and find the number of values that
// appear in both arrays. Print a table giving the average value of this
// quantity over the T trials for each value of N.

import 'dart:math';
import '../../../../utils/string_extension.dart';

main(List<String> args) {
  if (args == null || args.length != 1) {
    throw ArgumentError('Must provide number of tries as argument.');
  }

  int t = int.parse(args.first);

  var results = {1000: 0, 10000: 0, 100000: 0, 1000000: 0};
  for (int i = -0; i < t; i++) {
    _runExperiment(results);
  }

  print('${'N'.toString().padCenter(10)}| Average Duplicated Elementes');
  print('-' * 40);
  for (MapEntry<int, int> entry in results.entries) {
    print(
        '${entry.key.toString().padRight(10)}|${(entry.value / t).toStringAsFixed(0).padLeft(28)}');
  }
}

Random random = Random();

void _runExperiment(Map<int, int> numbers) {
  for (int n in numbers.keys) {
    var arr1 = List.generate(n, (_) => _randomSixDigitValue());
    var arr2 = List.generate(n, (_) => _randomSixDigitValue());

    arr1.sort();
    arr2.sort();

    for (int e in arr1) {
      if (BinarySearch.rank(e, arr2) != -1) {
        numbers[n]++;
      }
    }
  }
}

int _randomSixDigitValue() => 100000 + random.nextInt(900000);

class BinarySearch {
  static int rank(int key, List<int> arr) {
    return _rank(key, arr, 0, arr.length - 1);
  }

  static int _rank(int key, List<int> arr, int start, int end) {
    if (end < start) return -1;

    int middle = start + ((end - start) ~/ 2);

    if (key > arr[middle]) {
      return _rank(key, arr, middle + 1, end);
    } else if (key < arr[middle]) {
      return _rank(key, arr, start, middle - 1);
    }
    return middle;
  }
}
