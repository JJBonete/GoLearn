// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:golearnv2/components/flashcards_page/results_box.dart';
import 'package:golearnv2/configs/constants.dart';
import 'package:golearnv2/data/words.dart';
import 'package:golearnv2/enums/slide_direction.dart';
import 'package:golearnv2/models/word.dart';

//LOGIC CODES OF THE FLASH CARD

class FlashcardsNotifier extends ChangeNotifier {
  int roundTally = 0,
      cardTally = 0,
      correctTally = 0,
      incorrectTally = 0,
      correctPercentage = 0;
  double percentComplete = 0.0;

  calculateCorrectPercentage() {
    final percentage = correctTally / cardTally;
    correctPercentage = (percentage * 100).round();
  }

  calculateCompletedPercent() {
    percentComplete = (correctTally + incorrectTally) / cardTally;
    notifyListeners();
  }

  resetProgressBar() {
    percentComplete = 0.0;
    notifyListeners();
  }

  List<Word> incorrectCards = [];
  String topic = " ";
  Word word1 =
      Word(topic: "", theword: "Loading Arrow", type: '', sentence: '');
  Word word2 =
      Word(topic: "", theword: "Loading Arrow", type: '', sentence: '');
  List<Word> selectedWords = [];

  bool isFirstRound = true,
      isRoundCompleted = false,
      isSessionCompleted = false;

  reset() {
    resetCard1();
    resetCard2();
    incorrectCards.clear();
    isFirstRound = true;
    isRoundCompleted = false;
    isSessionCompleted = false;
    roundTally = 0;
  }

  setTopic({required String topic}) {
    this.topic = topic;
    notifyListeners();
  }

  generateAllSelectedWords() {
    words.shuffle();

    isRoundCompleted = false;
    if (isFirstRound) {
      if (topic == 'Random 5') {
        selectedWords.clear();
        for (int i = 0; i < 5; i++) {
          selectedWords.add(words[i]);
        }
      } else if (topic == 'Random 20') {
        selectedWords.clear();
        for (int i = 0; i < 20; i++) {
          selectedWords.add(words[i]);
        }
      } else if (topic == 'Random 50') {
        selectedWords.clear();
        for (int i = 0; i < 50; i++) {
          selectedWords.add(words[i]);
        }
      } else if (topic == 'Test All') {
        selectedWords.clear();
        selectedWords = words.toList();
      } else if (topic != 'Review') {
        selectedWords.clear();
        selectedWords =
            words.where((element) => element.topic == topic).toList();
      }
    } else {
      selectedWords = incorrectCards.toList();
      incorrectCards.clear();
    }
    roundTally++;
    cardTally = selectedWords.length;
    correctTally = 0;
    incorrectTally = 0;
    resetProgressBar();
  }

  generateCurrentWord({required BuildContext context}) {
    if (selectedWords.isNotEmpty) {
      final r = Random().nextInt(selectedWords.length);
      word1 = selectedWords[r];
      selectedWords.removeAt(r);
    } else {
      if (incorrectCards.isEmpty) {
        isSessionCompleted = true;
        // ignore: avoid_print
        print('session completed: $isSessionCompleted');
      }

      isRoundCompleted = true;
      isFirstRound = false;
      calculateCorrectPercentage();

      Future.delayed(Duration(milliseconds: 500), () {
        showDialog(context: context, builder: (context) => ResultsBox());
      });
    }

    Future.delayed(const Duration(milliseconds: kSlideAwayDuration), () {
      word2 = word1;
    });
  }

  updateCardOutcome({required Word word, required bool isCorrect}) {
    if (!isCorrect) {
      incorrectCards.add(word);
      incorrectTally++;
    } else {
      correctTally++;
    }
    calculateCompletedPercent();
    notifyListeners();
  }

// THIS IS THE ANIMATION CODE FOR THE FLASHCARDS

  bool ignoreTouches = true;

  setIgnoreTouch({required bool ignore}) {
    ignoreTouches = ignore;
    notifyListeners();
  }

  SlideDirection swipedDirection = SlideDirection.none;

  bool slideCard1 = false,
      flipCard1 = false,
      flipCard2 = false,
      swipeCard2 = false;

  bool resetSlideCard1 = false,
      resetFlipCard1 = false,
      resetFlipCard2 = false,
      resetSwipeCard2 = false;

  runSlideCard1() {
    resetSlideCard1 = false;
    slideCard1 = true;
    notifyListeners();
  }

  runFlipCard1() {
    resetFlipCard1 = false;
    flipCard1 = true;
    notifyListeners();
  }

  resetCard1() {
    resetFlipCard1 = true;
    resetSlideCard1 = true;
    slideCard1 = false;
    flipCard1 = false;
  }

  runFlipCard2() {
    resetFlipCard2 = false;
    flipCard2 = true;
    notifyListeners();
  }

  runSwipeCard2({required SlideDirection direction}) {
    updateCardOutcome(
        word: word2, isCorrect: direction == SlideDirection.leftAway);
    swipedDirection = direction;
    resetSwipeCard2 = false;
    swipeCard2 = true;
    notifyListeners();
  }

  resetCard2() {
    resetFlipCard2 = true;
    resetSwipeCard2 = true;
    flipCard2 = false;
    swipeCard2 = false;
  }
}
