import 'package:flutter/material.dart';
import 'package:lsapp/Quiz/quiz_home.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  ScoreScreen(this.score);

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Container(
      height: mediaHeight * 0.8,
      child: Stack(children: [
        Center(
          child: Container(
              height: mediaHeight * 0.56,
              width: mediaWidth * 0.9,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      iconSize: mediaWidth * 0.12,
                      icon: Image.asset('assets/close.png'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      /* padding: EdgeInsets.only(
                          left: 10, right: 10, top: 40, bottom: 40),*/
                      height: mediaHeight * 0.5,
                      width: mediaWidth * 0.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/blue.png"), fit: BoxFit.contain),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  "LEVEL COMPLETE",
                                  style: TextStyle(color: Colors.white, fontFamily: "Segoe UI Emoji", fontSize: 18, fontWeight: FontWeight.w900),
                                )),
                          ),
                          SizedBox(
                            height: mediaHeight * 0.05,
                          ),
                          Container(
                            height: mediaHeight * 0.1,
                            width: mediaWidth * 0.4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/coins.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                  width: mediaWidth * 0.25,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      score.toString(),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: mediaHeight * 0.15,
                      width: mediaWidth * 0.6,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/stars.png"), fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, ani, ani1) => QuizHome(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      child: Container(
                        height: mediaHeight * 0.1,
                        width: mediaWidth * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/next.png"), fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ]),
    );
  }
}
