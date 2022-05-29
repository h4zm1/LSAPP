import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lsapp/DB/dbhelper.dart';
import 'package:lsapp/DB/picture.dart';
import 'package:lsapp/DB/user.dart';
import 'package:lsapp/Quiz/SecondPage/second_page_image.dart';
import 'package:lsapp/Quiz/thirdPage/third_page.dart';
import 'package:lsapp/answer.dart';
import 'package:lsapp/score_holder.dart';
import 'package:lsapp/score_variable.dart';

import '../quiz_home.dart';
import '../score_bar.dart';

class QuizScreen extends StatelessWidget {
  List<Picture> awaitList = [];
  List<String>? options = [];
  List<String>? track = []; //contains the correct answer each question refresh
  List<String>? selected = []; //contains the selected answer
  bool flag = true;
  Uint8List? file; //pic
  String? real; //pic name

  QuizScreen({
    Key? key,
    required this.awaitList,
  }) : super(key: key);

  void randQuiz(BuildContext context) async {
    // awaitList = await preLoad(context);
    scoreHolder.block = false; //unlock score after refresh
    bool exist = false;
    if (track!.isEmpty) {
      // log("TRACKKK ***  " + awaitList.length.toString());
      log("isEmpty");

      int random = getRandom(awaitList.length);
      file = awaitList[random].pic;
      real = awaitList[random].name;
      track!.add(real!);
    } else {
      log("isNOTEmpty");
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

  int getRandom(int max) {
    int min = 0;
    math.Random random = math.Random();
    int rand = min + random.nextInt(max - min);
    // int rand = random.nextInt(max) - min;
    log("RANDD::: " + rand.toString());
    return rand;
  }

  //get random-not-picked string from a list of string
  void getFakes(String real) {
    List list = ['Bicycle', 'Pencil', 'Jacket', 'Horse', 'Spoon', 'Banana', 'Balloon', 'Car', 'Monkey', 'Table', 'Clown', 'Bird', 'Shoes', 'Snow', 'Knife', 'Paper'];
    // log('length  ' + list.length.toString());
    log("getFakes");

    options!.add(list[getRandom(list.length - 1)]);
    bool exist = false;
    do {
      String rand = list[getRandom(list.length - 1)];
      if (options!.contains(rand)) {
        exist = true;
        log("IF");
      } else {
        log("ELSE");
        options!.add(rand);
        exist = false;
      }
    } while (options!.length < 2 || exist == true);
    int pos = getRandom(3);
    options!.insert(pos, real);
    log("2 fakes? :  " + options![0] + " " + options![1] + " " + options![2]);
  }

  // const QuizScreen({Key? key}) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    randQuiz(context);
    log("real**** " + real!);
    getFakes(real!); //get 2 fake random options and add them to a list with the real solution

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
              height: mediaHeight * 0.75,
              width: mediaWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SecondPageImage(file),
                  SizedBox(
                    height: 20,
                  ),
                  Column(children: [
                    Answer(
                      answerText: options![0],
                      valid: ((options![0] == real)) ? true : false,
                      answerTap: () {
                        log("1");
                      },
                    ),
                    Answer(
                      answerText: options![1],
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => build(context)));
                        // Navigator.push(context, new MaterialPageRoute(builder: (context) => this.build(context)));

                        options!.clear();
                        log("track:: " + track!.length.toString());
                        if (track!.length == 3) {
                          log("3333333333333333333333333");
                          int score = scoreHolder.currentScore;
                          ScoreVar.score = ScoreVar.score + scoreHolder.currentScore;
                          log("SCOREVAR:: " + ScoreVar.score.toString());
                          User user = User(0, ScoreVar.score);
                          var dbHelper = DBHelper();
                          dbHelper.updateUser(user);
                          scoreHolder.currentScore = 0;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage(score)));
                        }
                      },
                      child: Text('Next Question'),
                    ),
                  ]),
                  // SecondPageText(),
                  Expanded(child: Container())
                ],
              ),
            ),
            // Container(
            // child: QuizScreen(),
            // ),
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                iconSize: mediaWidth * 0.15,
                icon: Image.asset('assets/backArrow.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, ani, ani1) => QuizHome(),
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
