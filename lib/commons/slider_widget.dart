import 'package:flutter/material.dart';

class SliderWidget<T> extends StatelessWidget {
  final double min, max;
  final T value;
  final int divisions;
  final String label;
  final void Function(double) onChangeValue;
  SliderWidget({
    @required this.min,
    @required this.max,
    @required this.divisions,
    @required this.value,
    @required this.onChangeValue,
    @required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            child: Text(label),
            width: 10 * label.toString().length.toDouble(),
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
            width: 10 * value.toString().length.toDouble(),
          ),
        ],
      ),
    );
  }
}
