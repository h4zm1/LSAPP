import 'package:flutter/material.dart';

import 'answer.dart';
import 'score.dart';

class French extends StatefulWidget {
  @override
  _FrenchState createState() => _FrenchState();
}

class _FrenchState extends State<French> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      // adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : Icon(
                Icons.clear,
                color: Colors.red,
              ),
      );
      //when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
        _navigateToNextScreen(context);
      }
    });
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scor(_totalScore)));
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz go to score page !!!!!!
    if (_questionIndex >= _questions.length) {
      _navigateToNextScreen(context);
    }
  }

/////////////////////////
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

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
              Row(
                children: [
                  SizedBox(
                    height: 100.0,
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 140.0,
                margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    _questions[_questionIndex]['question'].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>).map(
                (answer) => Answer(
                  answerText: answer['answerText'].toString(),
                  answerColor: answerWasSelected
                      ? answer['score'] != null
                          ? Colors.green
                          : Colors.red
                      : null,
                  answerTap: () {
                    // if answer was already selected then nothing happens onTap
                    if (answerWasSelected) {
                      return;
                    }
                    //answer is being selected
                    // _questionAnswered(answer['score']);
                    _questionAnswered(false);
                  },
                ),
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40.0),
                ),
                onPressed: () {
                  if (!answerWasSelected) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please select an answer before going to the next question'),
                    ));
                    return;
                  }
                  _nextQuestion();
                },
                child: Text('Next Question'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final _questions = [
  {
    'question': 'stylo',
    'answers': [
      {'answerText': 'fenetre', 'score': false},
      {'answerText': 'stylo', 'score': true},
      {'answerText': 'porte', 'score': false},
    ],
  },
  {
    'question': 'une verre',
    'answers': [
      {'answerText': 'une verre', 'score': true},
      {'answerText': 'chaise', 'score': false},
      {'answerText': 'calculatrice', 'score': false},
    ],
  },
];
