import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextButton(
          child: Text('Exercise 31'),
          onPressed: () => Navigator.of(context).pushNamed('31'),
        ),
      ],
    );
  }
}
