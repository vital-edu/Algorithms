import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'exercise_1_cli.dart';

const LIMIT_OF_POINTS = 999999;

class Exercise1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Exercise1State();
}

FutureOr<double> _computeClosestDistance(
    PointsClosestDistanceCalculator calculator) {
  return calculator.closestDistance;
}

FutureOr<PointsClosestDistanceCalculator> _generateCalculator(n) {
  return PointsClosestDistanceCalculator.generatePoints(n);
}

class _Exercise1State extends State<Exercise1> {
  TextEditingController _controller;
  double _result;
  bool _isCalculating = false;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  _calculate() async {
    setState(() {
      _result = null;
      _isCalculating = true;
    });

    int n = int.tryParse(_controller.text);
    PointsClosestDistanceCalculator calculator =
        await compute(_generateCalculator, n);
    double value = await compute(_computeClosestDistance, calculator);

    setState(() {
      _result = value;
      _isCalculating = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Number of points'),
                keyboardType: TextInputType.number,
                controller: _controller,
                onChanged: (String value) {
                  int points = int.tryParse(value);
                  if (points == null || points > LIMIT_OF_POINTS) {
                    final validText = value.substring(0, value.length - 1);
                    _controller.text = validText;
                    _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: validText.length),
                    );
                  }
                },
              ),
              ElevatedButton(
                child: Text('Calculate Closest Distance'),
                onPressed: () {
                  _calculate();
                },
              ),
              if (_isCalculating) CircularProgressIndicator(),
              if (!_isCalculating && _result != null)
                Text('Closest Distance: $_result'),
              CustomPaint(
                painter: DotsPainter(int.tryParse(_controller.text)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotsPainter extends CustomPainter {
  final int n;

  DotsPainter(this.n);

  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
