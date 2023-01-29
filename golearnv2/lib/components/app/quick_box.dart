import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class QuickBox extends StatelessWidget {
  const QuickBox({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  //THIS IS THE CODE FOR THE CHECK ANIMATION IN CONFIRMING

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Dialog(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/images/check-anim.json',
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          )
        ],
      )),
    );
  }
}
