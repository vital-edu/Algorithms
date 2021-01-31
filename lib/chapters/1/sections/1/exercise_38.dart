// Instruction: Binary search versus brute-force search. Write a program
// BruteForceSearch that uses the brute-force search method given on page 48 and
// compare its running time on your computer with that of BinarySearch for
// largeW.txt and largeT.txt.

/*
 *  Data files:   https://algs4.cs.princeton.edu/11model/tinyAllowlist.txt
 *                https://algs4.cs.princeton.edu/11model/tinyText.txt
 *                https://algs4.cs.princeton.edu/11model/largeAllowlist.txt
 *                https://algs4.cs.princeton.edu/11model/largeText.txt
 *
 *  dart --enable-asserts --packages=.packages package:algo/chapters/1/sections/1/exercise_38.dart data/largeAllowlist.txt < data/largeText.txt
 */

import 'package:algo/utils/std_in.dart';

main(List<String> args) async {
  if (args == null || args.length != 1) {
    throw ArgumentError('Must provide file to be searched as an argument.');
  }
  List<int> arr = await In.fromName(args[0]).readAllInts();
  arr.sort();

  Duration timeToRunBruteSearch = Duration();
  Duration timeToRunBinarySearch = Duration();

  await for (int key in StdIn.readInt()) {
    timeToRunBruteSearch += trackDurationTime(
      () => BruteSearch.rank(key, arr),
    );
    timeToRunBinarySearch += trackDurationTime(
      () => BinarySearch.rank(key, arr),
    );
  }

  print(
      'Brute search ran in ${timeToRunBruteSearch.inMicroseconds} microseconds');
  print(
      'Binary search ran in ${timeToRunBinarySearch.inMicroseconds} microseconds');
}

class BinarySearch {
  static int rank(key, List<int> a) {
    return _rank(key, a, 0, a.length - 1);
  }

  static int _rank(int key, List<int> arr, int startIdx, endIdx) {
    if (endIdx < startIdx) return -1;

    int midIdx = startIdx + ((endIdx - startIdx) ~/ 2);

    if (key > arr[midIdx]) {
      return _rank(key, arr, midIdx + 1, endIdx);
    } else if (key < arr[midIdx]) {
      return _rank(key, arr, startIdx, midIdx - 1);
    }

    return midIdx;
  }
}

class BruteSearch {
  static int rank(int key, List<int> arr) {
    for (int i = 0; i < arr.length; i++) if (arr[i] == key) return i;
    return -1;
  }
}

Duration trackDurationTime(Function serch) {
  DateTime startTime = DateTime.now();
  serch();
  DateTime endTime = DateTime.now();
  return endTime.difference(startTime);
}
