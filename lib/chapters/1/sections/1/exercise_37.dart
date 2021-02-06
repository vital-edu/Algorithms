// Instruction: Bad shuffling. Suppose that you choose a random integer between
// 0 and N-1 in our shuffling code instead of one between i and N-1. Show that
// the resulting order is not equally likely to be one of the N! possibilities.
// Run the test of the previous exercise for this version.

import 'dart:math';
import 'exercise_36.dart';

final random = Random();

main(List<String> args) {
  int sizeOfArray = 10;
  int numberOfShuffles = 100000;

  if (args.length == 2) {
    sizeOfArray = int.tryParse(args[0]) ?? sizeOfArray;
    numberOfShuffles = int.tryParse(args[1]) ?? numberOfShuffles;
  }

  testShuffle(
    shuffleMethod: badShuffle,
    sizeOfArray: sizeOfArray,
    numberOfShuffles: numberOfShuffles,
  );
}

void badShuffle(List<double> a) {
  int N = a.length;
  for (int i = 0; i < N; i++) {
    int r = random.nextInt(N - i);
    double temp = a[i];
    a[i] = a[r];
    a[r] = temp;
  }
}
