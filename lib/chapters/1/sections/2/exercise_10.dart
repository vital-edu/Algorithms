import 'package:algo/commons/numeral_text_field.dart';
import 'package:flutter/material.dart';

import 'exercise_10_cli.dart';

class Exercise10 extends StatefulWidget {
  @override
  _Exercise10State createState() => _Exercise10State();
}

class _Exercise10State extends State<Exercise10> {
  _CounterNotifier counter;
  int _maxNumberOfOperations = 20;
  int _maxAbsoluteValue = 5;

  get maxNumberOfOperations => _maxNumberOfOperations;
  set maxNumberOfOperations(int value) {
    print('value: $value');
    if (value == null || value == 0) return;
    setState(() => _maxNumberOfOperations = value.abs());
  }

  get maxAbsoluteValue => _maxAbsoluteValue;
  set maxAbsoluteValue(int value) {
    print('value: $value');
    if (value == null || value == 0) return;
    setState(() => _maxAbsoluteValue = value.abs());
  }

  _generateCounter() {
    if (maxNumberOfOperations == null || maxAbsoluteValue == null) return;
    setState(() {
      this.counter =
          _CounterNotifier('clicks', maxNumberOfOperations, maxAbsoluteValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              NumeralTextField(
                labelText: 'Maximum number of operations',
                onUpdateValue: (value) => maxNumberOfOperations = value,
                maxValue: 20,
                value: maxNumberOfOperations.toString(),
              ),
              NumeralTextField(
                labelText: 'Maximum absolute value',
                onUpdateValue: (value) => maxAbsoluteValue = value,
                maxValue: 5,
                value: maxAbsoluteValue.toString(),
              ),
              ElevatedButton(
                  onPressed: _generateCounter, child: Text('Generate Counter')),
              if (counter != null) _Counter(counter),
            ],
          ),
        ),
      ),
    );
  }
}

class _CounterNotifier extends Counter with ChangeNotifier {
  _CounterNotifier(String name, int maxNumberOfOperations, int maxValue)
      : super(name, maxNumberOfOperations, maxValue);

  @override
  void increment() {
    super.increment();
    notifyListeners();
  }

  @override
  void decrement() {
    super.decrement();
    notifyListeners();
  }
}

class _Counter extends StatelessWidget {
  final _CounterNotifier counter;

  _Counter(Counter counter) : this.counter = counter;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (_, __) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('-1'),
                onPressed: counter.decrement,
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                child: Text('+1'),
                onPressed: counter.increment,
              ),
            ],
          ),
          Text('Tally: ${counter.tally}'),
        ],
      ),
      animation: counter,
    );
  }
}
