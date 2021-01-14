main() {
  print(gcd(2, 3));
  print(gcd(2, 0));
  print(gcd(0, 2));
  print(gcd(20, 3));
  print(gcd(33113283, 12222121));
  print(gcd(5, 20));
}

int gcd(int p, int q) {
  if (q == 0) return p;
  final r = p % q;
  return gcd(q, r);
}
