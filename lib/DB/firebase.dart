import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
final databaseRef = FirebaseDatabase.instance.reference();

class Firebase {
  static void upload(String status) {
    DateTime now;
    String date;
    now = DateTime.now();
    date = now.toString().substring(0, 19);
    int dateInMs = now.microsecondsSinceEpoch;
    uuid.v4();
    databaseRef.child(uuid.v4()).set({'status': status, 'time': date.toString()});
    // log("uploaddddddd");
  }
}
