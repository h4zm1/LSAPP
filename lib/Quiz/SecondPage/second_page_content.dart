import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lsapp/DB/dbhelper.dart';
import 'package:lsapp/DB/picture.dart';
import 'package:lsapp/Quiz/SecondPage/quiz_screen.dart';

class SecondPageContent extends StatelessWidget {
  SecondPageContent();
  List<Picture> awaitList = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _testPreview(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }
          final data = snapshot.data;
          // log("LEEENNN***  " + awaitList.length.toString());
          if (awaitList.isEmpty) {
            log("************EMPTY DATABASE***************");
            return Text("data");
          } else {
            return QuizScreen(awaitList: awaitList);
          }
        });
  }

  Future _testPreview(BuildContext context) async {
    var dbHelper = DBHelper();
    Future<List<Picture>> listPics = dbHelper.getPictures();
    awaitList = await listPics;
    // log("awaitttt");
    // Uint8List file = awaitList[1].pic;
    // await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => Quiz(
    //       awaitList: awaitList,
    //     ),
    //   ),
    // );
  }
}
