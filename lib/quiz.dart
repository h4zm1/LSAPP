import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lsapp/answer.dart';
import 'package:lsapp/score.dart';
import 'package:lsapp/score_holder.dart';

import 'DB/picture.dart';

class Quiz extends StatelessWidget {
  List<Picture> awaitList;
  List<String>? options = [];
  List<String>? track = []; //contains the correct answer each quetion refresh
  List<String>? selected = []; //contains the selected answer
  bool flag = true;
  Uint8List? file; //pic
  String? real; //pic name
  Quiz({
    Key? key,
    required this.awaitList,
  }) : super(key: key);

  void randQuiz(BuildContext context) {
    scoreHolder.block = false; //unlock score after refresh
    bool exist = false;
    if (track!.isEmpty) {
      int random = getRandom(awaitList.length);
      file = awaitList[random].pic;
      real = awaitList[random].name;
      track!.add(real!);
    } else {
      do {
        int random = getRandom(awaitList.length);
        String temp = awaitList[random].name;
        if (track!.contains(temp)) {
          exist = true;
          if (track!.length == awaitList.length) {
            break;
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizLanguageChoice()));
          }
        } else {
          exist = false;
          file = awaitList[random].pic;
          real = awaitList[random].name;
          track!.add(real!);
        }
      } while (exist == true);
    }
  }

  @override
  Widget build(BuildContext context) {
    randQuiz(context);
    log("real**** " + real!);
    getFakes(real!);

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/images/quiz_b.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(children: [
          SizedBox(height: 100),
          Container(
            width: double.infinity,
            height: 440.0,
            margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.brown[50],
              borderRadius: BorderRadius.circular(10.0),
            ),
          )
        ]),
        Container(),
        Column(children: [
          SizedBox(height: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SizedBox(height: 80),
              Image.memory(
                file!,
                fit: BoxFit.cover,
                height: 400,
                width: 300,
                alignment: Alignment.center,
              ),
            ],
          ),
          SizedBox(height: 30),
          Answer(
            answerText: options![0],
            valid: ((options![0] == real)) ? true : false,
            answerTap: () {
              log("1");
            },
          ),
          Answer(
            answerText: options![1],
            // answerColor: Changer.color,
            valid: ((options![1] == real)) ? true : false,
            answerTap: () {
              log("2");
            },
          ),
          Answer(
            answerText: options![2],
            valid: ((options![2] == real)) ? true : false,
            answerTap: () {
              log("3");
            },
          ),
          SizedBox(height: 40.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.lightBlue[800]),
            ),
            onPressed: () {
              log("SCORRREEE  " + scoreHolder.currentScore.toString());
              Navigator.push(context, new MaterialPageRoute(builder: (context) => this.build(context)));
              options!.clear();
              if (track!.length == 3) {
                // log("SCORRREEE  " + scoreHolder.currentScore.toString());
                int scor = scoreHolder.currentScore;
                scoreHolder.currentScore = 0;
                Navigator.push(context, MaterialPageRoute(builder: (context) => Scor(scor)));
              }

              // if (!answerWasSelected) {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text('Please select an answer before going to the next question'),
              //   ));
              //   return;
              // }
              // _nextQuestion();
            },
            child: Text('Next Question'),
          ),
        ]),
      ],
    ));
  }

  int getRandom(int max) {
    int min = 0;
    math.Random random = math.Random();
    int rand = min + random.nextInt(max - min);
    return rand;
  }

  //get random-not-picked string from a list of string
  void getFakes(String real) {
    List list = ['Bicycle', 'Pencil', 'Jacket', 'Horse', 'Spoon', 'Banana', 'Balloon', 'Car', 'Monkey', 'Table', 'Clown', 'Bird', 'Shoes', 'Snow', 'Knife', 'Paper'];
    log('length  ' + list.length.toString());
    options!.add(list[getRandom(list.length - 1)]);
    bool exist = false;
    do {
      String rand = list[getRandom(list.length - 1)];
      if (options!.contains(rand)) {
        exist = true;
        log("IF");
      } else {
        options!.add(rand);
        exist = false;
        log("ELSE");
      }
    } while (options!.length < 2 || exist == true);
    int pos = getRandom(3);
    options!.insert(pos, real);
    log("2 fakes? :  " + options![0] + " " + options![1] + " " + options![2]);
  }
}
