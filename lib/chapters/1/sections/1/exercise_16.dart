main() {
  print(exR1(6));
}

String exR1(int n) {
  if (n <= 0) return '';
  return '${exR1(n - 3)}$n${exR1(n - 2)}$n';
}
