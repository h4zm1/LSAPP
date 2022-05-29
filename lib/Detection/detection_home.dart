import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lsapp/DB/dbhelper.dart';
import 'package:lsapp/DB/picture.dart';
import 'package:lsapp/Detection/detection_page.dart';
import 'package:lsapp/Detection/start_page.dart';
import 'package:lsapp/translation/translation_page.dart';
import 'package:tflite/tflite.dart';

class DetectionHome extends StatefulWidget {
  DetectionHome();

  @override
  State<DetectionHome> createState() => _DetectionHomeState();
}

class _DetectionHomeState extends State<DetectionHome> {
  File? _image;
  List? _recognitions;
  bool? _busy;
  double? _imageWidth, _imageHeight;
  File? refToImage;

  final picker = ImagePicker();

  // this function loads the model
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/models/ssd_mobilenet.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  // this function detects the objects on the image
  detectObject(File image) async {
    refToImage = image;
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path, // required
        model: "SSDMobileNet",
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.4, // defaults to 0.1
        numResultsPerClass: 10, // defaults to 5
        asynch: true // defaults to true
        );
    FileImage(image).resolve(const ImageConfiguration()).addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));
    setState(() {
      _recognitions = recognitions;
    });
  }

  @override
  void initState() {
    super.initState();
    _busy = true;
    loadTfModel().then((val) {
      {
        setState(() {
          _busy = false;
        });
      }
    });
  }

  List<Widget> renderBoxes(Size screen) {
    // screen = MediaQuery.of(context).size;
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight! / _imageHeight! * MediaQuery.of(context).size.height * 0.75;

    Color blue = Color.fromRGBO(255, 118, 88, 1);

    return _recognitions!.map((re) {
      if (re["confidenceInClass"] > 0.50) {
        push2DataBase(re["detectedClass"], refToImage!.readAsBytesSync());
        log(re["detectedClass"]);
        log(re["confidenceInClass"].toString());
      }
      log("run once");
      return Container(
        child: Positioned(
            left: re["rect"]["x"] * factorX,
            top: re["rect"]["y"] * factorY + MediaQuery.of(context).size.height * 0.1,
            width: re["rect"]["w"] * factorX,
            height: re["rect"]["h"] * factorY + MediaQuery.of(context).size.height * 0.036,
            child: ((re["confidenceInClass"] > 0.50))
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TranslationPage(re["detectedClass"])),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: blue,
                          width: 5,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            // Detected class
                            " ${re["detectedClass"]} ",
                            style: TextStyle(
                              background: Paint()..color = blue,
                              wordSpacing: 3,
                              color: Colors.white,
                              //fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container()),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    List<Widget> stackChildren = [];
    stackChildren.add(_image == null
        ? Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/back.png"), fit: BoxFit.cover),
            ),
            width: mediaWidth,
            child: StartPage(getImageFromCamera, getImageFromGallery),
          )
        : Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/back.png"), fit: BoxFit.cover),
            ),
            child: DtetectionPage(
              getImageFromCamera,
              getImageFromGallery,
              Image.file(
                _image!,
                fit: BoxFit.fill,
              ),
            ),
          ));
    stackChildren.addAll(renderBoxes(size));

    if (_busy!) {
      stackChildren.add(const Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Material(
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: stackChildren,
        ),
      ),
    );
  }

  // gets image from camera and runs detectObject
  Future getImageFromCamera() async {
    // _testPreview();
    _testClear();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image!);
  }

  // gets image from gallery and runs detectObject
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        // push2DataBase(label, image)
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image!);
  }

  void push2DataBase(String label, Uint8List image) {
    Picture pic = Picture(label, image);
    var dbHelper = DBHelper();
    dbHelper.savePicture(pic);
  }

  void _testPreview() async {
    var dbHelper = DBHelper();
    Future<List<Picture>> listPics = dbHelper.getPictures();
    List<Picture> awaitList = await listPics;
    // img.Image im = img.decodeImage(awaitList[0].pic)!;
    // Image im = Image.memory(awaitList[0].pic);
    // File file = awaitList[0].pic;
    // DisplayPictureScreen(img: im);
    // File file = File.fromRawPath(awaitList[0].pic);
    log("SIZEEEE: " + awaitList.length.toString());
    Uint8List file = awaitList[0].pic;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen(
          // Pass the automatically generated path to
          // the DisplayPictureScreen widget.
          file: file,
        ),
      ),
    );
  }

  void _testClear() async {
    var dbHelper = DBHelper();
    dbHelper.deleteAll();

    Future<List<Picture>> listPics = dbHelper.getPictures();
    List<Picture> awaitList = await listPics;
    log("SIZEEEE: " + awaitList.length.toString());
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = _image!.path;
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final Uint8List file;

  const DisplayPictureScreen({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("DISPLAY  TEST");
    var color = const Color(0xFF0099FF);
    // var pred =
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.memory(file),
      ],
    ));
  }
}
