import 'package:flutter/material.dart';
import 'package:golearnv2/notifiers/flashcards_notifier.dart';
import 'package:golearnv2/pages/home_page.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  //THIS IS THE CODE FOR THE APPBAR I MADE

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => AppBar(
        actions: [
          IconButton(
              onPressed: () {
                notifier.reset();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false);
              },
              icon: const Icon(Icons.clear))
        ],
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Hero(
              tag: notifier.topic,
              child: Image.asset('assets/images/${notifier.topic}.png')),
        ),
        title: Text(notifier.topic),
      ),
    );
  }
}
