import 'package:flutter/material.dart';
import 'package:golearnv2/enums/settings.dart';
import 'package:golearnv2/notifiers/settings_notifier.dart';
import 'package:golearnv2/utils/methods.dart';
import 'package:provider/provider.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    Key? key,
    required this.displayOption,
    this.disabled = false,
  }) : super(key: key);

  //THIS IS THE CODE FOR THE BUTTONS INSIDE THE SETTINGS BUTTONS

  final Settings displayOption;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (_, notifier, __) => Column(
        children: [
          SwitchListTile(
              inactiveThumbColor: Colors.black.withOpacity(0.50),
              tileColor: disabled
                  ? Colors.black.withOpacity(0.10)
                  : Colors.transparent,
              title: Text(
                displayOption.toText(),
                style: const TextStyle(color: Colors.black),
              ),
              value: notifier.displayOptions.entries
                  .firstWhere((element) => element.key == displayOption)
                  .value,
              onChanged: disabled
                  ? null
                  : (value) {
                      notifier.updateDisplayOptions(
                          displayOption: displayOption, isToggled: value);
                    }),
          const Divider(
            height: 1,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
