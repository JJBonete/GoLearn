import 'package:flutter/material.dart';
import 'package:golearnv2/animations/fade_in_animation.dart';
import 'package:lottie/lottie.dart';

class MenuGuide extends StatelessWidget {
  const MenuGuide({
    Key? key,
    required this.isFirst,
  }) : super(key: key);

  final bool isFirst;

  //THIS IS THE CODE FOR THE GUIDE BOX INSIDE THE MENU PAGE

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightPadding = size.height * 0.29;
    final widthPadding = size.width * 0.10;
    return FadeInAnimation(
      child: AlertDialog(
        insetPadding: EdgeInsets.fromLTRB(
            widthPadding, heightPadding, widthPadding, heightPadding),
        content: Column(
          children: const [
            Expanded(
              child: Text(
                'Welcome to GoLearn! \n\nPlease select a topic to want to learn. \nTake a random pre-test. \nOr Choose a specific topic.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
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
                  child: const Text('Got it!')),
            ),
          )
        ],
      ),
    );
  }
}
