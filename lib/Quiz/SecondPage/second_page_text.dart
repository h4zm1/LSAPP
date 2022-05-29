import 'package:flutter/material.dart';
import 'package:lsapp/Quiz/SecondPage/second_page_text_row.dart';

class SecondPageText extends StatelessWidget {
  SecondPageText();

  @override
  Widget build(BuildContext context) {
    String? text = "stylo";
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Container(
        width: mediaWidth * 0.5,
        height: mediaHeight * 0.28,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SecondPageTextrow(
                text,
              ),
              SecondPageTextrow(
                text,
              ),
              SecondPageTextrow(
                text,
              )
            ],
          ),
        ));
  }
}
