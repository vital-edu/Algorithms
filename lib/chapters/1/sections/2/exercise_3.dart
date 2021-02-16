import 'package:algo/chapters/1/sections/2/exercise_3_cli.dart';
import 'package:flutter/material.dart';

import '../../../../commons/slider_widget.dart';

class Exercise3 extends StatefulWidget {
  @override
  _Exercise3State createState() => _Exercise3State();
}

class _Exercise3State extends State<Exercise3> {
  int n = 1;
  int min = 0;
  int max = 20;
  Answer3 answer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SliderWidget(
                min: 1,
                max: 20,
                divisions: 20,
                value: n,
                onChangeValue: (newValue) =>
                    setState(() => n = newValue.toInt()),
                label: 'n'),
            SliderWidget(
                min: 0,
                max: max.toDouble(),
                divisions: 20,
                value: min,
                onChangeValue: (newValue) =>
                    setState(() => min = newValue.toInt()),
                label: 'min'),
            SliderWidget(
                min: min.toDouble(),
                max: 20,
                divisions: 20,
                value: max,
                onChangeValue: (newValue) =>
                    setState(() => max = newValue.toInt()),
                label: 'max'),
            ElevatedButton(
              onPressed: _generateAnswer,
              child: Text('Calculate answer'),
            ),
            if (answer != null)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: LayoutBuilder(
                    builder: (context, constraints) => CustomPaint(
                      size: constraints.biggest,
                      painter: _CustomPainter(answer),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _generateAnswer() {
    final answer = Answer3.fromArgs(n: n, min: min, max: max);
    setState(() {
      this.answer = answer;
    });
  }
}

class _CustomPainter extends CustomPainter {
  final Answer3 answer;

  _CustomPainter(this.answer);

  @override
  paint(Canvas canvas, Size size) {
    Paint normalPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Paint intersectedPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Paint containedPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final y = (size.width) / 20;
    final x = (size.height) / 20;

    for (final info in answer.intervals) {
      Rect rect = Rect.fromLTRB(
        info.interval.x.min * x,
        info.interval.y.max * y,
        info.interval.x.max * x,
        info.interval.y.min * y,
      );
      if (info.isContained) {
        canvas.drawRect(rect, containedPaint);
      } else if (info.isIntersected) {
        canvas.drawRect(rect, intersectedPaint);
      } else {
        canvas.drawRect(rect, normalPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
