import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lsapp/quiz.dart';

import 'DB/dbhelper.dart';
import 'DB/picture.dart';
import 'quiz_language_choice.dart';

class QuizMenu extends StatelessWidget {
  const QuizMenu({Key? key}) : super(key: key);

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
                margin: const EdgeInsets.only(top: 145),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(left: 20 ),
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                      decoration: const BoxDecoration(color: Color.fromRGBO(69, 134, 201, 1)),
                    ),
                    const Positioned(
                      top: 30,
                      left: 160,
                      // ignore: prefer_const_constructors
                      child: Text("Quiz",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                    Positioned(
                      top: -120,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('lib/images/clock_menu.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 30,
                  bottom: 15,
                ),
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                        child: Stack(children: [
                          Container(
                            width: 150,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            top: 20,
                            left: 24.5,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage('lib/images/objects.png'),
                            ),
                          ),
                          const Positioned(
                            top: 127,
                            left: 28,
                            // ignore: prefer_const_constructors
                            child: Text("Objects",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                        ]),
                        onTap: () {
                          _testPreview(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Quiz()),
                          //   // MaterialPageRoute(builder: (context) => English()),
                          // );
                        },
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        child: Stack(children: [
                          Container(
                            width: 150,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            top: 20,
                            left: 24.5,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage('lib/images/shapes.png'),
                            ),
                          ),
                          const Positioned(
                            top: 127,
                            left: 28,
                            // ignore: prefer_const_constructors
                            child: Text("Shapes",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                        ]),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(
                        child: Stack(children: [
                          Container(
                            width: 150,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            top: 20,
                            left: 24.5,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage('lib/images/colors.png'),
                            ),
                          ),
                          const Positioned(
                            top: 127,
                            left: 28,
                            // ignore: prefer_const_constructors
                            child: Text("Colors",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                        ]),
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        child: Stack(children: [
                          Container(
                            width: 150,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            top: 20,
                            left: 24.5,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage('lib/images/numbers.png'),
                            ),
                          ),
                          const Positioned(
                            top: 127,
                            left: 28,
                            child: Text("Numbers",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                        ]),
                        onTap: () {},
                      )
                    ],
                  ),
                ]),
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
                        MaterialPageRoute(builder: (context) => const QuizLanguageChoice()),
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
