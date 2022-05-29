import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String adress;
  final imageWidth;
  final imageHeight;

  ImageContainer(this.adress, this.imageHeight, this.imageWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: imageWidth,
        height: imageHeight,
        child: Image(
          image: AssetImage(adress),
          fit: BoxFit.contain,
        ));
  }
}
