import 'package:flutter/material.dart';

import 'img_button.dart';

class FirstPageContent extends StatelessWidget {
  final widget;
  FirstPageContent(this.widget);

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: mediaHeight * 0.6,
        width: mediaWidth * 0.8,
        child: Column(
          children: [
            Container(
              height: mediaHeight * 0.53,
              width: mediaWidth * 0.8,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/blue.png"), fit: BoxFit.contain),
              ),
              child: Center(
                child: Container(
                  height: mediaHeight * 0.5,
                  padding: EdgeInsets.only(top: 40, bottom: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImgButton('assets/arabe.png', widget),
                      ImgButton('assets/eng.png', widget),
                      ImgButton('assets/frc.png', widget),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
