/*
 *  Data files:   https://algs4.cs.princeton.edu/11model/tinyAllowlist.txt
 *                https://algs4.cs.princeton.edu/11model/tinyText.txt
 *                https://algs4.cs.princeton.edu/11model/largeAllowlist.txt
 *                https://algs4.cs.princeton.edu/11model/largeText.txt
 *
 *  dart --enable-asserts --packages=.packages package:algo/chapters/1/sections/2/exercise_9.dart data/largeAllowlist.txt < data/largeText.txt
 */

import '../../../../utils/in.dart';
import '../../../../utils/std_in.dart';

main(List<String> args) async {
  if (args == null || args.length != 1) {
    throw ArgumentError('Must provide file to be searched as an argument.');
  }
  List<int> arr = await In.fromName(args[0]).readAllInts();

  List<int> allInts = await StdIn.readAllInts();
  final searcher = _BinarySearch.fromUnsorted(arr);

  for (int key in allInts) {
    searcher.rank(key);
  }
}

class _Counter {
  final String _name;
  int _count = 0;

  _Counter(this._name);

  int get tally => _count;
  void increment() {
    _count++;
  }

  @override
  String toString() => '$tally $_name';
}

class _BinarySearch {
  List<num> arr;
  _BinarySearch._(this.arr);

  factory _BinarySearch.fromUnsorted(List<num> arr) {
    arr.sort();
    return _BinarySearch.fromSorted(arr);
  }

  factory _BinarySearch.fromSorted(List<num> arr) {
    return _BinarySearch._(arr);
  }

  int rank(num key) {
    final counter = _Counter('searches');
    final result = _rank(key, 0, arr.length - 1, counter);

    if (result == -1) {
      print('Key $key not found in array of length ${arr.length}: $counter');
    } else {
      print('Key $key found in array of length ${arr.length}: $counter');
    }

    return result;
  }

  int _rank(num key, int start, int end, _Counter counter) {
    counter.increment();
    if (end < start) return -1;

    int middle = start + ((end - start) ~/ 2);
    if (key > arr[middle]) {
      return _rank(key, middle + 1, end, counter);
    } else if (key < arr[middle]) {
      return _rank(key, start, middle - 1, counter);
    }

    return middle;
  }
}
