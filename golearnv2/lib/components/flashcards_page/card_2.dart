// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:golearnv2/animations/half_flip_animation.dart';
import 'package:golearnv2/components/flashcards_page/card_display.dart';
import 'package:golearnv2/configs/constants.dart';
import 'package:golearnv2/enums/slide_direction.dart';
import 'package:golearnv2/notifiers/flashcards_notifier.dart';
import 'package:provider/provider.dart';

import '../../animations/slide_animation.dart';

class Card2 extends StatelessWidget {
  const Card2({
    Key? key,
  }) : super(key: key);

  //THIS IS THE CODE FOR THE FRONT PAGE OF THE FLASHCARD

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => GestureDetector(
        onHorizontalDragEnd: ((details) {
          if (details.primaryVelocity! > 100) {
            notifier.runSwipeCard2(direction: SlideDirection.leftAway);
            notifier.runSlideCard1();
            notifier.setIgnoreTouch(ignore: true);
            notifier.generateCurrentWord(context: context);
          }

          if (details.primaryVelocity! < -100) {
            notifier.runSwipeCard2(direction: SlideDirection.rightAway);
            notifier.runSlideCard1();
            notifier.setIgnoreTouch(ignore: true);
            notifier.generateCurrentWord(context: context);
          }
        }),
        child: HalfFlipAnimation(
          animate: notifier.flipCard2,
          flipFromHalfWay: true,
          reset: notifier.resetFlipCard2,
          animationCompleted: () {
            notifier.setIgnoreTouch(ignore: false);
          },
          child: SlideAnimation(
            animationCompleted: () {
              notifier.resetCard2();
            },
            reset: notifier.resetSwipeCard2,
            animate: notifier.swipeCard2,
            direction: notifier.swipedDirection,
            child: Center(
              child: Container(
                width: size.width * 0.90,
                height: size.height * 0.70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kCircularBorderRadious),
                  border: Border.all(
                    color: Colors.yellow,
                    width: kCardBorderWidth,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: CardDisplay(isCard1: false),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
