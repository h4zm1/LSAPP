import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lsapp/quiz.dart';
import 'package:lsapp/score_holder.dart';

import 'DB/dbhelper.dart';
import 'DB/picture.dart';
import 'first.dart';
import 'quiz_menu.dart';

class QuizLanguageChoice extends StatelessWidget {
  const QuizLanguageChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/quiz_menu_L.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15, top: 277),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/images/english.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Stack(children: [
                        Container(
                          height: 60,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ]),
                      onTap: () {
                        _testPreview(context);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15, top: 47),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/images/french.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Stack(children: [
                        Container(
                          height: 60,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QuizMenu()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15, top: 35),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/images/arabic.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Stack(children: [
                        Container(
                          height: 60,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QuizMenu()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(left: 15),
                  child: InkWell(
                    child: const CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage('lib/images/blue_return_arrow.png'),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const First()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _testPreview(BuildContext context) async {
    scoreHolder.currentScore = 0;
    var dbHelper = DBHelper();
    Future<List<Picture>> listPics = dbHelper.getPictures();
    List<Picture> awaitList = await listPics;

    Uint8List file = awaitList[1].pic;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Quiz(
          awaitList: awaitList,
        ),
      ),
    );
  }
}
