class Counter {
  int _counter = 0;
  final String _name;
  int _remainingOperations;
  final int _maxAbsoluteValue;

  Counter(this._name, int maxNumberOfOperations, int maxValue)
      : this._remainingOperations = maxNumberOfOperations,
        this._maxAbsoluteValue = maxValue.abs();

  int get tally => _counter;
  void increment() {
    if (_remainingOperations == 0) return;
    if ((tally + 1).abs() > _maxAbsoluteValue) return;

    _remainingOperations--;
    _counter++;
  }

  void decrement() {
    if (_remainingOperations == 0) return;
    if ((tally - 1).abs() > _maxAbsoluteValue) return;

    _remainingOperations--;
    _counter--;
  }

  @override
  String toString() => '$tally $_name';
}
