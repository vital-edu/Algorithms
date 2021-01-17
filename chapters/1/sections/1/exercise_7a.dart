main(List<String> args) {
  double t = 9;

  while ((t - 9 / t).abs() > .001) t = (9 / t + t) / 2;
  print("${t.toStringAsPrecision(5)}\n");
}
