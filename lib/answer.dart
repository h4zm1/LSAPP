import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lsapp/score_holder.dart';

class Answer extends StatefulWidget {
  final String? answerText;
  final Color? answerColor;
  final Function()? answerTap;
  final bool? valid;
  Answer({this.answerText, this.answerColor, this.answerTap, this.valid});
  @override
  _answer createState() => _answer();
}

class _answer extends State<Answer> {
  int x = 1;
  bool click = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !click ? widget.answerTap : null,
      onTapDown: (TapDownDetails details) {
        setState(() {
          if (scoreHolder.block == false) {
            //if not blocked
            if (widget.valid == true) {
              scoreHolder.currentScore = scoreHolder.currentScore + 50;
            }
            log("SCORE  BLOCK");
            scoreHolder.block = true; //block after finishing
          }
          click = !click;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: (click == false)
              ? Colors.white70
              : ((widget.valid == true))
                  ? Colors.green
                  : Colors.red,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          widget.answerText!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}
