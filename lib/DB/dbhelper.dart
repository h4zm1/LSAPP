import 'dart:asyncr';
import 'dart:io' as io;

import 'package:lsapp/DB/picture.dart';
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
    await db.execute("CREATE TABLE Pictures(id INTEGER PRIMARY KEY, name TEXT, pic BLOB)");
  }

  void savePicture(Picture pic) async {
    var dbClient = await db;
    await dbClient!.insert("Pictures", pic.toMap());
  }

  Future<List<Picture>> getPictures() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM Pictures');
    List<Picture> listPics = List.empty(growable: true);
    for (int i = 0; i < list.length; i++) {
      //create object Picture based on infos returned from database
      listPics.add(Picture(list[i]["name"], list[i]["pic"]));
    }
    return listPics;
  }

  void deleteAll() async {
    var dbClient = await db;
    int count = await dbClient!.rawDelete('DELETE FROM Pictures');
  }
}
