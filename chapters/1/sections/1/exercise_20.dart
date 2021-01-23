// Instruction: Write a recursive static method that computes the value of
// ln (N!)

main(List<String> args) {
  Computer computer = Computer();

  for (int i = 0; i < 20; i++) {
    print('$i ${computer.factorial(i)}');
  }
}

class Computer {
  List<int> computedFactorials = List<int>()
    ..length = 100
    ..[1] = 1;

  int factorial(int n) {
    if (n == 0) return 1;

    int result = computedFactorials[n];
    if (result != null) return result;

    result = n * factorial(n - 1);
    computedFactorials[n] = result;
    return result;
  }
}
