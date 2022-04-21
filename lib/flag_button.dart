import 'package:flutter/material.dart';

class FlagButton extends StatelessWidget {
  final String? text;
  final String? flag;
  final Function()? onTap;

  const FlagButton({Key? key, this.text, this.flag, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTap: onTap,
        child: Container(
      //padding: EdgeInsets.only(left: 20),
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Container(
              height: 90,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Positioned(
                          child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                          image: DecorationImage(
                            image: AssetImage(
                              'lib/images/$flag',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
                      Text(text!,
                          style: const TextStyle(
                            color: Color.fromRGBO(4, 18, 92, 1),
                            fontSize: 25,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w700,
                          )),
                      Container(
                        width: 35,
                        height: 35,
                        child: RawMaterialButton(
                          elevation: 0.0,
                          shape: CircleBorder(),
                          fillColor: Color.fromRGBO(251, 83, 117, 1),
                          child: Center(
                            child: Icon(
                              Icons.speaker,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: onTap,
                        ),
                      ),
                    ]),
                  )
                ],
              )),
        ),
      ]),
    ));
  }
}
