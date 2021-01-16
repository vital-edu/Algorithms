class BinarySearch {
  static int initRank(int key, List<int> list) {
    return rank(key, list, 0, list.length - 1);
  }

  static int rank(int key, List<int> list, int li, int hb) {
    if (li > hb) return null;

    int middle = li + (hb - li) ~/ 2;
    if (key < list[middle])
      return rank(key, list, li, middle);
    else if (key > list[middle])
      return rank(key, list, middle, hb);
    else
      return middle;
  }
}

main(List<String> args) {
  print(BinarySearch.initRank(1, [1, 2, 3, 4, 5, 6, 7, 8, 9]));
  print(BinarySearch.initRank(4, [1, 2, 3, 4, 5, 6, 7, 8, 9]));
  print(BinarySearch.initRank(7, [1, 2, 3, 4, 5, 6, 7, 8]));
}
