import 'package:flutter/material.dart';
import 'package:lsapp/Detection/detection_home.dart';
import 'package:lsapp/Quiz/quiz_home.dart';
import 'package:lsapp/Quiz/score_bar.dart';
import 'package:lsapp/menu/menu_button.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/back.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(13, 0, 46, 1),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset('assets/barButton.png'),
                onPressed: () {},
              );
            },
          ),
          actions: [
            IconButton(
              icon: Image.asset('assets/elien.png'),
              onPressed: () {},
            ),
            Scorebar(),
          ],
          leadingWidth: mediaWidth * 0.155,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: mediaHeight * 0.75,
              child: Column(children: [
                MenuButton("assets/detectionImage.png", "assets/detectionText.png", "assets/start.png", DetectionHome()),
                MenuButton("assets/quizImage.png", "assets/quizText.png", "assets/start.png", QuizHome()),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
