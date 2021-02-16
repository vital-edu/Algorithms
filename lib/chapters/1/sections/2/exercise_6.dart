// Instruction: A string s is a circular rotation of a string t if it matches
// when the characters are circularly shifted by any number of positions; e.g.,
// ACTGACG is a circular shift of TGACGAC, and vice versa. Detecting this
// condition is important in the study of genomic sequences. Write a program
// that checks whether two given strings s and t are circulars of one another.
// Hint : The solution is a one-liner with indexOf(), length(), and string
// concatenation

main(List<String> args) {
  if (args == null || args.length != 2)
    throw ArgumentError('two string params are required');

  String s = args[0];
  String t = args[1];

  if (isCircular(s, t)) {
    print('$s is circular to $t');
  } else {
    print('$s and $t are not circular');
  }
}

bool isCircular(String s, String t) {
  if (s.length != t.length) return false;
  return (s + s).indexOf(t) != -1;
}
