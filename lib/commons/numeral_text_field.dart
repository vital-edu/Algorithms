import 'package:flutter/material.dart';

class NumeralTextField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final int maxValue;
  final String labelText;
  final void Function(int value) onUpdateValue;
  final String value;

  NumeralTextField(
      {int maxValue = 100,
      @required this.labelText,
      @required this.onUpdateValue,
      @required String value})
      : this.maxValue = maxValue.abs(),
        this.value = value {
    this._controller.value = TextEditingValue(
      text: value,
      selection: TextSelection(
        baseOffset: value.length,
        extentOffset: value.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: labelText),
      keyboardType: TextInputType.number,
      controller: _controller,
      onChanged: (String value) {
        int parsedValue = int.tryParse(value);
        if (parsedValue == null || parsedValue > maxValue) {
          final validText = value.substring(0, value.length - 1);
          _controller.text = validText;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: value.length),
          );
        } else {
          onUpdateValue(parsedValue);
        }
      },
    );
  }
}
