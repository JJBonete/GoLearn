// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:golearnv2/components/app/tts_button.dart';
import 'package:golearnv2/enums/settings.dart';
import 'package:golearnv2/notifiers/flashcards_notifier.dart';
import 'package:golearnv2/notifiers/settings_notifier.dart';
import 'package:provider/provider.dart';

class CardDisplay extends StatelessWidget {
  const CardDisplay({
    Key? key,
    required this.isCard1,
  }) : super(key: key);

  final bool isCard1;

  //THIS IS THE CODE INTERFACE OF THE CARDS
  //THE SELECTION WHAT YOU WANT TO SEE IN THE CARD 2 OF THE FLASHCARD

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<SettingsNotifier>(
        builder: (_, notifier, __) {
          final audioOnly = notifier.displayOptions.entries
              .firstWhere((element) => element.key == Settings.audioOnly)
              .value;

          final setshowWord = notifier.displayOptions.entries
              .firstWhere((element) => element.key == Settings.showWord)
              .value;

          final setshowType = notifier.displayOptions.entries
              .firstWhere((element) => element.key == Settings.showType)
              .value;

          return Consumer<FlashcardsNotifier>(
            builder: (_, notifier, __) => isCard1
                ? Column(
                    children: [
                      if (audioOnly) ...[
                        TTSButton(
                          word: notifier.word1,
                        )
                      ] else if (setshowType) ...[
                        buildTextBox(notifier.word1.type, context, 1),
                        buildImage(notifier.word1.theword),
                      ] else if (setshowWord) ...[
                        buildImage(notifier.word1.theword),
                      ] else ...[
                        buildImage(notifier.word1.theword),
                      ]
                    ],
                  )
                : Column(
                    children: [
                      if (audioOnly) ...[
                        buildImage(notifier.word2.theword),
                        buildTextBox(notifier.word2.theword, context, 1),
                      ] else if (setshowType) ...[
                        buildTextBox(notifier.word2.type, context, 1),
                        buildImage(notifier.word2.theword),
                        buildTextBox(notifier.word2.theword, context, 1),
                        TTSButton(
                          word: notifier.word1,
                        ),
                      ] else if (setshowWord) ...[
                        buildImage(notifier.word2.theword),
                        buildTextBox(notifier.word2.theword, context, 1),
                        TTSButton(
                          word: notifier.word1,
                        ),
                      ] else ...[
                        buildTextBox(notifier.word2.theword, context, 1),
                      ],
                    ],
                  ),
          );
        },
      ),
    );
  }

  Expanded buildTextBox(String text, BuildContext context, int flex) {
    return Expanded(
        flex: flex,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: FittedBox(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ));
  }

  Expanded buildImage(String image) {
    return Expanded(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset('assets/images/${image}.png'),
        ));
  }
}
