import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:space_learn/learn_menu.dart';
import 'package:translator/translator.dart';

import 'flag_button.dart';
import 'objects_detection.dart';

class TranslationScreen extends StatefulWidget {
  final String? word;

  const TranslationScreen(this.word, {Key? key}) : super(key: key);

  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Color.fromRGBO(255, 255, 255, 0.6),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 150),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        decoration: const BoxDecoration(color: Color.fromRGBO(251, 83, 117, 1)),
                      ),
                      Center(
                        child: Text(inputText!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 57,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                      Positioned(
                        top: -140,
                        child: Center(
                          child: Container(
                            width: 170,
                            height: 170,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('lib/images/book_menu.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlagButton(
                        text: _translatedTexts.isEmpty ? '' : _translatedTexts[0],
                        flag: 'english.png',
                        onTap: () {
                          if (_translatedTexts.isNotEmpty) speak('en-GB', _translatedTexts[0]);
                        },
                      ),
                      SizedBox(
                          child: Container(
                        height: 15,
                      )),
                      FlagButton(
                        text: _translatedTexts.isEmpty ? '' : _translatedTexts[2],
                        flag: 'french.png',
                        onTap: () {
                          if (_translatedTexts.isNotEmpty) speak('fr-FR', _translatedTexts[2]);
                        },
                      ),
                      SizedBox(
                          child: Container(
                        height: 15,
                      )),
                      FlagButton(
                        text: _translatedTexts.isEmpty ? '' : _translatedTexts[1],
                        flag: 'arabic.png',
                        onTap: () {
                          if (_translatedTexts.isNotEmpty) speak("ar-SA", _translatedTexts[1]);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(left: 15),
              child: InkWell(
                child: const CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage('lib/images/return_arrow.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StaticImage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
