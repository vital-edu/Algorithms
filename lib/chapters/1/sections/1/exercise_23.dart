// Instruction: Add to the BinarySearch test client the ability to respond to a
// second argument: + to print numbers from standard input that are not in the
// whitelist, - to print numbers that are in the whitelist.
import '../../../../utils/in.dart';
import '../../../../utils/std_in.dart';
import '../../../../utils/std_out.dart';

class BinarySearch {
  int rank(int key, List<int> list) {
    return _rank(key, list, 0, list.length - 1);
  }

  int _rank(int key, List<int> list, int li, int hb) {
    if (li > hb) return null;

    int middle = li + (hb - li) ~/ 2;
    if (key < list[middle])
      return _rank(key, list, li, middle - 1);
    else if (key > list[middle])
      return _rank(key, list, middle + 1, hb);
    else
      return middle;
  }
}

enum ReturnType {
  notFound,
  found,
}
main(List<String> args) async {
  if (args == null || args.length < 1) return;

  List<int> whitelist = await In.fromName(args[0]).readAllInts();
  ReturnType type = ReturnType.notFound;

  if (args.length > 1 && args[1] != null) {
    if (args[1] == '+') {
      type = ReturnType.notFound;
    } else if (args[1] == '-') {
      type = ReturnType.found;
    }
  }

  whitelist.sort();

  BinarySearch searcher = BinarySearch();

  await for (int key in StdIn.readInt()) {
    switch (type) {
      case ReturnType.found:
        if (searcher.rank(key, whitelist) != null)
          StdOut.println('$key is in the list');
        break;
      case ReturnType.notFound:
        if (searcher.rank(key, whitelist) == null)
          StdOut.println('$key is not in the list');
        break;
    }
  }
}
