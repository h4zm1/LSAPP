import 'package:flutter/material.dart';
import 'package:lsapp/Quiz/SecondPage/second_page_content.dart';
import 'package:lsapp/Quiz/score_bar.dart';
import 'package:lsapp/Quiz/thirdPage/score_screen.dart';

class ThirdPage extends StatelessWidget {
  final int score;
  const ThirdPage(this.score, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
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
        body: Stack(
          //alignment: AlignmentDirectional.center,
          children: [
            Container(
              child: ScoreScreen(score),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                iconSize: mediaWidth * 0.15,
                icon: Image.asset('assets/backArrow.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, ani, ani1) => SecondPageContent(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
