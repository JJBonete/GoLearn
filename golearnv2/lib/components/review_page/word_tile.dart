// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:golearnv2/components/app/tts_button.dart';
import 'package:golearnv2/configs/constants.dart';
import 'package:golearnv2/models/word.dart';
import 'package:golearnv2/notifiers/review_notifier.dart';
import 'package:provider/provider.dart';

class WordTile extends StatelessWidget {
  WordTile({
    Key? key,
    required this.word,
    required this.animation,
    this.onPressed,
    required this.index,
  }) : super(key: key);

//THIS IS THE CODE FOR THE WORDS INSIDE THE REVIEW PAGE
  final Word word;

  final Animation animation;
  final _tweenOffsetLeft =
      Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0));
  final _tweenOffsetRight =
      Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
  final VoidCallback? onPressed;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation
          .drive(CurveTween(curve: Curves.easeInOutSine))
          .drive(index % 2 == 0 ? _tweenOffsetRight : _tweenOffsetLeft),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
        child: Consumer<ReviewNotifier>(
          builder: (_, notifier, __) => Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(kCircularBorderRadious),
                border: Border.all(
                  color: Color.fromARGB(255, 1, 85, 205),
                  width: 2,
                )),
            child: ListTile(
              leading: notifier.showImage
                  ? SizedBox(
                      width: 50,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/${word.theword}.png'),
                      ))
                  : SizedBox(),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  notifier.showType
                      ? Text(
                          word.type,
                        )
                      : SizedBox(),
                  notifier.showWord ? Text(word.theword) : SizedBox(),
                ],
              ),
              trailing: SizedBox(
                width: 50,
                child: Row(
                  children: [
                    TTSButton(
                      word: word,
                      iconSize: 25,
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          onPressed?.call();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
