// Instruction: Write a static method histogram() that takes an array 'a' of
// int values and an integer M as arguments and returns an array of length M
// whose ith entry is the number of times the integer i appeared in the argument
// array. If the values in a[] are all between 0 and M–1, the sum of the values
// in the returned array should be equal to a.length.

main(List<String> args) {
  List<int> arr = [1, 2, 3, 8, 5, 2, 5, 6, 8, 3, 1, 3, 7, 8, 3, 3, 6, 7, 3, 2];

  print(Exercise.histogram(arr, 9));
  print(Exercise.histogram(arr, 1));
}

class Exercise {
  static List<int> histogram(List<int> a, int M) {
    var result = List<int>.filled(M, 0);

    for (MapEntry<int, int> entry in a.asMap().entries) {
      if (entry.value >= result.length) continue;
      result[entry.value] += 1;
    }

    return result;
  }
}
