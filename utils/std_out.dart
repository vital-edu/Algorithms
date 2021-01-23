import 'dart:io';

class StdOut {
  static void print(Object x) {
    stdout.write(x);
    stdout.flush();
  }
}
