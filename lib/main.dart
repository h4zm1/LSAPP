import 'package:flutter/material.dart';

import 'first.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz  App',
      theme: ThemeData(
        primaryColor: Color(0xFF55C1EF),
      ),
      home: First(),
    );
  }
}
