import 'package:flutter/material.dart';

class ImgButton extends StatelessWidget {
  final img;
  final widget;
  ImgButton(this.img, this.widget);

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    void getPage() {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, ani, ani1) => widget,
          transitionDuration: Duration(seconds: 0),
        ),
      );
    }

    return GestureDetector(
      onTap: getPage,
      child: Container(
        height: mediaHeight * 0.1,
        width: mediaWidth * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.contain),
        ),
      ),
    );
  }
}
