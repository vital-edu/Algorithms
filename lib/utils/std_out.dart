import 'dart:io';

class StdOut {
  static void print(Object x) {
    stdout.write(x);
    stdout.flush();
  }

  static void println([Object x = '']) {
    stdout.writeln(x);
  }
}
