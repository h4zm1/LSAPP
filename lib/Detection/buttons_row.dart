import 'package:flutter/material.dart';

class ButtonsRow extends StatelessWidget {
  final imageFromCamera;
  final imageFromGallery;
  final page;
  ButtonsRow(this.imageFromCamera, this.imageFromGallery, this.page);

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Container(
      width: mediaWidth * 0.9,
      child: Stack(
        children: [
          Container(
            child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                //mainAxisAlignment: MainAxisAlignment.end,
                // mainalignment: Alignment.bottomCenter,
                children: [
                  IconButton(
                    iconSize: mediaWidth * 0.15,
                    icon: Image.asset('assets/backArrow.png'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => page),
                      );
                    },
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      IconButton(
                        iconSize: mediaWidth * 0.15,
                        icon: Image.asset('assets/cam.png'),
                        onPressed: () => imageFromCamera(),
                      ),
                      IconButton(
                        iconSize: mediaWidth * 0.15,
                        icon: Image.asset('assets/gallery.png'),
                        onPressed: () => imageFromGallery(),
                      ),
                    ],
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
