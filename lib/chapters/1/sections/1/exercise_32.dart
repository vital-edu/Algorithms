// Random connections. Write a program that takes as command-line arguments an
// integer N and a double value p (between 0 and 1), plots N equally spaced dots
// of size .05 on the circumference of a circle, and then, with probability p
// for each pair of points, draws a gray line connecting them.

import 'package:algo/commons/slider_widget.dart';
import 'package:flutter/material.dart';

class Exercise32 extends StatefulWidget {
  @override
  _Exercise32State createState() => _Exercise32State();
}

class _Exercise32State extends State<Exercise32> {
  final node = FocusNode();
  int argN = 10;
  RangeValues range = const RangeValues(0, 100);
  ValueNotifier<List<int>> intervals = ValueNotifier([]);
  List<double> values = [
    23,
    50,
    10,
    99,
    18,
    23,
    98,
    84,
    11,
    10,
    48,
    77,
    13,
    54,
    98,
    77,
    77,
    68
  ];

  @override
  void initState() {
    super.initState();
    _updateIntervals();
  }

  void _changeRange(RangeValues range) => setState(() => this.range = range);
  void _changeN(double n) => setState(() => this.argN = n.toInt());

  void _onSubmitInput(String input) {
    List<double> values = input
        .split(' ')
        .map((e) => double.tryParse(e))
        .where((e) => e != null)
        .toList();
    setState(() => this.values = values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 80,
            ),
            RangeSlider(
              values: RangeValues(range.start, range.end),
              min: 0,
              max: 100,
              divisions: 10000,
              onChanged: _changeRange,
              labels: RangeLabels(
                range.start.toStringAsFixed(2),
                range.end.toStringAsFixed(2),
              ),
            ),
            SliderWidget(
              min: 1,
              max: 20,
              divisions: 100,
              value: argN,
              label: "N",
              onChangeValue: _changeN,
            ),
            TextField(
              onSubmitted: _onSubmitInput,
              controller: TextEditingController(text: values.join(' ')),
            ),
            ElevatedButton(
              child: Text('Generate Histogram'),
              onPressed: _updateIntervals,
            ),
            Center(
              child: CustomPaint(
                size: Size(400, 400),
                painter: _HistogramPainter(
                  context: context,
                  intervals: intervals,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateIntervals() {
    double delta = range.end - range.start;
    double boundary = delta / argN;

    List<int> intervals = List.filled(argN, 0);

    for (double value in values) {
      for (int i = 0; i < intervals.length; i++) {
        if (value >= i * boundary && value < (i + 1) * boundary) {
          intervals[i]++;
          break;
        }
      }
    }

    setState(() => this.intervals.value = intervals);
  }
}

class _HistogramPainter extends CustomPainter {
  ValueNotifier<List<int>> intervals;
  BuildContext context;

  _HistogramPainter({
    @required this.context,
    @required this.intervals,
  }) : super(repaint: intervals);

  @override
  void paint(Canvas canvas, Size size) {
    final double maxHeight = size.height;
    final double maxWidth = size.width;

    final List<int> intervals = this.intervals.value;

    final widthBoundary = maxWidth / intervals.length - 10;
    final heightBoundary = maxHeight / intervals.length;

    final Paint fillPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    final Paint strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final Paint linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset.zero,
      Offset(0, maxHeight),
      linePaint,
    );

    for (int i = 0; i < intervals.length; i++) {
      Rect rect = Rect.fromLTWH(
        i * widthBoundary,
        maxHeight - (heightBoundary * intervals[i]),
        widthBoundary,
        heightBoundary * intervals[i],
      );
      canvas.drawRect(rect, fillPaint);
      canvas.drawRect(rect, strokePaint);

      if (i == 0) continue;

      TextSpan span = TextSpan(
        text: i.toString(),
        style: TextStyle(
          color: Colors.black,
        ),
      );
      TextPainter textPainter = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          -12,
          (maxHeight - heightBoundary * i) - 8,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
