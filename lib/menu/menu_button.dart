import 'package:flutter/material.dart';

import '../image_container.dart';

class MenuButton extends StatelessWidget {
  final image;
  final text;
  final button;
  final widget;
  MenuButton(this.image, this.text, this.button, this.widget);

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

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          //padding: EdgeInsets.only(top: 90),
          width: mediaWidth * 0.7,
          height: mediaHeight * 0.35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/blueBack.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: mediaWidth * 0.6,
            height: mediaHeight * 0.3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  ImageContainer(image, mediaHeight * 0.12, mediaWidth * 0.5),
                  ImageContainer(text, mediaHeight * 0.12, mediaWidth * 0.4),
                ],
              ),
            ),
          ),
          GestureDetector(
              onTap: getPage,
              child:
                  ImageContainer(button, mediaHeight * 0.06, mediaWidth * 0.3)),
        ]),
      ],
    );
  }
}
