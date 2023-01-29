// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:golearnv2/animations/fade_in_animation.dart';
import 'package:lottie/lottie.dart';

class Instruction extends StatelessWidget {
  const Instruction({
    Key? key,
    required this.isFirst,
  }) : super(key: key);

  final bool isFirst;

  //THIS IS THE CODE FOR THE GUIDE BOX INSIDE THE REVIEW PAGE

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightPadding = size.height * 0.13;
    final widthPadding = size.width * 0.10;
    return FadeInAnimation(
      child: AlertDialog(
        insetPadding: EdgeInsets.fromLTRB(
            widthPadding, heightPadding, widthPadding, heightPadding),
        content: Column(
          children: const [
            Expanded(
              child: Text(
                'Instruction:\n\nTest All:\n    Test all the saved incorrect cards.\n\nQuick Test:\n    Test 5 random cards\n\nClear Cards:\n     To clear all the saved cards.     \n\n\nBelow are choices to challenge your skill in guessing the cards above.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            )
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
                    Lottie.asset('assets/images/check-anim.json');
                  },
                  child: Text('Got it!')),
            ),
          )
        ],
      ),
    );
  }
}
