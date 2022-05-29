import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lsapp/translation/translation_row.dart';
import 'package:translator/translator.dart';

class TranslationPage extends StatefulWidget {
  final String? word;
  TranslationPage(this.word);

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  FlutterTts flutterTts = FlutterTts();
  GoogleTranslator translator = GoogleTranslator();
  String? inputText = "";
  bool _loading = false;
  List<String> _translatedTexts = [];
  final List<String> _languagesCode = [
    'en',
    "ar",
    'fr',
  ];
  Future translate() async {
    List<String> translatedTexts = [];
    setState(() {
      _loading = true;
    });
    for (String code in _languagesCode) {
      Translation translation = await translator.translate(inputText!, to: code);
      String translatedText = translation.text;
      translatedTexts.add(translatedText);
    }
    setState(() {
      _translatedTexts = translatedTexts;
      _loading = false;
      print(_translatedTexts);
    });
  }

  Future speak(String languageCode, String text) async {
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setPitch(1);
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    inputText = widget.word;
    if (inputText!.isNotEmpty) translate();
  }

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Stack(children: [
        Container(
          height: mediaHeight,
          width: mediaWidth,
          decoration: BoxDecoration(
            color: Color.fromRGBO(71, 10, 89, 1),
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
              image: AssetImage("assets/back.png"),
            ),
          ),
          child: Center(
            child: Container(
                height: mediaHeight * 0.56,
                width: mediaWidth * 0.9,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        iconSize: mediaWidth * 0.15,
                        icon: Image.asset('assets/close.png'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 40),
                        height: mediaHeight * 0.5,
                        width: mediaWidth * 0.8,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/blue.png"), fit: BoxFit.contain),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TranslationRow(
                              _translatedTexts.isEmpty ? '' : _translatedTexts[1],
                              "assets/arabe.png",
                              () {
                                if (_translatedTexts.isNotEmpty) speak("ar-SA", _translatedTexts[1]);
                              },
                            ),
                            TranslationRow(
                              _translatedTexts.isEmpty ? '' : _translatedTexts[0],
                              "assets/eng.png",
                              () {
                                if (_translatedTexts.isNotEmpty) speak('en-GB', _translatedTexts[0]);
                              },
                            ),
                            TranslationRow(
                              _translatedTexts.isEmpty ? '' : _translatedTexts[2],
                              "assets/frc.png",
                              () {
                                if (_translatedTexts.isNotEmpty) speak('fr-FR', _translatedTexts[2]);
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ]),
    );
  }
}
