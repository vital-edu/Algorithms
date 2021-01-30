// Empirical shuffle check. Run computational experiments to check that our
// shuffling code on page 32 works as advertised. Write a program ShuffleTest
// that takes command-line arguments M and N, does N shuffles of an array of
// size M that is initialized with a[i] = i before each shuffle, and prints an
// M-by-M table such that row i gives the number of times i wound up in position
// j for all j. All entries in the array should be close to N/M.

import 'dart:math';
import '../../../../utils/string_extension.dart';

final random = Random();

main(List<String> args) {
  int sizeOfArray = 10;
  int numberOfShuffles = 100000;

  if (args.length == 2) {
    sizeOfArray = int.tryParse(args[0]) ?? sizeOfArray;
    numberOfShuffles = int.tryParse(args[1]) ?? numberOfShuffles;
  }

  Map<double, List<int>> distribution = Map.fromIterable(
      List.generate(sizeOfArray, (i) => i.toDouble()),
      key: (i) => i,
      value: (_) => List.filled(sizeOfArray, 0));

  // List.filled(sizeOfArray, List.generate(sizeOfArray, (_) => 0));

  for (int i = 0; i < numberOfShuffles; i++) {
    List<double> arr = List.generate(sizeOfArray, (i) => i.toDouble());
    shuffle(arr);
    updateDistribution(arr, distribution);
  }

  printTable(distribution, numberOfShuffles: numberOfShuffles);
}

void updateDistribution(List<double> arr, Map<double, List<int>> distribution) {
  for (int i = 0; i < arr.length; i++) {
    double value = arr[i];
    distribution[value][i]++;
  }
}

void printTable(Map<double, List<int>> arr, {int numberOfShuffles}) {
  int pad = 5;
  print(
      'All cells should be close to ${(numberOfShuffles ~/ arr.length).toInt()}.\n');
  final header = List.generate(arr.length, (i) => i)
      .map((e) => e.toString().padCenter(pad))
      .join(' ');
  print('${''.padCenter(pad)} $header');
  print('-' * ((pad + 1) * (arr.length + 1)));

  for (MapEntry<double, List<int>> entry in arr.entries) {
    String row = entry.value.map((e) => e.toString().padCenter(pad)).join('|');
    print('${entry.key.toString().padCenter(pad)}|$row');
  }
}

void shuffle(List<double> a) {
  int N = a.length;
  for (int i = 0; i < N; i++) {
    // Exchange a[i] with random element in a[i..N-1]
    int r = i + random.nextInt(N - i);
    double temp = a[i];
    a[i] = a[r];
    a[r] = temp;
  }
}
