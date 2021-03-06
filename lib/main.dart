import 'package:flutter/material.dart';

import 'chapters/1/sections/1/exercise_31.dart';
import 'chapters/1/sections/1/exercise_32.dart';
import 'chapters/1/sections/2/exercise_1.dart';
import 'chapters/1/sections/2/exercise_10.dart';
import 'chapters/1/sections/2/exercise_3.dart';
import 'menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Algorithms'),
        ),
        body: MenuWidget(),
      ),
      routes: {
        '31': (_) => Exercise31(),
        '32': (_) => Exercise32(),
        '1': (_) => Exercise1(),
        '3': (_) => Exercise3(),
        '10': (_) => Exercise10(),
        'menu': (_) => MenuWidget(),
      },
    );
  }
}
