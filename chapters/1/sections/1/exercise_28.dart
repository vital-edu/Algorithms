// Instruction: Remove duplicates. Modify the test client in BinarySearch to
// remove any duplicate keys in the whitelist after the sort.

import '../../../../binary_search.dart';
import '../../../../utils/in.dart';
import '../../../../utils/std_in.dart';
import '../../../../utils/std_out.dart';

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
  whitelist = whitelist.withoutDuplicates();

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

extension ListExtension<E> on List<E> {
  List<E> withoutDuplicates() {
    return this.toSet().toList();
  }
}
