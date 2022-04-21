import 'package:flutter/material.dart';
import 'learn_menu.dart';
import 'quiz_language_choice.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 150, left: 5),
                child: InkWell(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(bottom: 25),
                          width: 330,
                          height: 220,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromRGBO(251, 83, 117, 1)),
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            // ignore: prefer_const_constructors
                            child: Text("Learn",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w800,
                                )),
                          )),
                      Positioned(
                        top: -130,
                        left: 50,
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('lib/images/book.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LearMenu()),
                    );
                  },
                ),
              ),
              Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.only(left: 5, bottom: 15),
                child: InkWell(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(bottom: 25),
                          width: 330,
                          height: 220,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromRGBO(69, 134, 201, 1)),
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            // ignore: prefer_const_constructors
                            child: Text("Quiz",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w800,
                                )),
                          )),
                      Positioned(
                        top: -130,
                        left: 50,
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('lib/images/clock.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuizLanguageChoice()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
