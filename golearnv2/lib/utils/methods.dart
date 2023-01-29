// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:golearnv2/components/app/guide_box.dart';
import 'package:golearnv2/components/app/menu_guide.dart';
import 'package:golearnv2/components/app/instruction.dart';
import 'package:golearnv2/components/app/quick_box.dart';
import 'package:golearnv2/enums/selection_type.dart';
import 'package:golearnv2/enums/settings.dart';
import 'package:golearnv2/notifiers/flashcards_notifier.dart';
import 'package:golearnv2/notifiers/settings_notifier.dart';
import 'package:golearnv2/pages/flashcards_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

loadSession({
  required BuildContext context,
  required String topic,
}) {
  //THIS WILL BE THE CLASS FOR ALL THE MAIN METHODS
  // THE LOGICS TO NAVIGATING TO A NEW PAGE
  // HELPER METHODS

  Navigator.of(context).pushReplacement(
      //THIS IS A NAVIGATOR TO TRANSFER TO A NEW PAGE
      MaterialPageRoute(builder: (context) => FlashcardsPage()));
  Provider.of<FlashcardsNotifier>(context, listen: false)
      .setTopic(topic: topic);
}

// THIS CODES ARE CONNECTD TO THE SETTINGS PAGE
extension SettingsToText on Settings {
  toText() {
    switch (this) {
      case Settings.topicFirst:
        return 'Show Topic First';

      case Settings.showWord:
        return 'Show Image';

      case Settings.audioOnly:
        return 'Test Listening';

      case Settings.showType:
        return 'Show Type';
    }
  }
}

//THIS CODES ARE CONNECTED TO THE REVIEW PAGE
extension SelectSymbol on SelectionType {
  String toSymbol() {
    switch (this) {
      case SelectionType.image:
        return '🖼️';
      case SelectionType.word:
        return 'Word';
      case SelectionType.type:
        return 'Type';
    }
  }
}

updatePreferencesOnRestart({required BuildContext context}) {
  final settingsNotifier =
      Provider.of<SettingsNotifier>(context, listen: false);

  for (var e in settingsNotifier.displayOptions.entries) {
    SharedPreferences.getInstance().then((prefs) {
      final result = prefs.getBool(e.key.name);
      if (result != null) {
        settingsNotifier.displayOptions.update(e.key, (value) => result);
      }
    });
  }
}

//THIS CODES BELOW ARE FOR THE DIALOG BOX
clearPreferences() async {
  SharedPreferences.getInstance().then((prefs) {
    for (var e in SettingsNotifier().displayOptions.entries) {
      prefs.remove(e.key.name);
      prefs.remove('popup');
      prefs.remove('guidebox');
      prefs.remove('instruction');
      prefs.remove('menuguide');
    }
  });
}

runGuideBox({required BuildContext context, required bool isFirst}) {
  if (!isFirst) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('guidebox', true);
    });
  }

  Future.delayed(Duration(milliseconds: 1200), () {
    showDialog(
        context: context,
        builder: (context) => GuideBox(
              isFirst: isFirst,
            ));
  });
}

runInstruction({required BuildContext context, required bool isFirst}) {
  if (!isFirst) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('instruction', true);
    });
  }

  Future.delayed(Duration(milliseconds: 1200), () {
    showDialog(
        context: context,
        builder: (context) => Instruction(
              isFirst: isFirst,
            ));
  });
}

runMenuGuide({required BuildContext context, required bool isFirst}) {
  if (!isFirst) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('menuguide', true);
    });
  }

  Future.delayed(Duration(milliseconds: 1200), () {
    showDialog(
        context: context,
        builder: (context) => MenuGuide(
              isFirst: isFirst,
            ));
  });
}

runQuickBox({required BuildContext context, required String text}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => QuickBox(
            text: text,
          ));
  Future.delayed(Duration(milliseconds: 1000), () {
    Navigator.maybePop(context);
  });
}
