import 'package:flutter/material.dart';
import 'package:lsapp/menu/menu.dart';

import '../image_container.dart';
import 'buttons_row.dart';

class StartPage extends StatelessWidget {
  final imageFromCamera;
  final imageFromGallery;
  const StartPage(
    this.imageFromCamera,
    this.imageFromGallery,
  );

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      Align(
        alignment: Alignment.center,
        child: ImageContainer("assets/pleaseText.png", mediaHeight * 0.15, mediaWidth * 0.85),
      ),
      Container(
        width: mediaWidth,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ButtonsRow(imageFromCamera, imageFromGallery, Menu()),
        ),
      )
    ]);
  }
}
