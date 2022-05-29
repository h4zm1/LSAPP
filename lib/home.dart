import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lsapp/image_container.dart';
import 'package:lsapp/score_variable.dart';

import 'DB/dbhelper.dart';
import 'DB/firebase.dart';
import 'DB/user.dart';
import 'menu/menu.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

int usageTracker = 0;
DateTime startDate = DateTime.now();

class _Home extends State<Home> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    DateTime dateOld = DateTime.parse("2020-01-08 00:00:00");
    DateTime dateNew = DateTime.parse("2020-01-10 02:00:00");
    switch (state) {
      case AppLifecycleState.resumed:
        Firebase.upload("online");
        break;
      case AppLifecycleState.inactive:
        Firebase.upload("offline");
        onClose();
        break;
      case AppLifecycleState.paused:
        Firebase.upload("offline");
        onClose();
        break;
      case AppLifecycleState.detached:
        Firebase.upload("offline");
        onClose();
        break;
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
    return (to.difference(from).inMinutes).round();
  }

  void onClose() {
    log("CLOSSSEEEE");
    DateTime closeDate = DateTime.now();
    log("USAGEEEEEEE:: " + daysBetween(startDate, closeDate).toString());
    // User user = User(0, 300);
    // var dbHelper = DBHelper();
    // dbHelper.saveUser(user);
  }

  Future load() async {
    var dbHelper = DBHelper();
    User user = await dbHelper.getUser();
    ScoreVar.score = user.score;
    // log("usage:: " + user.usage.toString() + " score:: " + user.score.toString());
  }

  @override
  void initState() {
    load();
    startDate = DateTime.now();
    log("startttt:  " + startDate.toString());
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Container(
      height: mediaHeight,
      width: mediaWidth,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
                height: mediaHeight * 0.7,
                width: mediaWidth * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ImageContainer("assets/Space_learn.png", mediaHeight * 0.4, mediaWidth * 0.8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()));
                      },
                      child: ImageContainer("assets/start.png", mediaHeight * 0.3, mediaWidth * 0.5),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
