import 'package:flutter/material.dart';

import 'score_bar_style.dart';

class Scorebar extends StatelessWidget {
  const Scorebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      IconButton(
        iconSize: mediaWidth * 0.28,
        icon: Image.asset('assets/coins.png'),
        onPressed: () {},
      ),
      ScoreBarStyle(),
    ]);
  }
}
