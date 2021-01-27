// Random connections. Write a program that takes as command-line arguments an
// integer N and a double value p (between 0 and 1), plots N equally spaced dots
// of size .05 on the circumference of a circle, and then, with probability p
// for each pair of points, draws a gray line connecting them.
import 'dart:math';
import 'package:flutter/material.dart';

class Exercise31 extends StatefulWidget {
  @override
  _Exercise31State createState() => _Exercise31State();
}

class _Exercise31State extends State<Exercise31> {
  List<bool> connections;
  int numberOfDots = 10;
  double probability = 0.5;
  final _random = Random();

  @override
  void initState() {
    this.connections = _generateConnections(
      numberOfDots: this.numberOfDots,
      probability: this.probability,
    );
    super.initState();
  }

  void _changeDots(double n) {
    setState(() {
      this.numberOfDots = n.toInt();
    });
  }

  void _changeProbability(double n) {
    setState(() {
      this.probability = n;
    });
  }

  void _repaintCircle() {
    setState(() {
      this.connections = _generateConnections(
        numberOfDots: numberOfDots,
        probability: probability,
      );
    });
  }

  double _sizeOfCircle(Size size) {
    return min(size.width, size.height) * 0.8;
  }

  List<bool> _generateConnections({int numberOfDots, double probability}) =>
      List.generate(numberOfDots, (_) => _random.nextDouble() <= probability);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _Slider(
              min: 1,
              max: 360,
              divisions: 360,
              value: numberOfDots,
              label: "Number of dots",
              onChangeValue: _changeDots,
            ),
            _Slider(
              min: 0,
              max: 1,
              divisions: 100,
              value: probability,
              label: "Probability",
              onChangeValue: _changeProbability,
            ),
            ElevatedButton(
              child: Text('Generate Circle'),
              onPressed: _repaintCircle,
            ),
            Container(
              width: _sizeOfCircle(MediaQuery.of(context).size),
              height: _sizeOfCircle(MediaQuery.of(context).size),
              child: CustomPaint(
                painter: _ConnectedCirclePainter(connections: connections),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Slider<T> extends StatelessWidget {
  final double min, max;
  final T value;
  final int divisions;
  final String label;
  final void Function(double) onChangeValue;
  _Slider({
    @required this.min,
    @required this.max,
    @required this.divisions,
    @required this.value,
    @required this.onChangeValue,
    @required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          child: Text(label),
          width: 110,
        ),
        Expanded(
          child: Slider(
            min: min,
            max: max,
            divisions: divisions,
            value: double.parse(value.toString()),
            onChanged: onChangeValue,
          ),
        ),
        SizedBox(
          child: Text(value.toString()),
          width: 35,
        ),
      ],
    );
  }
}

class _ConnectedCirclePainter extends CustomPainter {
  final random = Random();
  final List<bool> connections;

  _ConnectedCirclePainter({this.connections});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height,
    );

    final segmentSize = 360 / connections.length;
    final radians = pi / 180;

    for (int i = 0; i < connections.length; i++) {
      final sweepAngle = connections[i] ? radians * segmentSize : radians * 0.5;

      canvas.drawArc(rect, radians * i * segmentSize, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
