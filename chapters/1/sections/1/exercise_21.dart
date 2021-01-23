// Instruction: Write a program that reads in lines from standard input with
// each line containing a name and two integers and then uses printf()
// to print a table with a column of the names, the integers, and the result
// of dividing the first by the second, accurate to three decimal places.

import 'dart:io';
import '../../../../utils/string_extension.dart';

main() {
  // Input Format: String int int;
  List<String> table = [];
  while (true) {
    String input = stdin.readLineSync();
    if (input == null) break;

    List<String> args = input.split(' ');
    if (args.length != 3) break;

    String name = args[0];
    int a = int.tryParse(args[1]);
    int b = int.tryParse(args[2]);
    if (a == null || b == null) break;

    table.add(
        '|${name.padRight(20)}|${a.toStringAsFixed(3).padCenter(9)}|${b.toStringAsFixed(3).padCenter(9)}|${(a / b).toStringAsFixed(3).padCenter(9)}|');
  }

  print('${' '.padRight(51, '-')}');
  print(
      '|${'Name'.padCenter(20)}|${'A'.padCenter(9)}|${'B'.padCenter(9)}|${'A / B'.padCenter(9)}|');
  print('|${'|'.padLeft(51, '-')}');
  for (String row in table) print(row);
  print('${' '.padRight(51, '-')}');
}
