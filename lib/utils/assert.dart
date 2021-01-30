class Assert {
  static equal<T>(T a, T b) {
    assert(a == b, '$a != $b');
  }

  static deepEqual(Iterable<dynamic> a, Iterable<dynamic> b) {
    assert(
        a.length == b.length, 'different lengths: ${a.length} != ${b.length}');

    for (int i = 0; i < a.length; i++) {
      try {
        Iterable<dynamic> itA = Iterable.castFrom(a.elementAt(i));
        Iterable<dynamic> itB = Iterable.castFrom(b.elementAt(i));
        deepEqual(itA, itB);
      } on TypeError {
        equal(a.elementAt(i), b.elementAt(i));
      }
    }
  }
}
