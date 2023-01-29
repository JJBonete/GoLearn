// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:golearnv2/animations/fade_in_animation.dart';
import 'package:golearnv2/configs/constants.dart';
import 'package:golearnv2/utils/methods.dart';

class TopicTile extends StatelessWidget {
  const TopicTile({Key? key, required this.topic}) : super(key: key);

  final String topic;

  //THIS IS THE CODE FOR THE LOOK OF THE TILES IN THE MENUN

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      child: GestureDetector(
        onTap: () {
          print('tile tapped $topic');
          loadSession(context: context, topic: topic);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(kCircularBorderRadious)),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Hero(
                        tag: topic,
                        child: Image.asset('assets/images/$topic.png')),
                  )),
              Expanded(
                child: Text(
                  topic,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
