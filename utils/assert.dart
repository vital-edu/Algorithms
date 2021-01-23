class Assert {
  static equal<T>(T a, T b) {
    assert(a == b, '$a != $b');
  }
}
