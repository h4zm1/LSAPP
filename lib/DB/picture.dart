import 'dart:typed_data';

class Picture {
  late String name;
  late Uint8List pic;

  Picture(this.name, this.pic);

  Picture.fromMap(Map map) {
    name = map[name];
    pic = map[pic];
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "pic": pic,
      };
}
