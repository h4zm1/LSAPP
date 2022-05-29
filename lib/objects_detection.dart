import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lsapp/DB/dbhelper.dart';
import 'package:lsapp/DB/picture.dart';
import 'package:lsapp/translation_screen.dart';
import 'package:tflite/tflite.dart';

import 'learn_menu.dart';

class StaticImage extends StatefulWidget {
  @override
  _StaticImageState createState() => _StaticImageState();
}

class _StaticImageState extends State<StaticImage> {
  File? _image;
  List? _recognitions;
  bool? _busy;
  double? _imageWidth, _imageHeight;
  List? picLabels;
  final databaseRef = FirebaseDatabase.instance.reference();
  final picker = ImagePicker();

  int counter = 0;

  // this function loads the model
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/models/ssd_mobilenet.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  // this function detects the objects on the image
  detectObject(File image) async {
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
    double factorY = _imageHeight! / _imageHeight! * MediaQuery.of(context).size.height;

    Color blue = Color.fromRGBO(251, 83, 117, 1);

    return _recognitions!.map((re) {
      // picLabels!.add(re["detectedClass"]);
      if (re["confidenceInClass"] > 0.50) {
        log(re["detectedClass"]);
        log(re["confidenceInClass"].toString());
      }
      log("run once");

      ///TODO display the above list with ted lasson pic
      return Container(
        child: Positioned(
            left: re["rect"]["x"] * factorX,
            top: re["rect"]["y"] * factorY,
            width: re["rect"]["w"] * factorX + 20,
            height: re["rect"]["h"] * factorY,
            child: ((re["confidenceInClass"] > 0.50))
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TranslationScreen(re["detectedClass"])),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: blue,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        // Detected class
                        " ${re["detectedClass"]} ",
                        style: TextStyle(
                          background: Paint()..color = blue,
                          wordSpacing: 3,
                          color: Colors.white,
                          fontSize: 15,
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

    List<Widget> stackChildren = [];
    stackChildren.add(
      // using ternary operator
      _image == null
          ? Stack(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/images/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 250,
                      height: 50,
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      child: Center(
                          child: Text("Please Select an Image",
                              style: TextStyle(
                                color: Color.fromRGBO(251, 83, 117, 1),
                                fontSize: 20,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                              )))),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        FloatingActionButton(
                          backgroundColor: Color.fromRGBO(251, 83, 117, 1),
                          heroTag: "Fltbtn0",
                          child: Center(child: Icon(Icons.arrow_back)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LearMenu()),
                            );
                          },
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                        )),
                        Stack(
                          children: [
                            Row(children: [
                              FloatingActionButton(
                                backgroundColor: Color.fromRGBO(251, 83, 117, 1),
                                heroTag: "Fltbtn2",
                                child: Icon(Icons.camera_alt),
                                onPressed: getImageFromCamera,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              FloatingActionButton(
                                backgroundColor: Color.fromRGBO(251, 83, 117, 1),
                                heroTag: "Fltbtn1",
                                child: Icon(Icons.photo),
                                onPressed: getImageFromGallery,
                              ),
                            ])
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : // if not null then
          Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.file(
                  _image!,
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FloatingActionButton(
                        backgroundColor: Color.fromRGBO(251, 83, 117, 1),
                        heroTag: "Fltbtn0",
                        child: Center(child: Icon(Icons.arrow_back)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LearMenu()),
                          );
                        },
                      ),
                      Expanded(
                          child: Container(
                        height: 1,
                      )),
                      Stack(
                        children: [
                          Row(children: [
                            FloatingActionButton(
                              backgroundColor: Color.fromRGBO(251, 83, 117, 1),
                              heroTag: "Fltbtn2",
                              child: Icon(Icons.camera_alt),
                              onPressed: getImageFromCamera,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FloatingActionButton(
                              backgroundColor: Color.fromRGBO(251, 83, 117, 1),
                              heroTag: "Fltbtn1",
                              child: Icon(Icons.photo),
                              onPressed: getImageFromGallery,
                            ),
                          ])
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
    );

    stackChildren.addAll(renderBoxes(size));

    if (_busy!) {
      stackChildren.add(const Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      /*floatingActionButton: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Color.fromRGBO(251, 83, 117, 1),
            heroTag: "Fltbtn0",
            child: Center(child: Icon(Icons.arrow_back)),
            onPressed: getImageFromCamera,
          ),
          FloatingActionButton(
            backgroundColor: Color.fromRGBO(251, 83, 117, 1),
            heroTag: "Fltbtn2",
            child: Icon(Icons.camera_alt),
            onPressed: getImageFromCamera,
          ),
          FloatingActionButton(
            backgroundColor: Color.fromRGBO(251, 83, 117, 1),
            heroTag: "Fltbtn1",
            child: Icon(Icons.photo),
            onPressed: getImageFromGallery,
          ),
        ],
      ),*/
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: stackChildren,
        ),
      ),
    );
  }

  // gets image from camera and runs detectObject
  Future getImageFromCamera() async {
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
    createData();
    // final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   } else {
    //     print("No image Selected");
    //   }
    // });
    // detectObject(_image!);
  }

  void createData() {
    counter++;
    databaseRef.child("ftd").set({'name': 'na la' + counter.toString(), 'description': 'testDes'});
    log("DATTTTTTAAAAAAAAAAAAAAAAAAAAAAAa");
  }

  void push2DataBase(String label, Uint8List image) {
    Picture pic = Picture(label, image);
    var dbHelper = DBHelper();
    // dbHelper.savePicture(pic);
  }
}
