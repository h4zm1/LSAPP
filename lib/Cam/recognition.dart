import 'dart:math';

import 'package:flutter/cupertino.dart';
// import 'package:object_detection/ui/camera_view_singleton.dart';

/// Represents the recognition output from the model
class Recognition {
  /// Index of the result
  int _id;

  /// Label of the result
  String _label;

  /// Confidence [0.0, 1.0]
  double _score;

  /// Location of bounding box rect
  ///
  /// The rectangle corresponds to the raw input image
  /// passed for inference
  Rect _location;

  BuildContext context;
  Recognition(this._id, this._label, this._score, this._location, this.context);

  int get id => _id;

  String get label => _label;

  double get score => _score;

  Rect get location => _location;

  /// Returns bounding box rectangle corresponding to the
  /// displayed image on screen
  ///
  /// This is the actual location where rectangle is rendered on
  /// the screen
  Rect get renderLocation {
    // ratioX = screenWidth / imageInputWidth
    // ratioY = ratioX if image fits screenWidth with aspectRatio = constant
    // double ratioX = CameraViewSingleton.ratio;
    // Size screenSize = MediaQuery.of(context).size;
    // double ratioX = screenSize.width / screenSize.height;
    double ratioX = (location.width / location.height);
    Size actualPreviewSize = Size(location.width, location.width * ratioX);
    double ratioY = ratioX;

    double transLeft = max(0.1, location.left * ratioX);
    double transTop = max(0.1, location.top * ratioY);
    double transWidth = min(location.width * ratioX, actualPreviewSize.width);
    double transHeight = min(location.height * ratioY, actualPreviewSize.height);

    Rect transformedRect = Rect.fromLTWH(transLeft, transTop, transWidth, transHeight);
    return transformedRect;
  }

  @override
  String toString() {
    return 'Recognition(id: $id, label: $label, score: $score, location: $location)';
  }
}