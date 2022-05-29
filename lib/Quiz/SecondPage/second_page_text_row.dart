import 'package:flutter/material.dart';

class SecondPageTextrow extends StatelessWidget {
  final text;
  SecondPageTextrow(
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    void getPage() {
      // Navigator.push(
      //   context,
      //   PageRouteBuilder(
      //     pageBuilder: (_, ani, ani1) => const ThirdPage(),
      //     transitionDuration: Duration(seconds: 0),
      //   ),
      // );
    }

    return GestureDetector(
      onTap: getPage,
      child: Container(
        height: mediaHeight * 0.07,
        width: mediaWidth * 0.5,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Container(
            height: mediaHeight * 0.05,
            width: mediaWidth * 0.45,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  text,
                  style: TextStyle(color: Color.fromRGBO(0, 125, 198, 1), fontFamily: "Segoe UI Emoji"),
                )),
          ),
        ),
      ),
    );
  }
}
