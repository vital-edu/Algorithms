// Instruction: Write a program that takes three integer command-line arguments
// and prints equal if all three are equal, and not equal otherwise.

main(List<String> args) {
  if (args.length != 3) {
    print('Invalid arguments.');
    return;
  }
  print(areEquals(args[0], args[1], args[2]));
}

bool areEquals(String a, String b, String c) {
  if (a == b && a == c) return true;
  return false;
}
