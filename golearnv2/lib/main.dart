import 'package:flutter/material.dart';
import 'package:golearnv2/configs/themes.dart';
import 'package:golearnv2/notifiers/flashcards_notifier.dart';
import 'package:golearnv2/notifiers/review_notifier.dart';
import 'package:golearnv2/notifiers/settings_notifier.dart';
import 'package:golearnv2/splashscreen.dart';
import 'package:provider/provider.dart';
import 'utils/methods.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FlashcardsNotifier()),
    ChangeNotifierProvider(create: (_) => SettingsNotifier()),
    ChangeNotifierProvider(create: (_) => ReviewNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    updatePreferencesOnRestart(context: context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoLearn',
      theme: appTheme,
      home: const Splashscreen(),
    );
  }
}
