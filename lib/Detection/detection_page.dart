import 'package:flutter/material.dart';
import 'package:lsapp/Detection/detection_home.dart';

import 'buttons_row.dart';

class DtetectionPage extends StatelessWidget {
  final imageFromCamera;
  final imageFromGallery;
  final image;
  DtetectionPage(this.imageFromCamera, this.imageFromGallery, this.image);

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      Align(
        alignment: Alignment.center,
        child: Container(
          width: mediaWidth,
          height: mediaHeight * 0.75,
          child: image,
        ),
      ),
      Container(
        width: mediaWidth,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ButtonsRow(imageFromCamera, imageFromGallery, DetectionHome()),
        ),
      )
    ]);
  }
}
