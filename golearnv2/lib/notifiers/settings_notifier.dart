import 'package:flutter/material.dart';
import 'package:golearnv2/enums/settings.dart';
import 'package:golearnv2/utils/methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends ChangeNotifier {
  Map<Settings, bool> displayOptions = {
    Settings.showWord: true,
    Settings.audioOnly: false,
    Settings.showType: false,
  };

  //THIS IS THE CODE FOR THE SETTINGS PAGE

  updateDisplayOptions(
      {required Settings displayOption, required bool isToggled}) {
    displayOptions.update(displayOption, (value) => isToggled);
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(displayOption.name, isToggled);
    });
    notifyListeners();
  }

  resetSettings() {
    displayOptions.update(Settings.showWord, (value) => true);
    displayOptions.update(Settings.showType, (value) => false);
    displayOptions.update(Settings.audioOnly, (value) => false);
    clearPreferences();
    notifyListeners();
  }
}
