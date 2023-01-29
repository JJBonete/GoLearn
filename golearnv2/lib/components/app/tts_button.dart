// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:golearnv2/models/word.dart';
import 'package:text_to_speech/text_to_speech.dart';

class TTSButton extends StatefulWidget {
  const TTSButton({Key? key, required this.word, this.iconSize = 50})
      : super(key: key);

  final Word word;
  final double iconSize;

  //THIS IS THE CODE FOR THE TEXT TO SPEECH BUTTON
  //IT CONVERTS THE WORD TO A TEXT TO SPEECH VOICE

  @override
  State<TTSButton> createState() => _TTSButtonState();
}

class _TTSButtonState extends State<TTSButton> {
  bool _isTapped = false;
  TextToSpeech _tts = TextToSpeech();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _setUpTts();
    });

    super.initState();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: IconButton(
            onPressed: () {
              _runTts(text: widget.word.sentence);
              _isTapped = true;
              setState(() {});
              Future.delayed(const Duration(milliseconds: 500), () {
                _isTapped = false;
                setState(() {});
              });
            },
            icon: Icon(
              Icons.audiotrack,
              size: widget.iconSize,
              color: _isTapped ? Colors.yellow : Colors.white,
            )));
  }

  _setUpTts() async {
    await _tts.setLanguage('en-US-Neural2-H');
    await _tts.setRate(0.5);
    await _tts.setPitch(1);
  }

  _runTts({required String text}) async {
    await _tts.speak(text);
  }
}
