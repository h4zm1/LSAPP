import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lsapp/recognition.dart';

/// Individual bounding box
class BoxWidget extends StatelessWidget {
  final Recognition result;

  const BoxWidget({Key? key, required this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Color for bounding box
    Color color = Colors.primaries[(result.label.length + result.label.codeUnitAt(0) + result.id) % Colors.primaries.length];

    return Positioned(
      left: result.renderLocation.left,
      top: result.renderLocation.top,
      width: result.renderLocation.width,
      height: result.renderLocation.height,
      child: Container(
        width: result.renderLocation.width,
        height: result.renderLocation.height,
        decoration: BoxDecoration(border: Border.all(color: color, width: 3), borderRadius: BorderRadius.all(Radius.circular(3))),
        child: Align(
          alignment: Alignment.topLeft, //text position inside the box
          child: FittedBox(
            child: Container(
              color: color,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text("English"),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text("Français"),
                      ),
                    ],
                    child: Text(
                      result.label,
                      textScaleFactor: 3.5,
                    ),
                    color: color,
                    // offset: Offset((result.renderLocation.top) / 2, 55),
                    offset: const Offset(-3, 57),

                    // offset: const Offset(-15, 55),
                    // elevation: 1,
                    // shape: OutlineInputBorder(borderSide: BorderSide(color: color, width: 2)),
                    onSelected: (value) {
                      log("value:$value");
                    },
                    // Text(" " + result.score.toStringAsFixed(2)),
                  ),
                  // Text(result.label),
                  // Text(" " + result.score.toStringAsFixed(2)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
