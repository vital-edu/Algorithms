// Instruction: Write a version of BinarySearch that uses the recursive rank()
// given on page 25 and traces the method calls. Each time the recursive method
// is called, print the argument values lo and hi, indented by the depth of the
// recursion.
// Hint: Add an argument to the recursive method that keeps track of the depth.

main(List<String> args) {
  BinarySearch searcher = BinarySearch();
  print(searcher.initRank(1, [1, 2, 3, 4, 5, 6, 7, 8, 9]));
  print(searcher.initRank(4, [1, 2, 3, 4, 5, 6, 7, 8, 9]));
  print(searcher.initRank(7, [1, 2, 3, 4, 5, 6, 7, 8]));
  print(searcher.initRank(10, [1, 2, 3, 4, 5, 6, 7, 8]));
}

class BinarySearch {
  int initRank(int key, List<int> a) {
    return rank(key, a, 0, a.length - 1);
  }

  int rank(int key, List<int> a, int lo, int hi, {int depth = 0}) {
    // Index of key in a[], if present, is not smaller than lo
    // and not larger than hi.
    _trace(lo, hi, depth);
    if (lo > hi) return -1;
    int mid = lo + (hi - lo) ~/ 2;
    if (key < a[mid])
      return rank(key, a, lo, mid - 1, depth: depth + 1);
    else if (key > a[mid])
      return rank(key, a, mid + 1, hi, depth: depth + 1);
    else
      return mid;
  }

  void _trace(int lo, int hi, int depth) {
    print(
        'depht: ${depth.toString().padLeft(3)} | lo: ${lo.toString().padLeft(6)} | hi: ${hi.toString().padLeft(6)}');
  }
}
