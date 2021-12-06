import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text(
          'QUIZ TIME',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
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
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '${widget.totalScore.toString()}/${_questions.length}',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Text(
                    widget.totalScore > 0 ? 'Congratulations! Your final score is: ${widget.totalScore}' : 'Your final score is: ${widget.totalScore}. Better luck next time!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: widget.totalScore > 4 ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
            ],
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
