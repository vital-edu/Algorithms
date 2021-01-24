main(List<String> args) {
  int sum = 0;
  final N = 1000;
  for (int i = 1; i < 1000; i *= 2) for (int j = 0; j < N; j++) sum++;
  print(sum);
}
