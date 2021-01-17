main(List<String> args) {
  int sum = 0;
  for (int i = 1; i < 1000; i++) for (int j = 0; j < i; j++) sum++;
  print(sum);
}
