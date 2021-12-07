import 'package:flutter/material.dart';

import 'first.dart';

class Scor extends StatefulWidget {
  int totalScore = 0;
  Scor(this.totalScore);
  @override
  _ScorState createState() => _ScorState();
}

class _ScorState extends State<Scor> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;

  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct

      //when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

/////////////////////////

///////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/score.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0, left: 114.0, right: 50.0, top: 530.0),
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            //padding: EdgeInsets.all(20.0),
            child: Text(
              '${widget.totalScore.toString()}/${3}',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            child: Stack(children: [
              Container(
                height: 90,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10.0, left: 47.0, right: 50.0, top: 600.0),
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/images/home_button.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => First()),
              );
            },
          ),
        ],
      ),
    );
  }
}

final _questions = const [
  {
    'question': 'hh?',
    'answers': [
      {'answerText': 'window', 'score': false},
      {'answerText': 'pen', 'score': true},
      {'answerText': 'door', 'score': false},
    ],
  },
  {
    'question': 'lala?',
    'answers': [
      {'answerText': 'bottle', 'score': true},
      {'answerText': 'glass', 'score': false},
      {'answerText': 'key', 'score': false},
    ],
  },
];
/*   child: Text(
                widget.totalScore > 0
                    ? 'Congratulations! Your final score is: ${widget.totalScore}'
                    : 'Your final score is: ${widget.totalScore}. Better luck next time!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: widget.totalScore > 4 ? Colors.green : Colors.red,
                ),
              ), */
