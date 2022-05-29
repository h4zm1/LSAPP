import 'dart:async';
import 'dart:developer';
import 'dart:io' as io;

import 'package:lsapp/DB/picture.dart';
import 'package:lsapp/DB/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, "dbase.db");
    //optional callback for _onCreate
    var openedDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return openedDB;
  }

  void _onCreate(Database db, int version) async {
    log("oncreate");
    await db.execute("CREATE TABLE Pictures(id INTEGER PRIMARY KEY, name TEXT, pic BLOB)");
    await db.execute("CREATE TABLE User(id INTEGER PRIMARY KEY, usage INTEGER , score INTEGER)");
  }

  void savePicture(Picture pic) async {
    log("savVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVvvvvee");
    var dbClient = await db;
    await dbClient!.insert("Pictures", pic.toMap());
  }

  Future<List<Picture>> getPictures() async {
    // log("getPICCCC");
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM Pictures');
    List<Picture> listPics = List.empty(growable: true);
    for (int i = 0; i < list.length; i++) {
      //create object Picture based on infos returned from database
      log("name:: " + list[i]["name"]);
      listPics.add(Picture(list[i]["name"], list[i]["pic"]));
    }
    return listPics;
  }

  void deleteAll() async {
    var dbClient = await db;
    int count = await dbClient!.rawDelete('DELETE FROM Pictures');
  }

  void updateUser(User user) async {
    var dbClient = await db;
    await dbClient!.insert("User", user.toMap());

    await dbClient.update("User", user.toMap(), where: 'id = ?', whereArgs: [0]);
  }

  Future getUser() async {
    var dbClient = await db;
    List<Map> userList = await dbClient!.rawQuery('SELECT * FROM User');
    User user = User(userList[0]["usage"], userList[0]["score"]);
    return user;
    // return user;
  }
}
