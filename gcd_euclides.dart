import 'utils/assert.dart';

main() {
  Assert.equal(gcd(2, 3), 1);
  Assert.equal(gcd(2, 0), 2);
  Assert.equal(gcd(0, 2), 2);
  Assert.equal(gcd(20, 3), 1);
  Assert.equal(gcd(33113283, 12222121), 1);
  Assert.equal(gcd(5, 20), 5);
}

int gcd(int p, int q) {
  if (q == 0) return p;
  final r = p % q;
  return gcd(q, r);
}
