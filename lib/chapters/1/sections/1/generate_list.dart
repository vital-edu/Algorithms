import 'dart:math';

main(List<String> args) {
  int numbersToGenerate = 1000;
  int maxNumber = 1 << 32;

  if (args != null) {
    int arg1 = int.tryParse(args[0]);
    if (arg1 != null && arg1 > 0) {
      numbersToGenerate = arg1;
      int arg2 = int.tryParse(args[1]);

      if (arg2 != null && arg2 > 0 && arg2 <= maxNumber) maxNumber = arg2;
    }
  }

  Random random = Random.secure();

  for (int i = 0; i < numbersToGenerate; i++) {
    int number = random.nextInt(maxNumber);
    print(number);
  }
}
