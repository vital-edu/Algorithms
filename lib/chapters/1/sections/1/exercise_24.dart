// Instruction: Give the sequence of values of p and q that are computed when
// Euclid’s algorithm is used to compute the greatest common divisor of 105 and
// 24. Extend the code given on page 4 to develop a program Euclid that takes
// two integers from the command line and computes their greatest common
// divisor, printing out the two arguments for each call on the recursive
// method. Use your program to compute the greatest common divisor or 1111111
// and 1234567

import '../../../../utils/assert.dart';

main() {
  Assert.equal(gcd(105, 24), 3);
  Assert.equal(gcd(1111111, 1234567), 1);
}

int gcd(int p, int q, {int depth = 0}) {
  _trace(p, q, depth);
  if (q == 0) return p;
  final r = p % q;
  return gcd(q, r, depth: depth + 1);
}

void _trace(int p, int q, int depth) {
  print(
      'depht: ${depth.toString().padLeft(3)} | p: ${p.toString().padLeft(10)} | q: ${q.toString().padLeft(10)}');
}
