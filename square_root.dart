double sqrt(double c) {
  if (c < 0) return double.nan;
  double err = 1e-15;
  double t = c;
  while ((t - c / t).abs() > err * t) {
    t = (c / t + t) / 2;
  }
  return t;
}

main() {
  print(sqrt(2));
  print(sqrt(27));
  print(sqrt(9));
}
