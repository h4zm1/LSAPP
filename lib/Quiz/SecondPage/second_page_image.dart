import 'dart:typed_data';

import 'package:flutter/material.dart';

class SecondPageImage extends StatelessWidget {
  // final imageAdress;
  SecondPageImage(this.file);
  Uint8List? file;
  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Center(
          child: Container(
            width: mediaWidth * 0.7,
            height: mediaHeight * 0.37,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/blue.png"), fit: BoxFit.contain)),
            child: Center(
              child: Container(
                width: mediaWidth * 0.5,
                height: mediaHeight * 0.3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.memory(file!,
                    // image: AssetImage(imageAdress),
                    fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
