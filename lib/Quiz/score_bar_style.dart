import 'package:flutter/material.dart';

import '../score_variable.dart';

class ScoreBarStyle extends StatelessWidget {
  ScoreBarStyle();

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: mediaWidth * 0.16),
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: mediaWidth * 0.1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ScoreVar.score.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Segoe UI Emoji",
                    //fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
