import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../utils/point_2d.dart';
import 'exercise_1_cli.dart';

const LIMIT_OF_POINTS = 9999;

class Exercise1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Exercise1State();
}

FutureOr<PointsClosestDistanceCalculator> _generateCalculator(n) {
  final calculator = PointsClosestDistanceCalculator.generatePoints(n);
  calculator.closestDistance;
  return calculator;
}

class _Exercise1State extends State<Exercise1> {
  TextEditingController _controller;
  double _result;
  bool _isCalculating = false;
  PointsClosestDistanceCalculator _calculator;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  _calculate() async {
    int n = int.tryParse(_controller.text);
    if (n == null) return;

    setState(() {
      _result = null;
      _isCalculating = true;
    });

    PointsClosestDistanceCalculator calculator =
        await compute(_generateCalculator, n);

    setState(() {
      _result = calculator.closestDistance;
      _isCalculating = false;
      _calculator = calculator;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              if (_calculator != null)
                Expanded(
                  child: CustomPaint(
                    painter: DotsPainter(_calculator),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotsPainter extends CustomPainter {
  final PointsClosestDistanceCalculator calculator;

  DotsPainter(this.calculator);

  @override
  void paint(Canvas canvas, Size size) {
    if (calculator == null) return;
    final points = calculator.points;
    final closestPoints = calculator.closestPoints;

    final paint = Paint()..color = Colors.red;
    double circleSize;
    if (points.length <= 100) {
      circleSize = 3;
    } else if (points.length <= 1000) {
      circleSize = 2;
    } else {
      circleSize = 0.8;
    }

    final xScale = size.width;
    final yScale = size.height;

    for (Point2D point in points) {
      final p = Offset(point.x * xScale, point.y * yScale);
      canvas.drawCircle(p, circleSize, paint);
    }

    Offset pointA =
        Offset(closestPoints[0].x * xScale, closestPoints[0].y * yScale);
    Offset pointB =
        Offset(closestPoints[1].x * xScale, closestPoints[1].y * yScale);

    canvas.drawLine(
        pointA,
        pointB,
        paint
          ..color = Colors.blue
          ..strokeWidth = circleSize);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
