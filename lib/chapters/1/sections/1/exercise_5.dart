// Instruction: Write a code fragment that prints true if the double variables
// x and y are both strictly between 0 and 1 and false otherwise.

main(List<String> args) {
  if (args.length != 2) {
    print('Invalid arguments.');
    return;
  }

  for (String arg in args) {
    if (isStrictlyBetweenZeroAndOne(arg) == false) {
      print(false);
      return;
    }
  }

  print(true);
}

bool isStrictlyBetweenZeroAndOne(String a) {
  double num = double.tryParse(a);
  if (num == null) return false;

  return num > 0 && num < 1;
}
