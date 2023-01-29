// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:golearnv2/animations/fade_in_animation.dart';
import 'package:lottie/lottie.dart';

class GuideBox extends StatelessWidget {
  const GuideBox({
    Key? key,
    required this.isFirst,
  }) : super(key: key);

  final bool isFirst;

  //THIS IS THE CODE FOR THE GUIDE BOX INSIDE THE FLASHCARD PAGE

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightPadding = size.height * 0.20;
    final widthPadding = size.width * 0.10;
    return FadeInAnimation(
      child: AlertDialog(
        insetPadding: EdgeInsets.fromLTRB(
            widthPadding, heightPadding, widthPadding, heightPadding),
        content: Column(
          children: [
            if (isFirst) ...[
              Text(
                'Double Tap\nTo Reveal Answer',
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Lottie.asset(
                  'assets/images/DoubleTap1.json',
                ),
              )
            ] else ...[
              Expanded(
                child: Row(
                  children: [
                    GuideSwipe(
                      isLeft: true,
                    ),
                    GuideSwipe(
                      isLeft: false,
                    ),
                  ],
                ),
              )
            ]
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: size.width * 0.50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  child: Text('Got it!')),
            ),
          )
        ],
      ),
    );
  }
}

class GuideSwipe extends StatelessWidget {
  const GuideSwipe({
    Key? key,
    required this.isLeft,
  }) : super(key: key);

  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        isLeft
            ? Text(
                'Swipe Left\nIf Incorrect',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            : Text(
                'Swipe Right\nIf Correct',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
        Expanded(
            child: isLeft
                ? Lottie.asset('assets/images/SwipeLeft1.json')
                : Lottie.asset('assets/images/SwipeRight1.json'))
      ],
    ));
  }
}
