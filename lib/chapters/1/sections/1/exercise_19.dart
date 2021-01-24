class Fibonacci {
  List<int> calculatedFibo = List<int>()
    ..length = 100
    ..[0] = 0
    ..[1] = 1;

  int F(int N) {
    int answer = calculatedFibo[N];
    if (answer != null) return answer;

    answer = F(N - 1) + F(N - 2);
    calculatedFibo[N] = answer;
    return answer;
  }
}

void main(List<String> args) {
  Fibonacci fibo = Fibonacci();

  for (int N = 0; N < 90; N++) {
    print('$N ${fibo.F(N)}');
  }
}
