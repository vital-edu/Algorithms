import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Center(child: Text('Section 1')),
          _MenuItem('31'),
          _MenuItem('32'),
          Divider(),
          Center(child: Text('Section 2')),
          _MenuItem('1'),
          _MenuItem('3'),
          _MenuItem('10'),
        ],
      ),
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
