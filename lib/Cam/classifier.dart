import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/src/widgets/framework.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'recognition.dart';

class Classifier {
  late Interpreter _interpreter;

  late InterpreterOptions _interpreterOptions;

  late int padSize;

  static const String MODEL_FILE_NAME = "detect.tflite";
  static const String LABEL_FILE_NAME = "labelmap.txt";
  // static const String MODEL_FILE_NAME = "mobilenet.tflite";
  // static const String LABEL_FILE_NAME = "labels.txt";
  // static const String MODEL_FILE_NAME = "lite-model3.tflite";
  // static const String LABEL_FILE_NAME = "labelmap3.txt";

  /// Result score threshold
  static const double THRESHOLD = 0.6;

  /// Shapes of output tensors
  late List<List<int>> _outputShapes;

  /// Labels file loaded as list
  List<String>? _labels;

  /// Types of output tensors
  late List<TfLiteType> _outputTypes;

  /// Number of results to show
  static const int NUM_RESULTS = 10;

  ImageProcessor? imageProcessor;

  /// Input size of image (height = width = 300)
  static const int INPUT_SIZE = 300;

  Classifier({
    Interpreter? interpreter,
    List<String>? labels,
  }) {
    loadModel(interpreter: interpreter);
    loadLabels(labels: labels);
  }
  // / Loads interpreter from asset
  void loadModel({Interpreter? interpreter}) async {
    try {
      _interpreter = interpreter ??
          await Interpreter.fromAsset(
            MODEL_FILE_NAME,
            options: InterpreterOptions()..threads = 4,
          );
      var outputTensors = _interpreter.getOutputTensors();
      _outputShapes = [];
      _outputTypes = [];
      for (var tensor in outputTensors) {
        log('for each ' + tensor.name);
        _outputShapes.add(tensor.shape);
        _outputTypes.add(tensor.type);
      }
    } catch (e) {
      log("Error while creating interpreter: $e");
    }
  }

  /// Loads labels from assets
  void loadLabels({List<String>? labels}) async {
    try {
      _labels = labels ?? await FileUtil.loadLabels("assets/" + LABEL_FILE_NAME);
    } catch (e) {
      log("Error while loading labels: $e");
    }
  }

  TensorImage getProcessedImage(TensorImage inputImage) {
    padSize = math.max(inputImage.height, inputImage.width);
    imageProcessor ??= ImageProcessorBuilder().add(ResizeWithCropOrPadOp(padSize, padSize)).add(ResizeOp(INPUT_SIZE, INPUT_SIZE, ResizeMethod.BILINEAR)).build();
    inputImage = imageProcessor!.process(inputImage);
    return inputImage;
  }

  Map<String, dynamic>? predict(Image image, BuildContext context) {
    var predictStartTime = DateTime.now().millisecondsSinceEpoch;

    if (_interpreter == null) {
      log("Interpreter not initialized");
      return null;
    }

    var preProcessStart = DateTime.now().millisecondsSinceEpoch;

    // Create TensorImage from image
    TensorImage inputImage = TensorImage.fromImage(image);

    // Pre-process TensorImage
    inputImage = getProcessedImage(inputImage);

    var preProcessElapsedTime = DateTime.now().millisecondsSinceEpoch - preProcessStart;

    // TensorBuffers for output tensors
    TensorBuffer outputLocations = TensorBufferFloat(_outputShapes[0]);
    TensorBuffer outputClasses = TensorBufferFloat(_outputShapes[1]);
    TensorBuffer outputScores = TensorBufferFloat(_outputShapes[2]);
    TensorBuffer numLocations = TensorBufferFloat(_outputShapes[3]);

    // Inputs object for runForMultipleInputs
    // Use [TensorImage.buffer] or [TensorBuffer.buffer] to pass by reference
    List<Object> inputs = [inputImage.buffer];

    // Outputs map
    Map<int, Object> outputs = {
      0: outputLocations.buffer,
      1: outputClasses.buffer,
      2: outputScores.buffer,
      3: numLocations.buffer,
    };

    var inferenceTimeStart = DateTime.now().millisecondsSinceEpoch;

    // run inference
    _interpreter.runForMultipleInputs(inputs, outputs);

    var inferenceTimeElapsed = DateTime.now().millisecondsSinceEpoch - inferenceTimeStart;

    // Maximum number of results to show
    int resultsCount = math.min(NUM_RESULTS, numLocations.getIntValue(0));

    // Using labelOffset = 1 as ??? at index 0
    int labelOffset = 1;

    // Using bounding box utils for easy conversion of tensorbuffer to List<Rect>
    List<Rect> locations = BoundingBoxUtils.convert(
      tensor: outputLocations,
      valueIndex: [1, 0, 3, 2],
      boundingBoxAxis: 2,
      boundingBoxType: BoundingBoxType.BOUNDARIES,
      coordinateType: CoordinateType.RATIO,
      height: INPUT_SIZE,
      width: INPUT_SIZE,
      // width: INPUT_SIZE,
    );

    List<Recognition> recognitions = [];

    for (int i = 0; i < resultsCount; i++) {
      // Prediction score
      var score = outputScores.getDoubleValue(i);

      // Label string
      var labelIndex = outputClasses.getIntValue(i) + labelOffset;
      var label = labels!.elementAt(labelIndex);
      bool exist = false; //for testing existence
      if (score > THRESHOLD) {
        // inverse of rect
        // [locations] corresponds to the image size 300 X 300
        // inverseTransformRect transforms it our [inputImage]
        Rect transformedRect = imageProcessor!.inverseTransformRect(locations[i], image.height, image.width);

        //avoid having multiple boxes for one object
        //todo: pick the one with highest score
        if (recognitions.isEmpty) {
          recognitions.add(
            Recognition(i, label, score, transformedRect, context),
          );
          exist = true; //to avoid triggering "if (exist == false)" bellow
        } else {
          for (int j = 0; j < recognitions.length; j++) {
            if (recognitions[j].label == label) {
              //there's an object with the same label already exists
              exist = true;
            } else {
              //this won't only break from this loop but
              //the outside loop too, so if this break, the log bellow won't run
              break;
            }
          }
        }
        if (exist == false) {
          recognitions.add(
            Recognition(i, label, score, transformedRect, context),
          );
        }

        log('i ' + i.toString() + ' label ' + label + ' score ' + score.toString() + ' trans ' + transformedRect.toString());
      } else {}
    }

    var predictElapsedTime = DateTime.now().millisecondsSinceEpoch - predictStartTime;

    return {"recognitions": recognitions, "stats": predictElapsedTime, "inferenceTime": inferenceTimeElapsed, "preProcessingTime": preProcessElapsedTime, "inputImage": inputImage};
  }

  /// Gets the interpreter instance
  Interpreter get interpreter => _interpreter;
//   /// Gets the loaded labels
  List<String>? get labels => _labels;
}
