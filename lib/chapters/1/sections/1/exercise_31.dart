// Random connections. Write a program that takes as command-line arguments an
// integer N and a double value p (between 0 and 1), plots N equally spaced dots
// of size .05 on the circumference of a circle, and then, with probability p
// for each pair of points, draws a gray line connecting them.
import '../../../../utils/string_extension.dart';
main(List<String> args) {
  if (args == null || args.length != 2) return;

  int n = int.tryParse(args[0]);
  double p = double.tryParse(args[1]);
  if (n == null || p == null || p < 0 || p > 1) return;

  print(''.padCenter())
}
