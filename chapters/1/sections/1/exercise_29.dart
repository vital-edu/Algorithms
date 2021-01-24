// Instruction: Equal keys. Add to BinarySearch a static method rank() that
// takes a key and a sorted array of int values (some of which may be equal) as
// arguments and returns the number of elements that are smaller than the key
// and a similar method count() that returns the number of elements equal to the
// key. Note : If i and j are the values returned by rank(key, a) and
// count(key, a) respectively, then a[i..i+j-1] are the values in the array that
// are equal to key.

import '../../../../utils/in.dart';
import '../../../../utils/std_in.dart';
import '../../../../utils/std_out.dart';

class BinarySearch {
  int rank(int key, List<int> list) {
    return _rank(key, list, 0, list.length - 1);
  }

  int _rank(int key, List<int> list, int li, int hb, {int depth = 0}) {
    if (li > hb) return null;
    if (list[li] == key) return li;

    int middle = li + (hb - li) ~/ 2;
    if (key < list[middle])
      return _rank(key, list, li, middle - 1, depth: depth + 1);
    else if (key > list[middle])
      return _rank(key, list, middle + 1, hb, depth: depth + 1);
    else {
      int maybeLess = _rank(key, list, li, middle - 1, depth: depth + 1);
      return maybeLess == null ? middle : maybeLess;
    }
  }

  int count(int key, int minIdx, List<int> list) {
    return list.sublist(minIdx).takeWhile((e) => e == key).length;
  }
}

main(List<String> args) async {
  if (args == null || args.length != 1) return;

  List<int> whitelist = await In.fromName(args[0]).readAllInts();

  whitelist.sort();

  BinarySearch searcher = BinarySearch();

  await for (int key in StdIn.readInt()) {
    int i = searcher.rank(key, whitelist);
    if (i == null) {
      StdOut.println('$key not found');
      return;
    }
    int j = searcher.count(key, i, whitelist);
    StdOut.println('$key: $i');
    StdOut.println('count($key): $j');
    StdOut.println('equal to $key: ${whitelist.getRange(i, i + j)}');
  }
}
