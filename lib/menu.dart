import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _MenuItem('31'),
        _MenuItem('32'),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String exercise;

  _MenuItem(this.exercise);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('Exercise $exercise'),
      onPressed: () => Navigator.of(context).pushNamed(exercise),
    );
  }
}
