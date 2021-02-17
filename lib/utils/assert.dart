typedef VoidCallback = void Function();

class ExpectedExceptionNotRaised extends Error {
  final Error error;
  ExpectedExceptionNotRaised([this.error]);

  @override
  String toString() {
    if (error == null) {
      return 'ExpectedExceptionNotRaised: an error was expected but was not raised';
    }
    return 'ExpectedExceptionNotRaised: an error was expected but was not raised: $error';
  }
}

class ExceptionRaised extends Error {
  final Error error;
  ExceptionRaised(this.error);

  @override
  String toString() {
    return 'ExceptionRaised: an error was raised but was not expected: $error';
  }
}

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

  static notRaiseException(VoidCallback block) {
    try {
      block();
    } catch (e) {
      throw ExceptionRaised(e);
    }
  }

  static raiseException(VoidCallback block, {Pattern errorMessage}) {
    try {
      block();
      throw ExpectedExceptionNotRaised();
    } on ExpectedExceptionNotRaised {
      rethrow;
    } catch (e) {
      if (errorMessage != null) {
        if (!e.toString().contains(errorMessage)) {
          throw ExpectedExceptionNotRaised(e);
        }
      }
    }
  }
}
