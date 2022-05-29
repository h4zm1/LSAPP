import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import 'DB/dbhelper.dart';
import 'DB/firebase.dart';
import 'DB/user.dart';
import 'home.dart';

//importing splash_screen.dart file

var uuid = Uuid();
final databaseRef = FirebaseDatabase.instance.reference();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );

  const oneSec = Duration(seconds: 10);
  Firebase.upload("online");
  Timer.periodic(oneSec, (Timer t) => {Firebase.upload("online")});

  // databaseRef.reference().onChildAdded.listen((event) {
  //   log("status: " + event.snapshot.value["status"]);
  // });

  // databaseRef.reference().once().
  // push2DataBase(666, 200);
  getUser();
  runApp(MyApp());
  DateTime dateOld = DateTime.parse("2020-01-08 00:00:00");
  DateTime dateNew = DateTime.parse("2020-01-10 02:00:00");

  log("date:: " + daysBetween(dateOld, dateNew).toString());
}

Future getUser() async {
  log("aaaaaaaaa");
  var dbHelper = DBHelper();
  User user = await dbHelper.getUser();

  log("usage:: " + user.usage.toString() + " score:: " + user.score.toString());
}

void push2DataBase(int usage, int score) {
  User user = User(usage, score);
  var dbHelper = DBHelper();
  dbHelper.updateUser(user);
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day, from.hour);
  to = DateTime(to.year, to.month, to.day, to.hour);
  return (to.difference(from).inHours).round();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
