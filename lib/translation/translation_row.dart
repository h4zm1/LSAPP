import 'package:flutter/material.dart';

class TranslationRow extends StatelessWidget {
  final text;
  final image;
  final function;
  TranslationRow(this.text, this.image, this.function);

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Container(
      height: mediaHeight * 0.1,
      width: mediaWidth * 0.7,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.65),
          borderRadius: BorderRadius.circular(20)),
      child: Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: mediaWidth * 0.2,
              height: mediaHeight * 0.1,
              child: Image(
                image: AssetImage(image),
                //onPressed: () {},
              ),
            ),
            Container(
              //padding: EdgeInsets.only(right: 3),
              width: mediaWidth * 0.32,
              height: mediaHeight * 0.1,
              child: Center(
                child: Wrap(children: [
                  SizedBox(
                    width: mediaWidth * 0.25,
                    height: mediaHeight * 0.02,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(text,
                          // softWrap: false,
                          style: const TextStyle(
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Color.fromRGBO(151, 151, 151, 1),
                                offset: Offset(0.05, 0.05),
                              ),
                            ],
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 25,
                            fontFamily: "Segoe UI Emoji",
                            //fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                ]),
              ),
            ),
            GestureDetector(
              onTap: function,
              child: Container(
                width: mediaWidth * 0.11,
                height: mediaHeight * 0.15,
                child: Image(
                  image: AssetImage('assets/play.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
