// Instruction: Array exercise. Write a code fragment that creates an N-by-N
// boolean array a[][] such that a[i][j] is true if i and j are relatively prime
// (have no common factors), and false otherwise.

import '../../../../utils/std_out.dart';

main(List<String> args) {
  if (args == null || args.length != 1) return;
  int n = int.tryParse(args[0]);
  if (n == null) return;

  List<List<bool>> list =
      List.generate(n, (i) => List.generate(n, (j) => isRelativePrimes(i, j)));

  printMatrix(list);
}

void printMatrix<T>(List<List<bool>> matrix) {
  for (List<bool> arr in matrix) {
    StdOut.println(arr.map((e) => printBool(e)).join(' '));
  }
}

String printBool(bool value) => value ? 'T' : 'F';

bool isRelativePrimes(int a, int b) {
  int divisor = gcd(a, b);
  return (divisor == 1);
}

int gcd(int p, int q) {
  if (q == 0) return p;

  final r = p % q;
  return gcd(q, r);
}
