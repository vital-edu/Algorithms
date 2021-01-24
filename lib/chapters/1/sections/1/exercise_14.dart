// Instruction: Write a static method lg() that takes an int value N as argument
// and returns the largest int not larger than the base-2 logarithm of N.

main(List<String> args) {
  print(Exercise.lg(0));
  print(Exercise.lg(1));
  print(Exercise.lg(2));
  print(Exercise.lg(3));
  print(Exercise.lg(4));
  print(Exercise.lg(8));
  print(Exercise.lg(125));
}

class Exercise {
  static int lg(int n) {
    int exponent = 0;
    int result = 1;
    do {
      result *= 2;
      exponent++;
    } while (result < n);

    if (result > n) {
      return exponent - 1;
    }

    return exponent;
  }
}
