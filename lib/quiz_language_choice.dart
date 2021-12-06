import 'package:flutter/material.dart';

import 'first.dart';
import 'french.dart';
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
                image: AssetImage("lib/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 150),
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
                margin: const EdgeInsets.only(right: 15, left: 15, top: 35),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Stack(children: [
                        Container(
                          height: 90,
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
                          top: 5,
                          left: 5,
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage('lib/images/england_flag.png'),
                          ),
                        ),
                        const Positioned(
                          top: 27,
                          left: 150,
                          child: Text("English",
                              style: TextStyle(
                                color: Color.fromRGBO(4, 18, 92, 1),
                                fontSize: 25,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                      ]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QuizMenu()),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      child: Stack(children: [
                        Container(
                          height: 90,
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
                          top: 5,
                          left: 5,
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage('lib/images/frensh_flag.png'),
                          ),
                        ),
                        const Positioned(
                          top: 27,
                          left: 150,
                          child: Text("French",
                              style: TextStyle(
                                color: Color.fromRGBO(4, 18, 92, 1),
                                fontSize: 25,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                      ]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => French()),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      child: Stack(children: [
                        Container(
                          height: 90,
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
                          top: 5,
                          left: 5,
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage('lib/images/arabic_flag.png'),
                          ),
                        ),
                        const Positioned(
                          top: 27,
                          left: 150,
                          child: Text("Arabic",
                              style: TextStyle(
                                color: Color.fromRGBO(4, 18, 92, 1),
                                fontSize: 25,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                      ]),
                      onTap: () {},
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
}
